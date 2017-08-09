var ConvertLib = artifacts.require("./ConvertLib.sol");
var MetaCoin = artifacts.require("./MetaCoin.sol");
var People = artifacts.require("./People.sol");
var InsurancePolicy = artifacts.require("./InsurancePolicy.sol");
var Attendance = artifacts.require('./Attendance.sol')

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, MetaCoin);
  deployer.deploy(MetaCoin);
  deployer.deploy(People);
  deployer.deploy(InsurancePolicy);
  deployer.deploy(Attendance);
};
