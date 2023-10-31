// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./ERC20token.sol";


contract MyToken {
    XYZToken MyTok;
    mapping(address => uint256) public balances;

    constructor(uint TotAmt,address UnspentAddress){
        MyTok = new XYZToken (TotAmt,UnspentAddress, msg.sender);
        balances[0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2] = 0;
        balances[0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db] = 100000;
        balances[0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB] = 10000;
        balances[0x617F2E2fD72FD9D5503197092aC168c91465E7f2] = 10000;
        balances[0x17F6AD8Ef982297579C203069C1DbfFE4348c372] = 10000;
        balances[0x5c6B0f7Bf3E7ce046039Bd8FABdfD3f9F5021678] = 10000;
        balances[0x03C6FcED478cBbC9a4FAB34eF9f40767739D1Ff7] = 10000;
        balances[0x0A098Eda01Ce92ff4A4CCb7A4fFFb5A43EBC70DC] = 10000;
        balances[0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c] = 10000;

    }
    struct Purchase{
        address Sender;
        uint Amount;
        uint Token;
    }
    Purchase[] public pendingTransactions;

    function purchase(uint256 amount, uint256 discountTokens) public {
            pendingTransactions.push(Purchase(msg.sender,amount,discountTokens));
        }


    function validateTransaction(uint amount, address Spender, uint discount, address Owner) public  returns(bool){
        
        if(amount>0){
            if(balances[Spender]>=(amount*(100-discount))/100){
                balances[Spender]-=(amount*(100-discount))/100;
                balances[Owner]+=(amount*(100-discount))/100;
                return true;
            }
            else return false;
        }
        else 
        return false;
    }


    function ConfirmPurchase(uint index) public returns (uint256) {
        address Owner =MyTok.getOwner();
        require(msg.sender == Owner, "Only the owner can Confirm a purchase");
        uint256 amount=pendingTransactions[index].Amount;
        uint256 discountTokens = pendingTransactions[index].Token;
        address buyer = pendingTransactions[index].Sender;
        require(MyTok.balanceOf(buyer) >= discountTokens, "Not enough tokens for discount");

        // Calculate discount
        uint256 discount;
        if(discountTokens>=8)
        discount = 5 * ((discountTokens / 4));
        else {
        discount = 0;
        discountTokens =0;
        }
        require(validateTransaction(amount, buyer, discount, Owner), "H Transaction is not Validated");
        require(discount<= 100, "Discount Cannot be more than 100");
        // require(discountTokens>= 8, "You need atleast 8 Tokens to avail discount");

        MyTok.increaseAllowance(buyer,address(this),amount);
        address UnspentAddres =MyTok.getUnspent();
        MyTok.transferFrom(buyer, UnspentAddres, discountTokens);


        //New Tokens
        uint256 newTokens = amount / 500;
        if(MyTok.balanceOf(Owner)<=newTokens){
            newTokens=MyTok.balanceOf(Owner);
        }
        MyTok.increaseAllowance(Owner,address(this),amount);
        MyTok.transferFrom(Owner, buyer, newTokens);
        return discount;
    }
    function balance() public view returns (uint256) {
        return MyTok.balanceOf(msg.sender);
    }
        //check this function
       function getRemainingTokensWithAddress(address addr) public view returns(uint256) {
        return MyTok.balanceOf(addr);
    }
    function getRemainingBalanceWithAddress(address addr) public view returns(uint256) {
        return (balances[addr]);
    }
}
