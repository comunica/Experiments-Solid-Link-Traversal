export class LoggerCollectLinks {
    constructor(queryId) {
        this.urls = [];
        this.queryId = queryId;
    }

    getUrls() {
        return this.urls.filter((v, i, a) => a.indexOf(v) === i);
    }

    handle(message, data) {
        if (data.actor === 'urn:comunica:default:http/actors#fetch') {
            this.urls.push(message.replace('Requesting ', ''));
        }
    }
    trace(message, data) {
        this.handle(message, data);
    }
    debug(message, data) {
        this.handle(message, data);
    }
    info(message, data) {
        this.handle(message, data);
    }
    warn(message, data) {
        this.handle(message, data);
    }
    error(message, data) {
        this.handle(message, data);
    }
    fatal(message, data) {
        this.handle(message, data);
    }
}
