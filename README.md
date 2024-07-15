# Degen Token Contract README

This Solidity contract implements a custom ERC20 token named Degen Token (DGN). It extends OpenZeppelin's ERC20 and Ownable contracts.

## Contract Overview

The Degen Token contract allows users to mint, transfer, and burn tokens. Additionally, users can participate in a lottery to win various in-game items.

## Functions

### 1. `issueTokens(address recipient, uint256 amount)`

The contract owner can call this function to mint a specified amount of DGN tokens to a given address.

### 2. `burnTokens(uint256 amount)`

Allows users to burn a specified amount of DGN tokens from their own balance. The number of tokens burned is tracked per user.

### 3. `enterLottery()`

Allows users to enter a lottery by burning 130 DGN tokens. The user has a chance to win one of the following prizes:
- **HotSpringsTrip** (2% chance)
- **FryingPan** (33% chance)
- **TissuesPack** (65% chance)

The awarded prize is added to the user's inventory, and an event is emitted to log the lottery outcome and inventory change.

### 4. `viewInventory()`

Returns a string representation of the user's inventory, listing the counts of each prize type.

### 5. `transfer(address recipient, uint256 amount)`

Overrides the default ERC20 `transfer` function to allow token transfers between users.

## Events

### 1. `LotteryOutcome(address indexed participant, Prize prize)`

Emitted when a user participates in the lottery, logging the participant and the prize awarded.

### 2. `InventoryChanged(address indexed participant, Prize[] prizes)`

Emitted whenever a user's inventory changes, logging the participant and their updated inventory.

## Inventory Management

The contract uses a mapping to store the inventory of each user. When a user wins a prize in the lottery, it is added to their inventory.

## Note

This contract is for demonstration purposes only and should not be used in production without thorough testing and security audits.

## Authors

Mc Maurice Manuel 
[@Yachiru](https://github.com/YachiJishi)

## License

This smart contract is licensed under the MIT License. You can find the full license text in the `LICENSE` file.
