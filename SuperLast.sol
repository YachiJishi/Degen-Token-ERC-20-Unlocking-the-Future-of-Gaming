// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts@4.9.0/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.9.0/access/Ownable.sol";

contract Degen is ERC20, Ownable {

    enum Prize {None, TissuesPack, FryingPan, HotSpringsTrip}

    mapping(address => uint256) public tokensBurned;
    mapping(address => Prize[]) public prizeInventory;

    event LotteryOutcome(address indexed participant, Prize prize);
    event InventoryChanged(address indexed participant, Prize[] prizes);

    constructor() ERC20("Degen", "DGN") {}

    function burn(uint256 amount) public {
        _burn(_msgSender(), amount);
        tokensBurned[_msgSender()] += amount; // Update tokensBurned
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function enterLottery() public {
        uint256 burnAmount = 130;
        require(balanceOf(msg.sender) >= burnAmount, "Not enough balance to enter lottery");
        require(tokensBurned[msg.sender] >= 1, "You must have burned tokens to enter the lottery");

        uint256 randNum = uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp, msg.sender))) % 100;

        Prize prizeAwarded;

        if (randNum < 2) {
            prizeAwarded = Prize.HotSpringsTrip;
        } else if (randNum < 35) {
            prizeAwarded = Prize.FryingPan;
        } else {
            prizeAwarded = Prize.TissuesPack;
        }

        prizeInventory[msg.sender].push(prizeAwarded);
        _burn(msg.sender, burnAmount);

        emit LotteryOutcome(msg.sender, prizeAwarded);
        emit InventoryChanged(msg.sender, prizeInventory[msg.sender]);
    }

    function viewInventory() public view returns (string memory) {
        Prize[] memory prizes = prizeInventory[msg.sender];
        uint256 tissuesCount;
        uint256 fryingPanCount;
        uint256 hotSpringsTripCount;

        for (uint256 i = 0; i < prizes.length; i++) {
            if (prizes[i] == Prize.TissuesPack) {
                tissuesCount++;
            } else if (prizes[i] == Prize.FryingPan) {
                fryingPanCount++;
            } else if (prizes[i] == Prize.HotSpringsTrip) {
                hotSpringsTripCount++;
            }
        }

        return string(abi.encodePacked(
            "Tissues Pack: ", uintToString(tissuesCount),
            ", Frying Pan: ", uintToString(fryingPanCount),
            ", Hot Springs Trip: ", uintToString(hotSpringsTripCount)
        ));
    }

    function uintToString(uint value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }
        uint tempValue = value;
        uint digits;
        while (tempValue != 0) {
            digits++;
            tempValue /= 10;
        }
        bytes memory buffer = new bytes(digits);
        uint index = digits;
        tempValue = value;
        while (tempValue != 0) {
            buffer[--index] = bytes1(uint8(48 + tempValue % 10));
            tempValue /= 10;
        }
        return string(buffer);
    }
}
