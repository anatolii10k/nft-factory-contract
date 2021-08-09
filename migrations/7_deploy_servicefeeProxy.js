const ServiceFeeProxy = artifacts.require("ServiceFeeProxy");

module.exports = async function (deployer, network) {
    await deployer.deploy(ServiceFeeProxy);

    // serviceFeeProxyInstance = await ServiceFeeProxy.deployed();
    // ServiceFeeInstance = await ServiceFee.deployed();

    // await ServiceFeeInstance.addProxy(
    //     ServiceFee.address, 
    //     { from: secretTestnet.fromAddress }
    // );
    // await serviceFeeProxyInstance.setServiceFeeContract(
    //     ServiceFeeInstance.address,
    //     { from: secretTestnet.fromAddress }
    // );
    // await serviceFeeProxyInstance.setServiceFeeRecipient(
    //     secretTestnet.serviceFeeRecipientAddress,
    //     { from: secretTestnet.fromAddress }
    // );

    // await ServiceFeeInstance.setIkonicTokenContract(
    //     secretTestnet.ikonicTokenAddress
    // );
};
