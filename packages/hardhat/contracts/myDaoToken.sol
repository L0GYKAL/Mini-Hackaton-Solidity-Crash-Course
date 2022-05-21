pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/...


contract MyDaoToken is ERC20{
    // At deployement the token should mint its deployer 10'000 tokens
    // and use the inhereted constructor 'constructor (your agrs) ERC20(name_, symbol_){}'


}