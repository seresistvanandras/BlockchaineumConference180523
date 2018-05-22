var Election = artifacts.require("./Election.sol");

module.exports = function(deployer) {
    deployer.deploy(Election, "How much do you like Blockchaineum 2.0?");
};
