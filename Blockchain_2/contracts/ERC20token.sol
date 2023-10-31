// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract XYZToken is ERC20 {
    uint256 MaxSupply;
    address owner;
    address public UnspentAddress;
    constructor(uint256 _MaxSupply, address _UnspentAddress, address _Owner) ERC20("XYZToken", "XYZ") {
        UnspentAddress =_UnspentAddress;
         owner = _Owner;
         MaxSupply = _MaxSupply;
        _mint(_Owner, MaxSupply);
    }
    function getUnspent() public view returns(address){{
        return UnspentAddress;
    }

}
    function getOwner() public view returns(address){{
        return owner;
    }
}
    
    function increaseAllowance(address a, address b, uint256 addedValue) public returns (bool) {
        // address owner = _msgSender();
        
        _approve(a, b, addedValue);

        return true;
    }
}
