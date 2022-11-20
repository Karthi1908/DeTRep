// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Checker.sol";
import "./CheckerCountingSimple.sol";
import "./CheckerVotes.sol";
import "./CheckerVotesQuorumFraction.sol";

contract DeRepRef is Checker, CheckerCountingSimple, CheckerVotes, CheckerVotesQuorumFraction {
    constructor(IVotes _token)
        Checker("DeRepRef")
        CheckerVotes(_token)
        CheckerVotesQuorumFraction(4)
    {}

    function votingDelay() public pure override returns (uint256) {
        return 1; // 1 block
    }

    function votingPeriod() public pure override returns (uint256) {
        return 7200; // 1 day
    }

    // The following functions are overrides required by Solidity.

    function quorum(uint256 blockNumber)
        public
        view
        override(IChecker, CheckerVotesQuorumFraction)
        returns (uint256)
    {
        return super.quorum(blockNumber);
    }
    
}