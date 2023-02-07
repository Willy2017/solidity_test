// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;
import "hardhat/console.sol";

contract BankAccountOperation {
    address private owner;

    struct addressPos {
        bool state;
        uint pos;
    }

    mapping(address=> addressPos) private addressPosList;

    struct addressBalance {
        address _address;
        uint balance;
    }

    addressBalance[] private balanceList;

    constructor() payable {
        addressBalance memory a;
        a._address = msg.sender;
        a.balance = msg.value;
        balanceList.push(a);
        addressPosList[msg.sender].pos = balanceList.length - 1;
        addressPosList[msg.sender].state = true;
        owner=msg.sender;
    }

    function withdraw(uint amount) external returns (bool){
        if (addressPosList[msg.sender].state) {
            if (balanceList[addressPosList[msg.sender].pos].balance < amount) {
                return false;
            }

            address payable Receiver = payable(msg.sender);
            balanceList[addressPosList[msg.sender].pos].balance -= amount;
            Receiver.transfer(amount);
            return true;
        } else {
            return false;
        }
    }

    function withdrawAll() external returns (bool){
        if (addressPosList[msg.sender].state) {
            if (balanceList[addressPosList[msg.sender].pos].balance == 0) {
                return false;
            }

            address payable Receiver = payable(msg.sender);
            Receiver.transfer(balanceList[addressPosList[msg.sender].pos].balance);
            balanceList[addressPosList[msg.sender].pos].balance = 0;
            return true;
        } else {
            return false;
        }
    }

    function deposit() payable external {
        if (addressPosList[msg.sender].state) {
            balanceList[addressPosList[msg.sender].pos].balance += msg.value;
        } else {
            addressBalance memory a;
            a._address = msg.sender;
            a.balance += msg.value;
            balanceList.push(a);
            addressPosList[msg.sender].pos = balanceList.length - 1;
            addressPosList[msg.sender].state = true;
        }
    }

    function destroySmartContract() public {
        require(msg.sender == owner, "You are not the owner!");
        selfdestruct(payable(owner));
    }

    function getAllBalance() external view {
        require(msg.sender == owner, "You are not the owner!");
 
        for(uint i=0; i < balanceList.length;i++) {
            if (0 < balanceList[i].balance) {
                console.log(balanceList[i]._address);
                console.log(balanceList[i].balance);
            }
        }
    }

    function getBalance() external view returns (uint){
        if (addressPosList[msg.sender].state) {
            console.log(balanceList[addressPosList[msg.sender].pos].balance);
            return balanceList[addressPosList[msg.sender].pos].balance;
        }

        return 0;
    }
}