const { ethers } = require("hardhat");

async function main() {
  // Advance time by 1 week (604800 seconds)
  await ethers.provider.send("evm_increaseTime", [604800]);
  await ethers.provider.send("evm_mine", []);
  console.log("Time advanced by 1 week.");
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});