# Twizted Metal

**Twizted Metal** is a cross-chain DeFi dApp and AMM DEX on the Optimism Mainnet with native bridging to Solana.  
It features a custom ERC-20 (SuperToken), Solana native token, LayerZero-based bridge, Chainlink oracles, gasless swaps (Pimlico), and real-time analytics (Sentio)—all ready for BuildBear sandboxing and rapid prototyping.

## Features
- SuperToken (ERC-20, Optimism)
- SuperToken-SOL (Solana Native)
- AMM/DEX pools with Chainlink price feeds
- LayerZero cross-chain bridging (Optimism↔Solana)
- Gasless swaps via Pimlico
- BuildBear, Blockscout, IARD Analyzer, Solidity Scan, Sentio plugin integration
- Modern React/Tailwind frontend

## Quick Start

1. **Clone:**  
   `git clone https://github.com/YOUR-USER/twizted-metal.git`

2. **Codespace:**  
   - Open in GitHub Codespaces (auto-installs Node, Hardhat, Solana tools)

3. **Install:**  
   ```bash
   npm install
   ```

4. **Deploy Contracts (BuildBear):**  
   ```bash
   npx hardhat run scripts/deploy.js --network buildbear
   ```

5. **Deploy Solana Program:**  
   ```bash
   chmod +x scripts/deploy_solana.sh
   ./scripts/deploy_solana.sh
   ```

6. **Frontend:**  
   ```bash
   cd frontend
   npx serve
   ```

7. **Update addresses:**  
   - Paste deployed contract addresses in `frontend/index.html` as needed.

8. **Monitor:**  
   - BuildBear explorer: https://explorer.buildbear.io/unfortunate-nickfury-a4e1cf72

---

## Structure

```
twizted-metal/
  contracts/
    SuperToken.sol
    PoolFactory.sol
    LiquidityPool.sol
    BridgeAdapter.sol
  solana_program/
    src/
      super_token.rs
  frontend/
    index.html
  scripts/
    deploy.js
    deploy_solana.sh
    advance_time.js
  .devcontainer/
    devcontainer.json
  hardhat.config.js
  package.json
  README.md
```

---

## Credits

Built for the Twizted Metal appchain and the BuildBear DeFi sandbox.
