// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "../interfaces/IIkonictoken.sol";

/**
 * @notice Service Fee contract for Ikonic NFT Marketplace
 */
contract ServiceFee is AccessControl {
    using Address for address;

    /// @notice service fee contract
    IIkonicToken public ikonicTokenContract;

    bytes32 public constant PROXY_ROLE = keccak256("PROXY_ROLE");

    /// @notice Service fee recipient address
    address payable public serviceFeeRecipient;

    event ServiceFeeRecipientChanged(address payable serviceFeeRecipient);

    event IkonicTokenContractUpdated(address ikonicTokenContract);

    modifier onlyAdmin() {
        require(
            hasRole(DEFAULT_ADMIN_ROLE, _msgSender()),
            "Ownable: caller is not the admin"
        );
        _;
    }

    modifier onlyProxy() {
        require(
            hasRole(PROXY_ROLE, _msgSender()),
            "Ownable: caller is not the proxy"
        );
        _;
    }

    /**
     * @dev Constructor Function
    */
    constructor() {
        require(
            _msgSender() != address(0),
            "Auction: Invalid Platform Fee Recipient"
        );

        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
    }

    /**
     * @notice Lets admin set the ikonic token contract
     * @param _ikonicTokenContract address of Ikonic token contract
     */
    function setIkonicTokenContract(address _ikonicTokenContract) onlyAdmin external {
        require(
            _ikonicTokenContract != address(0),
            "ServiceFee.setIkonicTokenContract: Zero address"
        );
        ikonicTokenContract = IIkonicToken(_ikonicTokenContract);
        emit IkonicTokenContractUpdated(_ikonicTokenContract);
    }

    /**
     * @notice Admin can add proxy address
     * @param _proxyAddr address of proxy
     */
    function addProxy(address _proxyAddr) onlyAdmin external {
        require(
            _proxyAddr.isContract(),
            "ServiceFee.addProxy: address is not a contract address"
        );
        grantRole(PROXY_ROLE, _proxyAddr);
    }

    /**
     * @notice Admin can remove proxy address
     * @param _proxyAddr address of proxy
     */
    function removeProxy(address _proxyAddr) onlyAdmin external {
        require(
            _proxyAddr.isContract(),
            "ServiceFee.removeProxy: address is not a contract address"
        );
        revokeRole(PROXY_ROLE, _proxyAddr);
    }

    /**
     * @notice Calculate the seller service fee in according to the business logic and returns it
     * @param _seller address of seller
     */
    function getSellServiceFeeBps(address _seller) external view onlyProxy returns (uint256) {
        require(
            _seller != address(0),
            "ServiceFee.getSellServiceFeeBps: Zero address"
        );
        
        // uint256 balance = ikonicTokenContract.balanceOf(_seller);
        
        return 200;
    }

    /**
     * @notice Calculate the buyer service fee in according to the business logic and returns it
     * @param _buyer address of buyer
     */
    function getBuyServiceFeeBps(address _buyer) onlyProxy external view returns (uint256) {
        require(
            _buyer != address(0),
            "ServiceFee.getBuyServiceFeeBps: Zero address"
        );

        return 200;
    }

    /**
     * @notice Get service fee recipient address
     */
    function getServiceFeeRecipient() onlyProxy external view returns (address payable) {
        return serviceFeeRecipient;
    }

    /**
     * @notice Set service fee recipient address
     * @param _serviceFeeRecipient address of recipient
     */
    function setServiceFeeRecipient(address payable _serviceFeeRecipient) onlyProxy external {
        require(
            _serviceFeeRecipient != address(0),
            "ServiceFee.setServiceFeeRecipient: Zero address"
        );

        serviceFeeRecipient = _serviceFeeRecipient;
        emit ServiceFeeRecipientChanged(_serviceFeeRecipient);
    }
}
