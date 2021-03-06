pragma solidity ^0.5.0;

import "../contracts/PublicSortedDoublyLL.sol";
import "truffle/Assert.sol";


contract TestSortedDoublyLLFindNoHints {
    address[] ids = [address(1), address(2), address(3), address(4), address(5), address(6)];
    uint256[] keys = [uint256(13), uint256(11), uint256(9), uint256(7), uint256(5), uint256(3)];

    PublicSortedDoublyLL fixture;

    function beforeEach() public {
        fixture = new PublicSortedDoublyLL();
        fixture.initialize(address(this), 10);
    }

    function test_insert_findNoHintUpdateHead() public {
        fixture.insert(ids[1], keys[1], address(0), address(0));
        fixture.insert(ids[2], keys[2], ids[1], address(0));
        fixture.insert(ids[3], keys[3], ids[2], address(0));
        fixture.insert(ids[4], keys[4], ids[3], address(0));
        fixture.insert(ids[5], keys[5], ids[4], address(0));

        fixture.insert(ids[0], keys[0], address(0), address(0));
        Assert.equal(fixture.getSize(), 6, "wrong size");
        Assert.equal(fixture.getFirst(), ids[0], "wrong head");
        Assert.equal(fixture.getKey(ids[0]), keys[0], "wrong key");
        Assert.equal(fixture.getNext(ids[0]), ids[1], "wrong next");
        Assert.equal(fixture.getPrev(ids[0]), address(0), "wrong prev");
    }

    function test_insert_findNoHintUpdateTail() public {
        fixture.insert(ids[0], keys[0], address(0), address(0));
        fixture.insert(ids[1], keys[1], ids[0], address(0));
        fixture.insert(ids[2], keys[2], ids[1], address(0));
        fixture.insert(ids[3], keys[3], ids[2], address(0));
        fixture.insert(ids[4], keys[4], ids[3], address(0));

        fixture.insert(ids[5], keys[5], address(0), address(0));
        Assert.equal(fixture.getSize(), 6, "wrong size");
        Assert.equal(fixture.getLast(), ids[5], "wrong tail");
        Assert.equal(fixture.getKey(ids[5]), keys[5], "wrong key");
        Assert.equal(fixture.getNext(ids[5]), address(0), "wrong next transcoder");
        Assert.equal(fixture.getPrev(ids[5]), ids[4], "wrong prev transcoder");
    }

    function test_insert_findNoHintAtPosition() public {
        fixture.insert(ids[0], keys[0], address(0), address(0));
        fixture.insert(ids[1], keys[1], ids[0], address(0));
        fixture.insert(ids[3], keys[3], ids[1], address(0));
        fixture.insert(ids[4], keys[4], ids[3], address(0));
        fixture.insert(ids[5], keys[5], ids[4], address(0));

        fixture.insert(ids[2], keys[2], address(0), address(0));
        Assert.equal(fixture.getSize(), 6, "wrong size");
        Assert.equal(fixture.getKey(ids[2]), keys[2], "wrong");
        Assert.equal(fixture.getNext(ids[2]), ids[3], "wrong next");
        Assert.equal(fixture.getPrev(ids[2]), ids[1], "wrong prev");
    }
}