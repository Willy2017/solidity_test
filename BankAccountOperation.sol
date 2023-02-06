// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;
import "hardhat/console.sol";

contract BankAccountOperation {
    address private owner;
    mapping(address=> uint) private balanceList;

    constructor() payable {
        balanceList[msg.sender] += msg.value;
        owner=msg.sender;
    }

    function withdraw(uint amount) external {
        address payable Receiver = payable(msg.sender);
        if (balanceList[msg.sender] >= amount) {
            Receiver.transfer(amount);
            balanceList[msg.sender] -= amount;
        }

        console.log(balanceList[msg.sender]);
    }

    function deposit() payable external {
        balanceList[msg.sender] += msg.value;
        console.log(address(this).balance);
    }

    function getBalance() external view {
        console.log(address(this).balance);
    }

}