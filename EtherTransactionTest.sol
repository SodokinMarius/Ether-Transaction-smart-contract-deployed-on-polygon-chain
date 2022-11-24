
// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;
contract simpleWallet {

 address payable public owner;
  constructor ()  public
    {
            owner = payable(msg.sender);
    }

    struct wallet {
       uint  balance;
       uint numPayments;

    } 

    mapping(address=>wallet) Wallet;


 modifier isOnlyOwner()
    {
        require(owner == msg.sender);

        _;
    }

function getTotalBalance() public view returns(uint)
{
    return address(this).balance;    //Return the total balance/amount on smart contract
}

function getBalance() public view returns(uint)
{
   return  Wallet[owner].balance;  //Balance in the wallet
}

function deposit() external payable {
        require(msg.value>0,"The Amount must be greater than 0");
        Wallet[owner].balance += msg.value;
    }

function withdraw(address payable  destination,uint256 amount) public payable isOnlyOwner{
     require(amount < Wallet[owner].balance ,"Insufficient amount!!");
    require(amount >0,"Amount must be greter than 0");

        destination.transfer(amount);
        Wallet[owner].balance -= amount;
    }


receive() external payable {
    Wallet[owner].balance+=msg.value;  //the transfered amount is added to wallet
    Wallet[owner].numPayments+=1;
}

function getNumPayements() public view returns(uint)
{
    return Wallet[owner].numPayments;
}


}