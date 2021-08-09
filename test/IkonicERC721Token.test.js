const IkonicERC721Token = artifacts.require("IkonicERC721Token");
const { soliditySha3 } = require("web3-utils");
const { account_private_keys } = require("../keys.json");

contract("IkonicERC721Token", accounts => {
    var contract;

    beforeEach(function() {
        return IkonicERC721Token.new(
            "Ikonic721",
            "Ikonic721",
            "https://api-testnet.ikonic.co/contractMetadata/{address}",
            "https://ipfs.ikonic.co",
            { from: accounts[0] }
        )
        .then(function(instance) {
            contract = instance;
        });
    });

    describe("is created correctly", () => {
        it("name and symbol are set correctly", async ()=>{
            const name = await contract.name();
            const symbol = await contract.symbol();
            assert.equal(name, 'Ikonic721');
            assert.equal(symbol, 'Ikonic721');
        });
    });

    describe("mint", () => {
        it("works for the signer of the contract", async ()=>{
            const tokenId = "0x0f961e819bd51a8f1fd5a5f74e4a256513210caf2ade63cd25c7e4c654174612"; // Randomly chosen
            
            const fees = [];
            const tokenURI = "fakeTokenURI";

            await contract.mint(tokenId, fees, tokenURI, {from: accounts[1]});
        });

        it("works for minting multiple", async ()=>{
            const tokenId = "0x0f961e819bd51a8f1fd5a5f74e4a256513210caf2ade63cd25c7e4c654174612"; // Randomly chosen
            
            const fees = [{recipient: accounts[0], value: 20}];
            const tokenURI = "fakeTokenURI";

            await contract.mint(tokenId, fees, tokenURI, {from: accounts[1]});
        });

    });
});
