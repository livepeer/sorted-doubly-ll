const { TestHelper } = require("zos")

const FundraisingLeaderboard = artifacts.require("FundraisingLeaderboard")

contract("FundraisingLeaderboard", function([_, owner]) {
    let project

    beforeEach(async () => {
        project = await TestHelper({ from: owner })
    })

    it("works", async () => {

    })
})