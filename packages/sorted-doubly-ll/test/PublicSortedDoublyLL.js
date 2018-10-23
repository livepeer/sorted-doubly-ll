const PublicSortedDoublyLL = artifacts.require("PublicSortedDoublyLL")

const RPC = require("./helpers/rpc")
const { expectRevert } = require("./helpers/expectFail")

contract("PublicSortedDoublyLL", accounts => {
    let lst
    let rpc
    let snapshotId

    before(async () => {
        rpc = new RPC(web3)

        lst = await PublicSortedDoublyLL.new()
        await lst.initialize(accounts[0], 10)
    })

    beforeEach(async () => {
        snapshotId = await rpc.snapshot()
    })

    afterEach(async () => {
        await rpc.revert(snapshotId)
    })

    describe("initialize", () => {
        it("sets updater and maxSize", async () => {
            assert.equal(await lst.updater.call(), accounts[0])
            assert.equal(await lst.getMaxSize(), 10)
        })

        it("fails if called more than once", async () => {
            await expectRevert(lst.initialize(accounts[0], 10))
        })
    })

    describe("setUpdater", () => {
        it("fails if sender is not current updater", async () => {
            await expectRevert(lst.setUpdater(accounts[1], { from: accounts[1] }))
        })

        it("succeeds if sender is current updater", async () => {
            await lst.setUpdater(accounts[1], { from: accounts[0] })
        })
    })

    describe("setMaxSize", () => {
        it("fails if sender is not current updater", async () => {
            await expectRevert(lst.setMaxSize(15, { from: accounts[1] }))
        })

        it("succeeds if sender is current updater", async () => {
            await lst.setMaxSize(15)
        })
    })

    describe("insert", () => {
        it("fails if sender is not current updater", async () => {
            await expectRevert(lst.insert(accounts[0], 5, accounts[0], accounts[0], { from: accounts[1] }))
        })

        it("succeeds if sender is current updater", async () => {
            await lst.insert(accounts[0], 5, accounts[0], accounts[0])
        })
    })

    describe("remove", () => {
        it("fails if sender is not current updater", async () => {
            await lst.insert(accounts[0], 5, accounts[0], accounts[0])
            await expectRevert(lst.remove(accounts[0], { from: accounts[1] }))
        })

        it("succeeds if sender is current updater", async () => {
            await lst.insert(accounts[0], 5, accounts[0], accounts[0])
            await lst.remove(accounts[0])
        })
    })

    describe("updateKey", () => {
        it("fails if sender is not current updater", async () => {
            await lst.insert(accounts[0], 5, accounts[0], accounts[0])
            await expectRevert(lst.updateKey(accounts[0], 7, accounts[0], accounts[0], { from: accounts[1] }))
        })

        it("succeeds if sender is current updater", async () => {
            await lst.insert(accounts[0], 5, accounts[0], accounts[0])
            await lst.updateKey(accounts[0], 7, accounts[0], accounts[0])
        })
    })
})