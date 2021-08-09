const TransferProxy = artifacts.require("TransferProxy");

module.exports = async function(deployer, network) {
  // if (network == "rinkeby") {
    await deployer.deploy(TransferProxy);
  // }
};
