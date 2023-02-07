//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract MyTest {
    uint256 public unlockedTime;
    address payable public owner;

    event Withrawal(uint256 amount, uint256 when);

    constructor(uint256 _unlockedTime) payable {
        require(
            block.timestamp < _unlockedTime,
            "Unlocked time should be in forlll"
        );

        unlockedTime = _unlockedTime;
        owner = payable(msg.sender);
    }

    function withdraw() public {
        require(
            block.timestamp >= unlockedTime,
            "Wait until the period is completed"
        );
        require(msg.sender == owner, "You are not an owner");
        emit Withrawal(address(this).balance, block.timestamp);

        owner.transfer(address(this).balance);
    }
}
