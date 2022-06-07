pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

//ERC20 is the contract of the standard fungible token, it will deal with all the token functionalities
import "@openzeppelin/contracts/token/ERC20/IERC20.sol"; 
import "./MyDaoToken.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
// The owner of this contract will be the deployer
// to change the owner of a contract check this function: 
// https://docs.openzeppelin.com/contracts/2.x/api/ownership#Ownable-transferOwnership-address-

contract MyTokenVendor is Ownable {

    IERC20 public myDaoToken;
    uint256 price;
    mapping(address => bool) whitelisted;

    // Create the constructor of this contract taking in argument a name (string memory name_),
    // a symbol (string memory symbol_) and a price (uint256)
    // and it should use the inhereted constructor 'constructor (your agrs) Ownable(){...}'
    // it should deploy your token and save it in an IERC20 instance using 'new MyDaoToken(your argument)'
    /* remove the code */
    constructor (string memory name_, string memory symbol_, uint256 price_){
        myDaoToken = new MyDaoToken(name_, symbol_);
        price = price_;
    }

    // Compute the exchange rate of Ether to your token as a function 'getExchangeRate' returning a uint256
    // choose whatever function you want
    function getExchangeRate() public pure returns(uint256){
        return 1;
    }

    // Add users to a whitelist with a function 'addToWhitelist(address)' using a mapping and 
    // add the modifier 'onlyOwner()' already imported from the OppenZepplin contracts
    function addToWhitelist(address address_) public onlyOwner() {
        whitelisted[address_] = true;
    }

    // Remove users from a whitelist with a function 'removeFromWhitelist(address)'
    // add the modifier 'onlyOwner()' already imported from the OppenZepplin contracts
    //  ( make sure to add a `whitelisted(address)` event and emit it for the frontend <List/> display )
    function removeFromWhitelist(address address_) public onlyOwner() {
        whitelisted[address_] = false;
    }

    // Create the modifier 'isWhitelisted()' to verify if the senser is whitelisted
    //  ( make sure to add a `removedFromWhitelist(address)` event and emit it for the frontend <List/> display )
    modifier isWhitelisted(){
        require(whitelisted[msg.sender]);
        _;
    }

    // Collect funds in a payable `pledgeEth(uint256)` function and track individual `balances` with a mapping
    // then add 'payable' and a 'isWhitelisted()' modifier to let only the whitelisted users buy the token
    // the function should take into account the 'getExchangeRate' result
    //  ( make sure to add a `pledgedEth(address,uint256)` event and emit it for the frontend <List/> display )
    function pledgeEth(uint256 amount_) external payable isWhitelisted(){
        myDaoToken.tranfer(msg.sender, getExchangeRate()*amount_);
    }

    

    // Optional: 
    // Send the Ether and some tokens to the DAO once to create its treasury
    // and transfer the ownership of this token to the DAO contract
    // and mint itslef 5% of the maximum supply
    // with the 'giveToTheCommunity()' function using the modifiers 'onlyOwner()'



    // to support receiving ETH by default
    receive() external payable {}
    fallback() external payable {}
}