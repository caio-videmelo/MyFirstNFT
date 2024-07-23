// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MindfulMoments is ERC721URIStorage, Ownable {
    uint256 public nextTokenId;
    address public admin;
    string private baseURI;

    // Define o URI base onde os metadados estão hospedados
    constructor(string memory _baseURI) ERC721('MindfulMoments', 'MOMENT') {
        baseURI = _baseURI;
        admin = msg.sender;
    }

    // Função para mintar um novo NFT
    function mint(address to, string memory tokenURI) external {
        require(msg.sender == admin, 'only admin can mint');
        _safeMint(to, nextTokenId);
        _setTokenURI(nextTokenId, tokenURI);
        nextTokenId++;
    }

    // Define o URI base para os metadados
    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    // Função para alterar o URI base
    function setBaseURI(string memory _newBaseURI) external onlyOwner {
        baseURI = _newBaseURI;
    }

    // Função para definir o admin
    function setAdmin(address newAdmin) external onlyOwner {
        admin = newAdmin;
    }
}