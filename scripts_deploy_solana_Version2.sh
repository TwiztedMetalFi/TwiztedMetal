#!/bin/bash
set -e

# Build and deploy Solana program
cd solana_program
anchor build
solana program deploy target/deploy/super_token.so --url devnet