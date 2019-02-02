pragma solidity ^0.5.0;

import "zos-lib/contracts/Initializable.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "sorted-doubly-ll/contracts/PublicSortedDoublyLL.sol";


contract FundraisingLeaderboard is Initializable {
    using SafeMath for uint256;

    // Tracks the top contributors
    PublicSortedDoublyLL public leaderboard;
    // Beneficiary address to receive raised funds
    address payable public beneficiary;
    // Flag indicating whether fundraiser has ended
    bool public ended;

    modifier notEnded() {
        require(
            !ended,
            "fundraiser has ended"
        );
        _;
    }

    modifier onlyBeneficiary() {
        require(
            msg.sender == beneficiary,
            "sender is not beneficiary"
        );
        _;
    }

    function initialize(address payable _beneficiary, PublicSortedDoublyLL _leaderboard) public initializer {
        beneficiary = _beneficiary;
        leaderboard = _leaderboard;
    }

    function contribute(address _prevAddr, address _nextAddr) external payable notEnded {
        if (leaderboard.contains(msg.sender)) {
            uint256 currAmount = leaderboard.getKey(msg.sender);
            leaderboard.updateKey(msg.sender, currAmount.add(msg.value), _prevAddr, _nextAddr);
        } else {
            leaderboard.insert(msg.sender, msg.value, _prevAddr, _nextAddr);
        }
    }

    function end() external onlyBeneficiary notEnded {
        ended = true;

        beneficiary.transfer(address(this).balance);
    }
}