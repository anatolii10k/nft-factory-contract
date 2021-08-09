const ERC1155Sale = artifacts.require("ERC1155Sale");
const TransferProxy = artifacts.require("TransferProxy");
const ERC1155SaleNonceHolder = artifacts.require("ERC1155SaleNonceHolder");
const ServiceFeeProxy = artifacts.require("ServiceFeeProxy");

const secretTestnet = require("../secret.testnet.json");

module.exports = async function (deployer) {
    await deployer.deploy(ERC1155SaleNonceHolder);

    await deployer.deploy(
        ERC1155Sale,
        secretTestnet.transferProxyAddress,
        ERC1155SaleNonceHolder.address,
        secretTestnet.serviceFeeProxyAddress,
    );
};

