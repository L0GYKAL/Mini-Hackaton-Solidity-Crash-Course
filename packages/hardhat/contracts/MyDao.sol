pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
import "./MyDaoToken.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// import "@openzeppelin/contracts/..."; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/...

contract MyDao {

  IERC20 myDaoToken;
  /*to remove*/
  mapping(uint256 => Vote) votes;
  uint256 voteCount = 0;
  // On deploy the DAO should know and remember which token is governing it
  constructor(address tokenAddress_) payable {
    myDaoToken = IERC20(tokenAddress_);
  }

  // create a 'Vote' struct containing: 
  // - a string for a message or an IPFS URI
  // - an uint256 for the starting of the vote and aonther one for the ending
  // - a uint8 'threshold' for the proportion of "yes" to validate the vote
  // - a uint8 'quorum' to know what proportion of the total supply of the token should vote
  // - a mapping 'ballots' from an address to a boolean
  // - a mapping 'voters' from uint256 to address
  // - a uint256 'votersCount' to know the number of users who already voted
  // - a boolean 'result' with a getter only available if the vote is finished
  // - a boolean 'hasBeenExecuted'
  /*to remove*/
  struct Vote{
    string ressource;
    uint256 start;
    uint256 end;
    uint8 threshold;
    uint8 quorum;
    mapping(address => bool) ballots;
    uint256 votersCount;
    mapping(uint256 => address) voters;
    bool result;
    bool hasBeenExecuted;
  }

  // A modifier 'hasEnoughStake' that checks if 
  // the transaction sender has at least a certain percentage of the total supply
  modifier hasEnoughStake(uint8 percentage_){
    require(myDaoToken.balanceOf(msg.sender) > myDaoToken.totalSupply()*percentage_/100);
    _;
  }

  // Create a vote with the function 'voteFactory'
  // stored in a mapping (as an unbounded array) using a "vote" struct
  // it checks if the sender has at least 1% of the total supply to create a vote
  function voteFactory(string memory ressource_, uint256 start_,
                    uint256 end_, uint8 threshold_, uint8 quorum_) public hasEnoughStake(1) {
    votes[1].ressource = ressource_;
    votes[1].start = start_;
    votes[1].end = end_;
    votes[1].threshold = threshold_;
    votes[1].quorum = quorum_;
    voteCount+=1;
  }
  
  // Vote with your tokens using the 'vote' function 
  // taking as argument the index of the vote and the answer (boolean)
  function vote(uint256 index, bool answer) public {
    votes[index].ballots[msg.sender] = answer;
  }

  // Execute the vote with the function 'ExecuteVote'
  // it takes the index as argument
  // it checks that the vote is finished and not already executed
  // and iterativelly compute if the quorum is reached 
  // by checking the balance of each voters at the moment of the vote execution
  // as well as checking if enough voting power lean towards 'yes'
  // (optional: compute the vote with a secondary function to implement a quadratic voting mechanism)
  // (optional: mint an NFT associated to the vote for voters who voted more than x tokens)
  function executeVote(uint256 index) public returns(bool){
    require(index < voteCount, "this vote doesn't exist");
    require(votes[index].end <= block.timestamp, "the voting period isn't finished");
    require(votes[index].hasBeenExecuted == false, "the vote has already been executed");
    uint256 against = 0;
    uint256 pro = 0;
    for(uint256 i=0; i < votes[index].votersCount; i+=1){
      bool choice = votes[index].ballots[votes[index].voters[i]];
      if (choice){//true
        pro += myDaoToken.balanceOf(votes[index].voters[i]);
      }
      else{
        against += myDaoToken.balanceOf(votes[index].voters[i]);
      }
      require(pro + against > myDaoToken.totalSupply()*votes[index].quorum/100);
      if (pro > myDaoToken.totalSupply()*votes[index].threshold/100){
        votes[index].result = true;
        return true;
      }
      else{
        votes[index].result = false;
        return false;
      }
    }
  }

  // Optional:
  // Delegate your voting power using the function 'Delegate'
  // adding a mapping for delegation and checking delegation when calling 'executeVote'

  // Optional:
  // add an address field and a function name in the 'vote' struct
  // Execute this function if the vote passed with the function 'executeVote'
  // use 'contract.call(bytes4(sha3("someFunction()")))' in this function to be able to execute it
}
