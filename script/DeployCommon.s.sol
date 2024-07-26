// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { BaseScript } from "./BaseScript.s.sol";

import { IHashtable } from "src/interfaces/IHashtable.sol";
import { DpTables } from "src/DpTables.sol";
import { Flush } from "src/hashtables/Flush.sol";

contract DeployCommon is BaseScript {
    bytes32 private constant SALT = bytes32(uint256(0));

    function _run(uint256, address) internal override {
        _enforceChain(ARBITRUM);

        address dpTables = _loadDeployment("DpTables");
        if (dpTables == address(0)) {
            IHashtable flush = IHashtable(_loadDeployment("Flush"));
            if (address(flush) == address(0)) flush = new Flush{ salt: SALT }();
            dpTables = address(new DpTables{ salt: SALT }());
            _saveDeployment("Flush", address(flush));
            _saveDeployment("DpTables", dpTables);
        }
    }
}
