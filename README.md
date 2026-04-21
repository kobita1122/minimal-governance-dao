# Minimal Governance DAO

A clean, flat-structure DAO implementation that allows a community to manage a shared treasury. Members can submit proposals and vote on execution based on their token balance.

### Features
* **Proposal Lifecycle:** Create, vote, and execute.
* **On-chain Voting:** Weighted voting based on governance token ownership.
* **Treasury Management:** Securely hold and release funds via successful proposals.

### How to use
1. Deploy `GovernanceToken.sol` to distribute voting power.
2. Deploy `SimpleDAO.sol` with the token address.
3. Use the `app.js` logic to interact with the contracts via a web browser.
