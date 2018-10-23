async function expectFailWithMessage(promise, msg) {
    try {
        await promise
    } catch (error) {
        const fail = error.message.search(msg) >= 0

        assert(fail, `Expected ${msg}, got '${error}' instead`)
        return
    }

    assert.fail("Expected failure, but none received")
}

async function expectRevert(promise) {
    await expectFailWithMessage(promise, "revert")
}

module.exports = {
    expectRevert
}