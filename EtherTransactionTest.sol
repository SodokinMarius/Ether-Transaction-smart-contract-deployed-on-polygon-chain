
// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;
contract simpleWallet {

 address payable public owner;
 
 //the constructor
  constructor ()  public
    {
            owner = payable(msg.sender);
    }

 
 //Wallet struct
    struct wallet {
       uint  balance;
       uint numPayments;

    } 

//All wallet 
    mapping(address=>wallet) Wallet;


//Modifier that required the owner
 modifier isOnlyOwner()
    {
        require(owner == msg.sender);

        _;
    }


// function that return all the amount on the wallet
function getTotalBalance() public view returns(uint)
{
    return address(this).balance;    //Return the total balance/amount on smart contract
}

//function that return the balance oon this wallet
function getBalance() public view returns(uint)
{
   return  Wallet[owner].balance;  //Balance in the wallet
}

//function that allows the deposit
function deposit() external payable {
        require(msg.value>0,"The Amount must be greater than 0");
        Wallet[owner].balance += msg.value;
    }

//function with wich user can withdraw
function withdraw(address payable  destination,uint256 amount) public payable isOnlyOwner{
     require(amount < Wallet[owner].balance ,"Insufficient amount!!");
    require(amount >0,"Amount must be greter than 0");

        destination.transfer(amount);
        Wallet[owner].balance -= amount;
    }

//function wich permit user to receive money
receive() external payable {
    Wallet[owner].balance+=msg.value;  //the transfered amount is added to wallet
    Wallet[owner].numPayments+=1;
}

//function tha count the number of a paiement
function getNumPayements() public view returns(uint)
{
    return Wallet[owner].numPayments;
}


}

