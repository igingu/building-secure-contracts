// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.0;

import "./naive-receiver/FlashLoanReceiver.sol";
import "./naive-receiver/NaiveReceiverLenderPool.sol";

/// @dev Run the template with
///      ```
///      solc-select use 0.8.0
///      echidna program-analysis/echidna/exercises/exercise4/template.sol --contract TestToken --test-mode assertion
///      ```
///      or by providing a config
///      ```
///      echidna program-analysis/echidna/exercises/exercise4/template.sol --contract TestToken --config program-analysis/echidna/exercises/exercise4/config.yaml
///      ```
contract TestChallenge5 {
    NaiveReceiverLenderPool internal pool;
    FlashLoanReceiver internal receiver;

    uint256 private constant ETHER_IN_POOL = 1000 ether;
    uint256 private constant ETHER_IN_RECEIVER = 10 ether;

    constructor() {
        pool = new NaiveReceiverLenderPool();
        receiver = new FlashLoanReceiver(payable(address(pool)));

        payable(address(pool)).transfer(ETHER_IN_POOL);
        payable(address(receiver)).transfer(ETHER_IN_RECEIVER);
    }

    function echidna_test_receiver() public view returns (bool) {
        return address(receiver).balance == ETHER_IN_RECEIVER;
    }
}
