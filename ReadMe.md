# Contract 1 - Create the XYZToken.

**XYZToken** is a decentralized Ethereum-based ERC-20 token contract that provides a basic implementation of the ERC-20 standard. This token contract allows users to create, transfer, and manage XYZ tokens.

## Features

- **Customizable Supply:** The total supply of XYZ tokens is set during deployment, allowing for flexibility in tokenomics and use-case scenarios.

- **Owner Management:** The contract allows the specification of an owner address during deployment, enabling control over the token supply and various operations.

- **Allowance Mechanism:** XYZToken includes an `increaseAllowance` function that enables users to approve the transfer of tokens to a specific address with added value, enhancing the contract's functionality for diverse applications.

## Deployment

To deploy XYZToken, you need to specify the following parameters:

- **Maximum Supply (\_MaxSupply):** The total supply of XYZ tokens.
- **Unspent Address (\_UnspentAddress):** The address where unused or unallocated tokens are stored.

- **Owner Address (\_Owner):** The address that deploys the contract and becomes the initial owner of the tokens.

# Contract-2 Business Logic

## Overview

The `MyToken` contract is an Ethereum smart contract that facilitates token transactions using the `XYZToken` ERC-20 token. It allows users to make purchases with discounts, validate transactions, and manage token balances.

## Functions

### `constructor(uint TotAmt, address UnspentAddress)`

- **Description:** Initializes the `MyToken` contract.
- **Parameters:**
  - `TotAmt`: Total amount of tokens to be created.
  - `UnspentAddress`: Address where unused tokens are stored.
- **Functionality:** Creates a new instance of the `XYZToken` contract with the specified total supply (`TotAmt`) and unspent token address (`UnspentAddress`). Initializes balances for specific addresses with predefined values.

### `function purchase(uint256 amount, uint256 discountTokens)`

- **Description:** Records a pending purchase transaction.
- **Parameters:**
  - `amount`: Amount of tokens to be purchased.
  - `discountTokens`: Number of tokens to be used for a discount.
- **Functionality:** Adds a new transaction to the `pendingTransactions` array, indicating the sender, purchase amount, and discount tokens.

### `function validateTransaction(uint amount, address Spender, uint discount, address Owner)`

- **Description:** Validates a transaction and transfers tokens between sender and owner.
- **Parameters:**
  - `amount`: Amount of tokens to be transferred.
  - `Spender`: Address of the transaction sender.
  - `discount`: Discount percentage applied to the transaction.
  - `Owner`: Address of the token owner.
- **Functionality:** Validates the transaction, ensuring the sender has enough tokens to cover the transaction after applying the discount. If validated, transfers tokens from the sender to the owner.

### `function ConfirmPurchase(uint index)`

- **Description:** Confirms a pending purchase transaction.
- **Parameters:**
  - `index`: Index of the pending transaction to be confirmed.
- **Functionality:** Allows the owner to confirm a pending purchase, applying discounts, transferring tokens, and finalizing the transaction.

### `function balance()`

- **Description:** Gets the token balance of the caller.
- **Functionality:** Returns the token balance of the Ethereum address that calls the function using the `MyTok` contract's `balanceOf` method.

### `function getRemainingTokensWithAddress(address addr)`

- **Description:** Retrieves the remaining tokens of a specified address.
- **Parameters:**
  - `addr`: Address to query the remaining tokens.
- **Functionality:** Returns the remaining tokens held by the specified address using the `MyTok` contract's `balanceOf` method.

### `function getRemainingBalanceWithAddress(address addr)`

- **Description:** Retrieves the remaining balance of Ether of a specified address.
- **Parameters:**
  - `addr`: Address to query the remaining Ether balance.
- **Functionality:** Returns the remaining Ether balance of the specified address, which is stored in the `balances` mapping.
