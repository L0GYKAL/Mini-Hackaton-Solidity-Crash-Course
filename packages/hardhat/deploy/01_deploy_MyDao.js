const { ethers } = require("hardhat");

const localChainId = "31337";

module.exports = async ({ getNamedAccounts, deployments, getChainId }) => {
    const { deploy } = deployments;
    const { deployer } = await getNamedAccounts();
    const chainId = await getChainId();

    const MyTokenVendor = await ethers.getContract("MyTokenVendor", deployer);
  
    await deploy("MyDao", {
      // Learn more about args here: https://www.npmjs.com/package/hardhat-deploy#deploymentsdeploy
      from: deployer,
      args: [ await MyTokenVendor.myDaoToken() ],
      log: true,
      waitConfirmations: 5,
    });

    // Getting a previously deployed contract
  const MyDao = await ethers.getContract("MyDao", deployer);
};
module.exports.tags = ["MyDao"];