# Bank Account Operation Smart Contract

This is a Solidity smart contract for a bank account operation system. It allows users to create and manage their bank accounts, and transfer funds between accounts. The smart contract is implemented using the Ethereum blockchain.

## Features

- Create a new bank account
- Deposit funds into a bank account
- Withdraw funds from a bank account
- Transfer funds between bank accounts
- Get the balance of a bank account

## Requirements

- Solidity compiler (version 0.5.0 or higher)
- Ganache or other Ethereum development environment
- Web3.js or other Ethereum JavaScript API

## Usage

To use this smart contract, you need to compile it using the Solidity compiler, and then deploy it to an Ethereum blockchain using a tool like Ganache.

Once the smart contract is deployed, you can interact with it using a JavaScript API like Web3.js. Here are some example commands:

```javascript
// Create a new bank account
BankAccountOperation.createAccount("Alice");

// Deposit funds into a bank account
BankAccountOperation.deposit(0, 100);

// Withdraw funds from a bank account
BankAccountOperation.withdraw(0, 50);

// Transfer funds between bank accounts
BankAccountOperation.transfer(0, 1, 25);

// Get the balance of a bank account
BankAccountOperation.getBalance(0);
