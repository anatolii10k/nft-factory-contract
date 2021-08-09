const IkonicToken = artifacts.require("IkonicToken");

module.exports = function(deployer, network) {
  console.log("networksasdfasdf",network);
  if (network != "rinkeby") {
    deployer.deploy(
        IkonicToken,
    );
  }
};
