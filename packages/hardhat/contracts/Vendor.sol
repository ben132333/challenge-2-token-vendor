pragma solidity 0.8.4;  //Do not change the solidity version as it negativly impacts submission grading
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable {

  //event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);

  YourToken public yourToken;

  constructor(address tokenAddress) {
    yourToken = YourToken(tokenAddress);
  }

  uint256 public constant tokensPerEth = 100;
  event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);
  event SellTokens(address seller, uint256 amountOfTokens, uint256 amountOfETH);

  // ToDo: create a payable buyTokens() function:
  function buyTokens() public payable {
      uint256 tokensBought = msg.value * tokensPerEth;
      yourToken.transfer(msg.sender, tokensBought);
      emit BuyTokens(msg.sender, msg.value, tokensBought);
  }

  // ToDo: create a withdraw() function that lets the owner withdraw ETH
  function withdraw() public onlyOwner {
      payable(msg.sender).transfer(address(this).balance);
  }

  // ToDo: create a sellTokens(uint256 _amount) function:
  function sellTokens(uint256 _amount) public {
      yourToken.transferFrom(msg.sender, address(this), _amount);
      uint256 ethAmount = _amount / tokensPerEth;
      payable(msg.sender).transfer(ethAmount);
      emit SellTokens(msg.sender, _amount, ethAmount);
  }
} 
