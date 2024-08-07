// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { BaseScript } from "./BaseScript.s.sol";

import { IHashtable } from "src/interfaces/IHashtable.sol";
import { DpTables } from "src/DpTables.sol";
import { Evaluator7 } from "src/Evaulator7.sol";
import { Noflush7_0 } from "src/hashtables/Noflush7_0.sol";
import { Noflush7_1 } from "src/hashtables/Noflush7_1.sol";
import { Noflush7_2 } from "src/hashtables/Noflush7_2.sol";
import { Noflush7_3 } from "src/hashtables/Noflush7_3.sol";
import { Noflush7_4 } from "src/hashtables/Noflush7_4.sol";
import { Noflush7_5 } from "src/hashtables/Noflush7_5.sol";
import { Noflush7_6 } from "src/hashtables/Noflush7_6.sol";

contract DeployEvaluator7 is BaseScript {
    bytes32 private constant SALT = bytes32(uint256(0));

    function _run(uint256, address) internal override {
        address dpTables = _loadDeployment("DpTables");
        if (dpTables == address(0)) revert("DpTables not deployed");
        IHashtable flush = IHashtable(_loadDeployment("Flush"));
        if (address(flush) == address(0)) revert("Flush not deployed");

        address evaluator = _loadDeployment("Evaluator7");
        if (evaluator == address(0)) {
            IHashtable[7] memory noflushes;
            noflushes[0] = IHashtable(address(new Noflush7_0{ salt: SALT }()));
            noflushes[1] = IHashtable(address(new Noflush7_1{ salt: SALT }()));
            noflushes[2] = IHashtable(address(new Noflush7_2{ salt: SALT }()));
            noflushes[3] = IHashtable(address(new Noflush7_3{ salt: SALT }()));
            noflushes[4] = IHashtable(address(new Noflush7_4{ salt: SALT }()));
            noflushes[5] = IHashtable(address(new Noflush7_5{ salt: SALT }()));
            noflushes[6] = IHashtable(address(new Noflush7_6{ salt: SALT }()));
            evaluator = address(new Evaluator7{ salt: SALT }(DpTables(dpTables), flush, noflushes));
            _saveDeployment("NoFlush7_0", address(noflushes[0]));
            _saveDeployment("NoFlush7_1", address(noflushes[1]));
            _saveDeployment("NoFlush7_2", address(noflushes[2]));
            _saveDeployment("NoFlush7_3", address(noflushes[3]));
            _saveDeployment("NoFlush7_4", address(noflushes[4]));
            _saveDeployment("NoFlush7_5", address(noflushes[5]));
            _saveDeployment("NoFlush7_6", address(noflushes[6]));
            _saveDeployment("Evaluator7", evaluator);
        }
    }
}
