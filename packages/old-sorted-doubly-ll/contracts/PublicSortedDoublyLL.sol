pragma solidity ^0.4.25;

import "zos-lib/contracts/Initializable.sol";
import "./SortedDoublyLL.sol";


contract PublicSortedDoublyLL is Initializable {
    using SortedDoublyLL for SortedDoublyLL.Data;

    SortedDoublyLL.Data list;
    address public updater;

    modifier onlyUpdater() {
        require(
            msg.sender == updater,
            "sender is not an updater"
        );
        _;
    }

    function initialize(address _updater, uint256 _maxSize) public initializer {
        updater = _updater;
        setMaxSize(_maxSize);
    }

    function setUpdater(address _updater) public onlyUpdater {
        updater = _updater;
    }

    function setMaxSize(uint256 _maxSize) public onlyUpdater {
        list.setMaxSize(_maxSize);
    }

    function insert(
        address _id,
        uint256 _key,
        address _prevId,
        address _nextId
    ) 
        public
        onlyUpdater
    {
        list.insert(_id, _key, _prevId, _nextId);
    }

    function remove(address _id) public onlyUpdater {
        list.remove(_id);
    }

    function updateKey(
        address _id,
        uint256 _newKey,
        address _prevId,
        address _nextId
    )
        public
        onlyUpdater
    {
        list.updateKey(_id, _newKey, _prevId, _nextId);
    }

    function contains(address _id) public view returns (bool) {
        return list.contains(_id);
    }

    function getSize() public view returns (uint256) {
        return list.getSize();
    }

    function getMaxSize() public view returns (uint256) {
        return list.maxSize;
    }

    function getKey(address _id) public view returns (uint256) {
        return list.getKey(_id);
    }

    function getFirst() public view returns (address) {
        return list.getFirst();
    }

    function getLast() public view returns (address) {
        return list.getLast();
    }

    function getNext(address _id) public view returns (address) {
        return list.getNext(_id);
    }

    function getPrev(address _id) public view returns (address) {
        return list.getPrev(_id);
    }
}