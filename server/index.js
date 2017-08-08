var express = require('express');
var bodyParser = require('body-parser');
var Promise = require('bluebird');
var Web3 = require('web3');
// var items = require('../database-mysql');
var app = express();

var web3 = new Web3();
web3.setProvider(new web3.providers.HttpProvider("http://127.0.0.1:8545"));

app.use(express.static(__dirname + '/../react-client/dist'));

app.get('/accounts', (req, res) => {
  web3.eth.getAccounts((err, acc) => {
    if (err) {
      throw err;
    } else {
      var data = [];
      acc.forEach((item, index) => {
        var obj = {};
        var bal;
        obj['account'] = item;
        web3.eth.getBalance(item, 'latest', (err, bal) => {
          if (err) {
            throw err;
          } else {
            obj['balance'] = bal;
            data.push(obj);
            if (data.length === acc.length) {
              res.json(data);
            }
          }
        })
      })
    }
  })
});


app.listen(3000, function() {
  console.log('listening on port 3000!');
});

