// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;
import "hardhat/console.sol";

contract BankAccountOperation {
    address private owner;
    mapping(address=> bool) private depositWhiteList;
    mapping(address=> bool) private withdrawWhiteList;

    modifier onlyOwner() {
        require(owner == msg.sender,"only owner can do this!");
        _;
    }

    modifier onlyDepositWhiteList() {
        require(depositWhiteList[msg.sender] == true,"only deposit white list can do this!");
        _;
    }

    modifier onlyWithdrawWhiteList() {
        require(withdrawWhiteList[msg.sender] == true,"only withdraw white list can do this!");
        _;
    }
    constructor() payable {
        owner=msg.sender;
        depositWhiteList[owner] = true;
        withdrawWhiteList[owner] = true;
    }
    receive() payable external{}

    function withdraw() onlyWithdrawWhiteList external {
        address payable Receiver = payable(msg.sender);
        Receiver.transfer(address(this).balance);
        console.log(address(this).balance);
    }

    function deposit() payable onlyDepositWhiteList external {
        console.log(address(this).balance);
    }

    function getBalance() external view {
        console.log(address(this).balance);
    }

    function addDepositWhiteList(address depositWhiteAddress) onlyOwner external {
        depositWhiteList[depositWhiteAddress] = true;
    }

    function addWithdrawWhiteList(address withdrawWhiteAddress) onlyOwner external {
        withdrawWhiteList[withdrawWhiteAddress] = true;
    }
}