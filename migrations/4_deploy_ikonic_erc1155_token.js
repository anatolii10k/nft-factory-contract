const IkonicToken = artifacts.require("IkonicERC1155Token");
// const secret = require("../secret.json");
const secretTestnet = require("../secret.testnet.json");

module.exports = function(deployer, network) {
  if (network != "rinkeby") {
  //   deployer.deploy(
  //     IkonicToken,
  //     "Ikonic1155",
  //     "IKONIC1155",
  //     secret.signerAddress,
  //     "https://api.ikonic.co/contractMetadata/{address}", // contractURI
  //     "IKONIC_", // tokenURIPrefix
  //     "https://ipfs.ikonic.co" // uri // TODO: IPFS
  //   );
    deployer.deploy(
      IkonicToken,
      "Ikonic1155",
      "IKONIC1155",
      "https://api-testnet.ikonic.co/contractMetadata/{address}", // contractURI
      "IKONIC_", // tokenURIPrefix
      "https://ipfs.ikonic.co" // uri // TODO: IPFS
    );
  }
};
