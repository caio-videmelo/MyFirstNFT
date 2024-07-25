// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title MindfulMomentsCollection
 * @dev NFT Collection celebrating mental health and well-being
 */
contract MindfulMomentsCollection is ERC721URIStorage, Ownable {
    uint256 public nextTokenId;
    mapping(uint256 => MindfulMoment) public mindfulMoments;

    struct MindfulMoment {
        string title;
        string description;
        string meditationTime;
        string environment;
        string difficultyLevel;
    }

   /**
 * @dev Initializes the contract by setting a `name`, a `symbol`, and the `owner` for the NFT collection.
 */
constructor() ERC721("Mindful Moments Collection", "MMC") Ownable(msg.sender) {
    // Ownable constructor will set the deployer as the initial owner
}

    /**
     * @notice Mint a new NFT in the Mindful Moments Collection
     * @dev Only the owner can mint new tokens.
     * @param to The address to receive the NFT.
     * @param tokenURI The URI pointing to the NFT metadata.
     * @param title The title of the mindful moment.
     * @param description A description of the mindful moment.
     * @param meditationTime The duration of the meditation or activity.
     * @param environment The environment where the activity takes place.
     * @param difficultyLevel The difficulty level of the activity.
     */
    function mint(
        address to,
        string memory tokenURI,
        string memory title,
        string memory description,
        string memory meditationTime,
        string memory environment,
        string memory difficultyLevel
    ) external onlyOwner {
        uint256 tokenId = nextTokenId;
        _mint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);

        mindfulMoments[tokenId] = MindfulMoment({
            title: title,
            description: description,
            meditationTime: meditationTime,
            environment: environment,
            difficultyLevel: difficultyLevel
        });

        nextTokenId++;
    }

    /**
     * @notice Get details of a specific Mindful Moment NFT.
     * @param tokenId The ID of the token.
     * @return title The title of the mindful moment.
     * @return description The description of the mindful moment.
     * @return meditationTime The meditation time or activity duration.
     * @return environment The environment of the activity.
     * @return difficultyLevel The difficulty level of the activity.
     */
    function getMindfulMoment(uint256 tokenId)
        external
        view
        returns (
            string memory title,
            string memory description,
            string memory meditationTime,
            string memory environment,
            string memory difficultyLevel
        )
    {
        MindfulMoment storage moment = mindfulMoments[tokenId];
        return (
            moment.title,
            moment.description,
            moment.meditationTime,
            moment.environment,
            moment.difficultyLevel
        );
    }
}
