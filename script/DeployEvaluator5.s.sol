// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { BaseScript } from "./BaseScript.s.sol";

import { IHashtable } from "src/interfaces/IHashtable.sol";
import { DpTables } from "src/DpTables.sol";
import { Evaluator5 } from "src/Evaulator5.sol";
import { Noflush5 } from "src/hashtables/Noflush5.sol";

contract DeployEvaluator5 is BaseScript {
    bytes32 private constant SALT = bytes32(uint256(0));

    function _run(uint256, address) internal override {
        address dpTables = _loadDeployment("DpTables");
        if (dpTables == address(0)) revert("DpTables not deployed");
        IHashtable flush = IHashtable(_loadDeployment("Flush"));
        if (address(flush) == address(0)) revert("Flush not deployed");

        address evaluator = _loadDeployment("Evaluator5");
        if (evaluator == address(0)) {
            IHashtable noflush = new Noflush5{ salt: SALT }();
            evaluator = address(new Evaluator5{ salt: SALT }(DpTables(dpTables), flush, noflush));
            _saveDeployment("NoFlush5", address(noflush));
            _saveDeployment("Evaluator5", evaluator);
        }
    }
}
