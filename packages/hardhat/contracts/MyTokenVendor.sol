pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

//ERC20 is the contract of the standard fungible token, it will deal with all the token functionalities
import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; 

import "@openzeppelin/contracts/access/Ownable.sol";
// The owner of this contract will be the deployer
// to change the owner of a contract check this function: 
// https://docs.openzeppelin.com/contracts/2.x/api/ownership#Ownable-transferOwnership-address-

contract MyTokenVendor is Ownable {

    // Create the constructor of this contract taking in argument a name (string memory name_), a symbol (string memory symbol_) and a price (uint256)
    // it should deploy an ERC20 token using 'new MyDaoToken()'

    // Compute the exchange rate of Ether to your token as a function 'getExchangeRate' returning a uint256
    //choose whatever function you want

    // Collect funds in a payable `pledgeEth()` function and track individual `balances` with a mapping
    // then add a 'whitelisted(address)' modifier to let only the whitelisted users buy the token
    // the function should take into account the 'getExchangeRate' result
    //  ( make sure to add a `pledgedEth(address,uint256)` event and emit it for the frontend <List/> display )

    // Add users to a whitelist with a function 'addToWhitelist(address)' using a mapping and 
    // add the modifier 'OnlyOwner()' already imported from the OppenZepplin contracts

    // Optional: 
    // Send tokens to the DAO once to create its treasury and transfer the ownership of this token
    // and mint itslef 5% of the maximum supply
    // with the 'giveToTheCommunity' function



    // to support receiving ETH by default
    receive() external payable {}
    fallback() external payable {}
}