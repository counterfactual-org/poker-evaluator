// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { BaseScript } from "./BaseScript.s.sol";

import { IHashtable } from "src/interfaces/IHashtable.sol";
import { DpTables } from "src/DpTables.sol";
import { Flush1 } from "src/flush/Flush1.sol";
import { Flush2 } from "src/flush/Flush2.sol";
import { Flush3 } from "src/flush/Flush3.sol";

contract DeployCommon is BaseScript {
    bytes32 private constant SALT = bytes32(uint256(0));

    function _run(uint256, address) internal override {
        _enforceChain(ARBITRUM);

        address dpTables = _loadDeployment("DpTables");
        IHashtable[3] memory flushes;
        if (dpTables == address(0)) {
            flushes[0] = IHashtable(_loadDeployment("Flush1"));
            flushes[1] = IHashtable(_loadDeployment("Flush2"));
            flushes[2] = IHashtable(_loadDeployment("Flush3"));
            if (address(flushes[0]) == address(0)) flushes[0] = IHashtable(address(new Flush1{ salt: SALT }()));
            if (address(flushes[1]) == address(0)) flushes[1] = IHashtable(address(new Flush2{ salt: SALT }()));
            if (address(flushes[2]) == address(0)) flushes[2] = IHashtable(address(new Flush3{ salt: SALT }()));
            dpTables = address(new DpTables{ salt: SALT }());
            _saveDeployment("Flush1", address(flushes[0]));
            _saveDeployment("Flush2", address(flushes[1]));
            _saveDeployment("Flush3", address(flushes[2]));
            _saveDeployment("DpTables", dpTables);
        }
    }
}
