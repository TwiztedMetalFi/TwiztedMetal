const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  // Deploy SuperToken
  const SuperToken = await hre.ethers.getContractFactory("SuperToken");
  const superToken = await SuperToken.deploy(hre.ethers.utils.parseUnits("1000000", 18));
  await superToken.deployed();
  console.log("SuperToken deployed:", superToken.address);

  // Deploy PoolFactory
  const PoolFactory = await hre.ethers.getContractFactory("PoolFactory");
  const poolFactory = await PoolFactory.deploy();
  await poolFactory.deployed();
  console.log("PoolFactory deployed:", poolFactory.address);

  // Deploy a pool for SuperToken/ETH
  // Use Chainlink ETH/USD feed address for Optimism
  const chainlinkFeed = "0x13e3Ee69994876bA33D91B5c3C9C33E29bA8fD57";
  const tx = await poolFactory.createPool(superToken.address, chainlinkFeed);
  const receipt = await tx.wait();
  const poolAddr = receipt.events.find(e => e.event === "PoolCreated").args.pool;
  console.log("LiquidityPool deployed:", poolAddr);

  // Deploy BridgeAdapter
  // LayerZero endpoint for Optimism, Solana chainId, and receiver address must be set
  const lzEndpoint = "0x...LayerZeroEndpoint";
  const solanaChainId = 10109; // Example
  const solanaReceiver = "0x..."; // Solana bridge receiver bytes
  const BridgeAdapter = await hre.ethers.getContractFactory("BridgeAdapter");
  const bridgeAdapter = await BridgeAdapter.deploy(
    superToken.address,
    lzEndpoint,
    solanaChainId,
    solanaReceiver
  );
  await bridgeAdapter.deployed();
  console.log("BridgeAdapter deployed:", bridgeAdapter.address);

  // Optionally verify contracts with Sourcify
  // Optionally run IARD Solidity Analyzer and Solidity Scan here
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});