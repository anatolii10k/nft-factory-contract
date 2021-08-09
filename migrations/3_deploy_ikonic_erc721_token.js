const IkonicToken = artifacts.require("IkonicERC721Token");
// const secret = require("../secret.json");
const secretTestnet = require("../secret.testnet.json");

module.exports = function(deployer, network) {
  if (network != "rinkeby") {
  //   deployer.deploy(
  //     IkonicToken,
  //     "Ikonic721",
  //     "IKONIC721",
  //     secret.fromAddress,
  //     secret.signerAddress,
  //     "https://api.ikonic.co/contractMetadata/{address}", // contractURI
  //     "https://ipfs.ikonic.co" // uri // TODO: IPFS
  //   );
    deployer.deploy(
      IkonicToken,
      "Ikonic721",
      "IKONIC721",
      "https://api-testnet.ikonic.co/contractMetadata/{address}", // contractURI
      "https://ipfs.ikonic.co" // uri // TODO: IPFS
    );
  }
};
