#!/bin/sh

source .env
rm deployments/50161.json
RPC_URL=http://localhost:50161
forge script DeployCommon     --rpc-url $RPC_URL --broadcast --slow
forge script DeployEvaluator5 --rpc-url $RPC_URL --broadcast --slow
forge script DeployEvaluator7 --rpc-url $RPC_URL --broadcast --slow
forge script DeployEvaluator9 --rpc-url $RPC_URL --broadcast --slow
