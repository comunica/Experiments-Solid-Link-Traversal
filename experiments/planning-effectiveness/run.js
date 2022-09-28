import { QueryEngine as QueryEngineBase } from '@comunica/query-sparql';
import { QueryEngine as QueryEngineLinkTraversal } from '@comunica/query-sparql-link-traversal-solid';
import { LoggerCollectLinks } from './lib/LoggerCollectLinks.js';
import rdfDereferencer from "rdf-dereference";
import N3 from "n3";
import * as fs from "fs/promises";
import * as Path from "path";

const OMIT_QUERIES = {
    6: [0, 3],
    7: [0, 3],
};

(async function run(){
    console.log(`| Query | Integrated | Two-phase | Dereferencing | HTTP Requests |`);
    console.log(`| --- | --: | --: | --: | --: |`);

    let queryId = 0;
    for (const queryFile of await fs.readdir('queries')) {
        queryId++;

        let queries = (await fs.readFile(Path.join('queries', queryFile), 'utf-8')).split('\n\n');

        // Check if we should omit queries
        if (OMIT_QUERIES[queryId]) {
            for (const removeId of OMIT_QUERIES[queryId].reverse()) {
                queries.splice(removeId, 1);
            }
        }

        let timeLinkTraversalTotal = 0;
        let timeDerefAndIndexTotal = 0;
        let timeIndexedTotal = 0;
        let linksMax = 0;

        for (const query of queries) {
            const [ links, timeLinkTraversal ] = await queryLinkTraversal(query, queryId);
            const [ index, timeDerefAndIndex ] = await indexDocuments(links);
            const timeIndexed = await queryIndexed(query, index);

            timeLinkTraversalTotal += timeLinkTraversal;
            timeDerefAndIndexTotal += timeDerefAndIndex;
            timeIndexedTotal += timeIndexed;
            linksMax = Math.max(linksMax, links.length);
        }

        timeLinkTraversalTotal /= queries.length;
        timeDerefAndIndexTotal /= queries.length;
        timeIndexedTotal /= queries.length;

        console.log(`| D${queryId} | ${timeLinkTraversalTotal.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })} | ${(timeDerefAndIndexTotal + timeIndexedTotal).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })} | ${(timeDerefAndIndexTotal / (timeDerefAndIndexTotal + timeIndexedTotal) * 100).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}% | ${linksMax} |`);
    }

//     const query = `PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
// PREFIX snvoc: <http://localhost:3000/www.ldbc.eu/ldbc_socialnet/1.0/vocabulary/>
// SELECT ?messageId ?messageCreationDate ?messageContent WHERE {
//   ?message snvoc:hasCreator <http://localhost:3000/pods/00000000000000000933/profile/card#me>;
//     rdf:type snvoc:Post;
//     snvoc:content ?messageContent;
//     snvoc:creationDate ?messageCreationDate;
//     snvoc:id ?messageId.
// }`;
//
//     const [ links, timeLinkTraversal ] = await queryLinkTraversal(query);
//     const [ index, timeDerefAndIndex ] = await indexDocuments(links);
//     const timeIndexed = await queryIndexed(query, index);
//
//     console.log(`| Query | Traversal-based query | Index-based query | Dereference percentage for index-based |`);
//     console.log(`| --- | --- | --- | --- |`);
//     console.log(`| D? | ${timeLinkTraversal} | ${timeDerefAndIndex + timeIndexed} | ${timeDerefAndIndex / (timeDerefAndIndex + timeIndexed) * 100}% |`);
})();

async function queryLinkTraversal(query, queryId) {
    const queryEngine = new QueryEngineLinkTraversal();
    const log = new LoggerCollectLinks(queryId);
    await queryEngine.invalidateHttpCache();
    const hrstart = process.hrtime();
    await (await queryEngine.queryBindings(query, { log, lenient: true })).toArray();
    return [ log.getUrls(), countTimeMs(hrstart) ];
}

async function indexDocuments(urls) {
    const store = new N3.Store();
    const hrstart = process.hrtime();
    await Promise.all(urls.map(url => new Promise(async(resolve, reject) => {
        try {
            const {data} = await rdfDereferencer.default.dereference(url);
            data.on('data', (quad) => store.addQuad(quad))
                .on('error', reject)
                .on('end', resolve);
        } catch {
            // Ignore 404's
            resolve();
        }
    })));
    return [ store, countTimeMs(hrstart) ];
}

async function queryIndexed(query, store) {
    const queryEngine = new QueryEngineBase();
    const hrstart = process.hrtime();
    await (await queryEngine.queryBindings(query, { sources: [ store ] })).toArray();
    return countTimeMs(hrstart);
}

function countTimeMs(hrstart) {
    const hrend = process.hrtime(hrstart);
    return hrend[0] * 1_000 + hrend[1] / 1_000_000;
}
