// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;
import "hardhat/console.sol";

contract BankAccountOperation {
    address public owner;
    modifier onlyWhiteList() {
        require(owner == msg.sender,"only owner can do this!");
        _;
    }
    constructor() payable {
        owner=msg.sender;
    }
    receive() payable external{}

    function withdraw() onlyWhiteList external {
        address payable Receiver = payable(msg.sender);
        Receiver.transfer(address(this).balance);
    }

    function deposit() payable onlyWhiteList external {
        console.log(address(this).balance);
    }

    function gerBalance() external view {
        console.log(address(this).balance);
    }
}