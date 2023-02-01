// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract test {
    address public owner;
    modifier onlyowner() {
        require(owner == msg.sender,"only owner can do this!");
        _;
    }
    constructor() payable {
        owner=msg.sender;
    }
    receive() payable external{}

    function withdraw() onlyowner external {
        address payable Receiver = payable(msg.sender);
        Receiver.transfer(address(this).balance);
    }    
}