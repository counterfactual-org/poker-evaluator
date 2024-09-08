#!/bin/sh

source .env
forge script DeployCommon     --rpc-url $RPC_URL --broadcast
forge script DeployEvaluator5 --rpc-url $RPC_URL --broadcast
forge script DeployEvaluator7 --rpc-url $RPC_URL --broadcast
forge script DeployEvaluator9 --rpc-url $RPC_URL --broadcast
