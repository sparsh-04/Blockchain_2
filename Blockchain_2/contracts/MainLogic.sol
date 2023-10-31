// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./ERC20token.sol";
contract MyToken {
    XYZToken MyTok;
    constructor(uint TotAmt,address UnspentAddress){
        MyTok = new XYZToken (TotAmt,UnspentAddress, msg.sender);
    }
     function validateTransaction(uint amount) private pure returns(bool){
        if(amount>0)
        return true;
        else return false;
    }

    function purchase(uint256 amount, uint256 discountTokens) public returns (uint256) {
        require(MyTok.balanceOf(msg.sender) >= discountTokens, "Not enough tokens for discount");
        require(validateTransaction(amount), "Transaction is not Validated");

        address Owner =MyTok.getOwner();
        // Calculate discount
        uint256 discount;
        if(discountTokens>=8)
        discount = 5 * ((discountTokens / 4));
        else {
        discount = 0;
        discountTokens =0;
        }
        require(discount<= 100, "Discount Cannot be more than 100");
        // require(discountTokens>= 8, "You need atleast 8 Tokens to avail discount");

        MyTok.increaseAllowance(msg.sender,address(this),amount);
        address UnspentAddres =MyTok.getUnspent();
        MyTok.transferFrom(msg.sender, UnspentAddres, discountTokens);


        //New Tokens
        uint256 newTokens = amount / 500;
        if(MyTok.balanceOf(Owner)<=newTokens){
            newTokens=MyTok.balanceOf(Owner);
        }
            MyTok.increaseAllowance(Owner,address(this),amount);
             MyTok.transferFrom(Owner, msg.sender, newTokens);
        return discount;
    }
    function balance() public view returns (uint256) {
        return MyTok.balanceOf(msg.sender);
    }
        //check this function
       function getRemainingTokensWithAddress(address addr) public view returns(uint256) {
        return MyTok.balanceOf(addr);
    }
}
