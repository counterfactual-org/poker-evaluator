#!/bin/sh

source .env
forge script DeployCommon     --rpc-url $RPC_URL 
forge script DeployEvaluator5 --rpc-url $RPC_URL 
forge script DeployEvaluator7 --rpc-url $RPC_URL 
