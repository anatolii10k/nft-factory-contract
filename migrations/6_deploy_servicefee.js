const ServiceFee = artifacts.require("ServiceFee");

module.exports = async function (deployer, network) {
    // if (network != "rinkeby") {
        await deployer.deploy(
            ServiceFee
        );
    // }
};
