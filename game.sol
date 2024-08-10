// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyGame is ERC20, Ownable {
    string[] public dresses = ["casual", "formal", "sport", "fantasy"];

    struct UserDress {
        uint casual;
        uint formal;
        uint sport;
        uint fantasy;
    }
    
    mapping(address => UserDress) public userDresses;

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {}

    function mintTokens(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burnTokens(uint _amount) public {
        _burn(msg.sender, _amount);
    }

    function redeemDress(uint _index) public {
        require(_index < dresses.length, "Invalid index");
        
        uint256[4] memory costs = [uint256(15), uint256(25), uint256(20), uint256(35)];
        require(balanceOf(msg.sender) >= costs[_index], "Insufficient balance");
        _burn(msg.sender, costs[_index]);
        
        if (_index == 0) userDresses[msg.sender].casual++;
        else if (_index == 1) userDresses[msg.sender].formal++;
        else if (_index == 2) userDresses[msg.sender].sport++;
        else if (_index == 3) userDresses[msg.sender].fantasy++;
    }

    function checkAvailableDresses() public view returns (string[] memory) {
        return dresses;
    }

    function checkMyDresses() public view returns (UserDress memory) {
        return userDresses[msg.sender];
    }
    
    function checkBalance() public view returns (uint) {
        return balanceOf(msg.sender);
    }
}
