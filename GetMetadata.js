// Retrieve metadata (json) for a specific address:

const { ethers } = require("hardhat");
const { expect, assert } = require("chai");

async function main() {
    const provider = new ethers.providers.JsonRpcProvider("[YOUR PROVIDER]");
    const [deployer] = await ethers.getSigners();
  
    // ABI with the functions we will use:
    const ABI = [
      'function balanceOf(address owner) public view returns (uint256)',
      'function tokenOfOwnerByIndex(address owner, uint256 index) public view returns (uint256)',
      'function tokenURI(uint256 tokenId) public view returns (string memory)',
      ];
    const targetAddress="[TARGET NFT CONTRACT ADDRESS]"; // Address of NFT contract 
    const targetContract = new ethers.Contract(targetAddress, ABI, provider); // Contract factory
    const TargetContractWithSigner = targetContract.connect(deployer);  // Connect contract factory to deployer
    
    const addressToCheck= '[ADDRESS OF NFT OWNER]'; // Address to check ownership for
    const tokenIds = await TargetContractWithSigner.balanceOf(addressToCheck); // get number of NFTs of a contract address
    let tokID,metadataResponse,metadata;
    // loop through all NFTs of targetContract and retrieve metadata
    for (let i = 1; i <= tokenIds.toNumber(); i++)
    {
      tokID=await TargetContractWithSigner.tokenURI(i); // get tokenURIK link
      metadataResponse = await fetch(tokID);
      metadata = await metadataResponse.json(); // get metadata
      console.log(metadata);
    }
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
