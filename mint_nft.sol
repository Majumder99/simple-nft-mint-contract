//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract SouravContract is ERC721, Ownable{
    uint256 public mintPrice = 1 ether;
    uint256 public totalSupply;
    uint256 public maxSupply;
    bool public isMintEnable;

    //how many nft has been minted
    mapping(address => uint256) public mintedWallets;

    constructor() payable ERC721('SouravNft', 'SM'){
        maxSupply = 2;
    }

    function toggleIsMintEnabled() external onlyOwner{
        isMintEnable = !isMintEnable;
    }

    function setMaxSupply(uint256 maxSupply_) external onlyOwner {
        maxSupply = maxSupply_;
    }

    function mint() external payable{
        require(isMintEnable, "minting not anabled ");
        require(mintedWallets[msg.sender] < 1, "exceeds max per wallet");
        require(msg.value == mintPrice, "wrong value");
        require(maxSupply > totalSupply, "sold out");

        mintedWallets[msg.sender]++;
        totalSupply++;
        uint256 tokenId = totalSupply;
        //safemint coming from erc721 
        _safeMint(msg.sender, tokenId);

    }
}