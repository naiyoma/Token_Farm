// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract DappToken is ERC20 {
    constructor() public ERC20("Dapp Token", "DAPP"){
        _mint(msg.sender, 1000000000000000000);
    }
}
