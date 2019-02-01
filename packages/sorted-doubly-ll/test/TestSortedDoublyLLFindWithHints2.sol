pragma solidity ^0.5.0;

import "../contracts/PublicSortedDoublyLL.sol";
import "truffle/Assert.sol";


contract TestSortedDoublyLLFindWithHints2 {
    address[] ids = [address(1), address(2), address(3), address(4), address(5), address(6)];
    uint256[] keys = [uint256(13), uint256(11), uint256(9), uint256(7), uint256(5), uint256(3)];

    PublicSortedDoublyLL fixture;

    function beforeEach() public {
        fixture = new PublicSortedDoublyLL();
        fixture.initialize(address(this), 10);
    }

    function test_insert_findWithHintPrevRemoved() public {
        fixture.insert(ids[0], keys[0], address(0), address(0));
        fixture.insert(ids[1], keys[1], ids[0], address(0));
        fixture.insert(ids[2], keys[2], ids[1], address(0));
        fixture.insert(ids[4], keys[4], ids[2], address(0));
        fixture.insert(ids[5], keys[5], ids[4], address(0));

        fixture.remove(ids[2]);
        fixture.insert(ids[3], keys[3], ids[2], ids[4]);
        Assert.equal(fixture.getSize(), 5, "wrong size");
        Assert.equal(fixture.getKey(ids[3]), keys[3], "wrong key");
        Assert.equal(fixture.getNext(ids[3]), ids[4], "wrong next");
        Assert.equal(fixture.getPrev(ids[3]), ids[1], "wrong prev");
    }

    function test_insert_findWithHintPrevRemovedUpdateHead() public {
        fixture.insert(ids[0], keys[0], address(0), address(0));
        fixture.insert(ids[2], keys[2], ids[1], address(0));
        fixture.insert(ids[3], keys[3], ids[2], address(0));
        fixture.insert(ids[4], keys[4], ids[3], address(0));
        fixture.insert(ids[5], keys[5], ids[4], address(0));

        fixture.remove(ids[0]);
        fixture.insert(ids[1], keys[1], ids[0], ids[2]);
        Assert.equal(fixture.getSize(), 5, "wrong size");
        Assert.equal(fixture.getFirst(), ids[1], "wrong head");
        Assert.equal(fixture.getKey(ids[1]), keys[1], "wrong key");
        Assert.equal(fixture.getNext(ids[1]), ids[2], "wrong next");
        Assert.equal(fixture.getPrev(ids[1]), address(0), "wrong prev");
    }

    function test_insert_findWithHintPrevDecreased() public {
        fixture.insert(ids[0], keys[0], address(0), address(0));
        fixture.insert(ids[1], keys[1], ids[0], address(0));
        fixture.insert(ids[2], keys[2], ids[1], address(0));
        fixture.insert(ids[4], keys[4], ids[2], address(0));
        fixture.insert(ids[5], keys[5], ids[4], address(0));

        fixture.updateKey(ids[2], 6, address(0), address(0));
        fixture.insert(ids[3], keys[3], ids[2], ids[4]);
        Assert.equal(fixture.getSize(), 6, "wrong size");
        Assert.equal(fixture.getKey(ids[3]), keys[3], "wrong key");
        Assert.equal(fixture.getNext(ids[3]), ids[2], "wrong next");
        Assert.equal(fixture.getPrev(ids[3]), ids[1], "wrong prev");
    }
}
