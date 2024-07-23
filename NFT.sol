// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MindfulMoments is ERC721, Ownable {
    uint256 public nextTokenId;
    address public admin;

    constructor() ERC721('MindfulMoments', 'MOMENT') {
        admin = msg.sender;
    }

    function mint(address to) external {
        require(msg.sender == admin, 'only admin can mint');
        _safeMint(to, nextTokenId);
        nextTokenId++;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return "https://api.mindfulmoments.com/metadata/";
    }

    function setAdmin(address newAdmin) external onlyOwner {
        admin = newAdmin;
    }
}
