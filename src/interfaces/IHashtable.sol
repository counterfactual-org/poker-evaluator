// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IHashtable {
    function get(uint256 hash) external view returns (uint256);
}
