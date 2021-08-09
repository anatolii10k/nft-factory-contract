const IkonicERC1155Token = artifacts.require("IkonicERC1155Token");
const { soliditySha3, BN } = require("web3-utils");
const { account_private_keys } = require("../keys.json");

contract("IkonicERC1155Token", accounts => {
    var contract;

    beforeEach(function () {
        return IkonicERC1155Token.new(
            "Ikonic1155",
            "IKONIC1155",
            "https://api-testnet.ikonic.co/contractMetadata/{address}", // contractURI
            "IKONIC_", // tokenURIPrefix
            "Ikonic_", // uri
            { from: accounts[0] }
        )
            .then(function (instance) {
                contract = instance;
            });
    });

    describe("is created correctly", () => {
        it("name and symbol are set correctly", async () => {
            const name = await contract.name();
            const symbol = await contract.symbol();
            assert.equal(name, 'Ikonic1155');
            assert.equal(symbol, 'IKONIC1155');
        });
    });

    describe("mint with mutiple supply", () => {
        it("works for the signer of the contract", async () => {
            const tokenId = "0x0f961e819bd51a8f1fd5a5f74e4a256513210caf2ade63cd25c7e4c654174612"; // Randomly chosen
            
            const fees = [{recipient: accounts[0], value: 20}];
            const supply = 100;
            const tokenURI = "fakeTokenURI";

            await contract.mint(tokenId, fees, supply, tokenURI, { from: accounts[1] });
            const amount = new BN(await contract.balanceOf(accounts[1], tokenId, { from: accounts[1] })).toNumber();
            assert.equal(amount, 100);
        });
    });

});
