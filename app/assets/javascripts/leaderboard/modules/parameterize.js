String.prototype.parameterize = function () {
     return this.trim().replace(/[^a-zA-Z0-9-\s]/g, '').replace(/[^a-zA-Z0-9-]/g, '-').toLowerCase();
}