var ConvertLib = artifacts.require("./ConvertLib.sol");
var MetaCoin = artifacts.require("./MetaCoin.sol");
<<<<<<< HEAD
var People = artifacts.require("./People.sol");
=======
var People = artifacts.require("./People.sol")
>>>>>>> updated insurance contract
var InsurancePolicy = artifacts.require("./InsurancePolicy.sol");

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, MetaCoin);
  deployer.deploy(MetaCoin);
  deployer.deploy(People);
  deployer.deploy(InsurancePolicy);
};
