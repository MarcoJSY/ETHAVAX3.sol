// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Importing required ERC20 interfaces and libraries
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// Inherit from ERC20 and Ownable contract
contract MyToken is ERC20, Ownable {

    // Constructor to initialize the token with a name, symbol, and initial supply
    constructor(string memory name, string memory symbol) ERC20(name, symbol) Ownable(msg.sender){
        _mint(msg.sender, 1000000 * 10**decimals()); // Mint 1,000,000 tokens to the contract deployer
    }

    // Function to allow the owner to mint new tokens to a specific address
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    // Function to allow users to burn their own tokens
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    // Function to allow users to transfer tokens to another address
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(amount <= balanceOf(msg.sender), "Insufficient balance");
        _transfer(_msgSender(), recipient, amount);
        return true;
    }
}
