pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
import "./MyDaoToken.sol";
// import "@openzeppelin/contracts/..."; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/...

contract MyDao {

  // On deploy the DAO should know and remember which token is governing it
  constructor(address tokenAddress_) payable {
    
  }

  //create a 'vote' struct containing: 
  // - a string for a message or an IPFS URI
  // - an uint256 for the starting of the vote and aonther one for the ending
  // - a unit256 for the proportion of "yes" to validate the vote
  // - a quorum to know how much of the total supply of the token should vote
  // - a mapping from an address to a boolean
  // - a boolean 'result' with a getter only available if the vote is finished

  // Create a vote with the function 'voteFactory'
  // stored in a mapping (as an unbounded array) using a "vote" struct
  // it checks if the sender has at least 1% of the total supply to create a vote
  
  // Vote with your tokens using the 'vote' function 
  // taking as argument the index of the vote and the answer (boolean)

  // Execute the vote with the function 'ExecuteVote'
  // it checks that the vote is finished
  // and iterativelly compute if the quorum is reached 
  // by checking the balance of each voters at the moment of the vote execution
  // as well as checking if enough voting power lean towards 'yes'
  // (optional: compute the vote with a secondary function to implement a quadratic voting mechanism)
  // (optional: mint an NFT associated to the vote for voters who voted more than x tokens)

  // Optional:
  // Delegate your voting power using the function 'Delegate'
  // adding a mapping for delegation and checking delegation when calling Execute

  // Optional:
  // add an address field and a function name in the 'vote' struct
  // Execute this function once the vote passed with the function 'ExecuteFunction'
  // use 'contract.call(bytes4(sha3("someFunction()")))' in this function to be able to execute it
}
