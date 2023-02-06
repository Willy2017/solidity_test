// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;
import "hardhat/console.sol";

contract BankAccountOperation {
    address private owner;

    struct addressInfo {
        bool state;
        uint pos;
    }

    mapping(address=> addressInfo) private addressPosList;

    struct accountInfo {
        address _address;
        uint balance;
    }

    accountInfo[] private accountList;

    constructor() payable {
        accountInfo memory a;
        a._address = msg.sender;
        a.balance += msg.value;
        accountList.push(a);
        addressPosList[msg.sender].pos = accountList.length - 1;
        addressPosList[msg.sender].state = true;
        owner=msg.sender;
    }

    function withdraw(uint amount) external returns (bool){
        if (addressPosList[msg.sender].state) {
            if (accountList[addressPosList[msg.sender].pos].balance < amount) {
                return false;
            }

            address payable Receiver = payable(msg.sender);
            accountList[addressPosList[msg.sender].pos].balance -= amount;
            Receiver.transfer(amount);
            return true;
        } else {
            return false;
        }
    }

    function withdrawAll() external returns (bool){
        if (addressPosList[msg.sender].state) {
            if (accountList[addressPosList[msg.sender].pos].balance == 0) {
                return false;
            }

            address payable Receiver = payable(msg.sender);
            Receiver.transfer(accountList[addressPosList[msg.sender].pos].balance);
            accountList[addressPosList[msg.sender].pos].balance = 0;
            return true;
        } else {
            return false;
        }
    }

    function deposit() payable external {
        if (addressPosList[msg.sender].state) {
            accountList[addressPosList[msg.sender].pos].balance += msg.value;
        } else {
            accountInfo memory a;
            a._address = msg.sender;
            a.balance += msg.value;
            accountList.push(a);
            addressPosList[msg.sender].pos = accountList.length - 1;
            addressPosList[msg.sender].state = true;
        }
    }

    function destroySmartContract() public {
        require(msg.sender == owner, "You are not the owner!");
        selfdestruct(payable(owner));
    }

    function getBalance() external view {
        for(uint i=0;i<accountList.length;i++) {
            if (0 < accountList[i].balance) {
                console.log(accountList[i]._address);
                console.log(accountList[i].balance);
            }
        }
    }
}