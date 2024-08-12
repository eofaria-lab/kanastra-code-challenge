let chai = require('chai');
let chaiHttp = require('chai-http');

chai.use(chaiHttp);

describe('Testando app do code challenge', () => {
  var server;
  beforeEach(function () {
    server = require('../src/app');
  });
  afterEach(function () {
    server.close();
  });

  it('Testando pagina inicial', (done) => {
    chai.request(server)
        .get('/')
        .end((err, res) => {
            chai.expect(res).to.have.status(200);
            chai.expect(res.text).to.contain('Hello World!');
          done();
        });
  });

  it('Testando healthcheck', (done) => {
    chai.request(server)
        .get('/health/check')
        .end((err, res) => {
            chai.expect(res).to.have.status(200);
            chai.expect(res.text).to.equal('OK');
          done();
        });
  });

});
