// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SimpleDAO {
    struct Proposal {
        address target;
        uint256 value;
        string description;
        uint256 votesFor;
        uint256 votesAgainst;
        bool executed;
        mapping(address => bool) hasVoted;
    }

    IERC20 public govToken;
    Proposal[] public proposals;
    uint256 public constant MIN_VOTES = 100 * 10**18;

    constructor(address _token) {
        govToken = IERC20(_token);
    }

    function createProposal(address _target, uint256 _value, string memory _desc) external {
        require(govToken.balanceOf(msg.sender) > 0, "Must hold tokens to propose");
        uint256 proposalId = proposals.length;
        Proposal storage p = proposals.push();
        p.target = _target;
        p.value = _value;
        p.description = _desc;
    }

    function vote(uint256 _proposalId, bool _support) external {
        Proposal storage p = proposals[_proposalId];
        require(!p.hasVoted[msg.sender], "Already voted");
        
        uint256 weight = govToken.balanceOf(msg.sender);
        if (_support) p.votesFor += weight;
        else p.votesAgainst += weight;

        p.hasVoted[msg.sender] = true;
    }

    function execute(uint256 _proposalId) external payable {
        Proposal storage p = proposals[_proposalId];
        require(p.votesFor > p.votesAgainst, "Proposal failed");
        require(p.votesFor >= MIN_VOTES, "Insufficient participation");
        require(!p.executed, "Already executed");

        p.executed = true;
        (bool success, ) = p.target.call{value: p.value}("");
        require(success, "Transfer failed");
    }

    receive() external payable {}
}
