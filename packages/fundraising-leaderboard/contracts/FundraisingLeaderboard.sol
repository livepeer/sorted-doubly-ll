pragma solidity ^0.4.24;

import "zos-lib/contracts/application/App.sol";
import "zos-lib/contracts/Initializable.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "sorted-doubly-ll/contracts/PublicSortedDoublyLL.sol";


contract FundraisingLeaderboard is Initializable {
    using SafeMath for uint256;

    // Tracks the top contributors
    PublicSortedDoublyLL public leaderboard;
    // Beneficiary address to receive raised funds
    address public beneficiary;
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

    function initialize(address _app, address _beneficiary, uint256 _maxContributors) public initializer {
        beneficiary = _beneficiary;
        ended = false;

        bytes memory initData = abi.encodeWithSignature("initialize(address,uint256)", address(this), _maxContributors);
        leaderboard = PublicSortedDoublyLL(
            App(_app).create("sorted-doubly-ll", "PublicSortedDoublyLL", initData)
        );
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