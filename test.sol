// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;
import "hardhat/console.sol";

contract AccountOperation {
    address private owner;
    modifier onlyWhiteList() {
        require(owner == msg.sender,"only owner can do this!");
        _;
    }

    constructor () payable {
        owner = msg.sender;
    }

    function withdraw() onlyWhiteList external {
        address payable Receiver = payable(msg.sender);
        Receiver.transfer(address(this).balance);
        console.log(address(this).balance);
    }

    function deposit() payable onlyWhiteList external {
        console.log(address(this).balance);
    }

    function getBalanace() public view 
    {
        console.log(address(this).balance);
    }
}