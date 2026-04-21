import { ethers } from "ethers";

const daoAddress = "YOUR_DAO_CONTRACT_ADDRESS";
const abi = [
  "function createProposal(address _target, uint256 _value, string memory _desc) external",
  "function vote(uint256 _proposalId, bool _support) external",
  "function proposals(uint256) view returns (address, uint256, string, uint256, uint256, bool)"
];

async function castVote(id, support) {
    const provider = new ethers.BrowserProvider(window.ethereum);
    const signer = await provider.getSigner();
    const contract = new ethers.Contract(daoAddress, abi, signer);
    
    const tx = await contract.vote(id, support);
    await tx.wait();
    console.log("Vote recorded!");
}
