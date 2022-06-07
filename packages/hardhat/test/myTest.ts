const { ethers } = require("hardhat");
const { use, expect } = require("chai");
const { solidity } = require("ethereum-waffle");

use(solidity);

describe("My Dapp", function () {
  this.timeout(125000);

  let myTokenVendor;

  if(process.env.CONTRACT_ADDRESS){
    // live contracts, token already deployed
  }else{
    describe("MyTokenVendor", function () {
      it("Should deploy MyTokenVendor", async function () {
        const MyTokenVendor = await ethers.getContractFactory("MyTokenVendor");

        myTokenVendor = await MyTokenVendor.deploy();
      });

      describe("addToWhitelist()", function () {
        it("Should add to whitelist ",async function () {
          const [ owner ] = await ethers.getSigners();
          await myTokenVendor.addToWhitelist(owner.address);
          expect(myTokenVendor.whitelisted(owner.address));
        })
      })

      describe("pledgeEth()", function () {
        it("Should be able to pledge some eth", async function () {
          const amount = ethers.utils.parseEth(1);

          const previousBalance = ethers.utils.parseEth( await ethers.provider.getBalance(myTokenVendor.address));
          console.log("\t", "Checking the balance of the contract before pledging: ", previousBalance, ' ETH');
          await myTokenVendor.pledgeEth(amount);
          const finalBalance = ethers.utils.parseEth(await ethers.provider.getBalance(myTokenVendor.address));
          console.log("\t", "Checking the balance of the contract after pledging: ", finalBalance, ' ETH');
          expect(finalBalance - previousBalance).to.equal(amount);

          // TODO: check if the token balance changed
        });

        it("Should emit a pledgeEth event ", async function () {
          const [owner] = await ethers.getSigners();

          const amount = ethers.utils.parseEth(1);
          expect(await myTokenVendor.pledgeEth(amount))
            .to.emit(myTokenVendor, "pledgedEth")
            .withArgs(owner.address, amount);
        });

        it("Should deploy myDaoToken in its contructor()", async function () {
          const tokenAdress = myTokenVendor.myDaoToken();

        });
      });
    });
  }
});
