const ERC721Sale = artifacts.require("ERC721Sale");
const ERC721SaleNonceHolder = artifacts.require("ERC721SaleNonceHolder");

const secretTestnet = require("../secret.testnet.json");

module.exports = async function (deployer) {
    await deployer.deploy(ERC721SaleNonceHolder);

    await deployer.deploy(
        ERC721Sale,
        secretTestnet.transferProxyAddress,
        ERC721SaleNonceHolder.address,
        secretTestnet.serviceFeeProxyAddress,
    );
};
