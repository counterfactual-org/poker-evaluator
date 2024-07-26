// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { BaseScript } from "./BaseScript.s.sol";

import { IHashtable } from "src/interfaces/IHashtable.sol";
import { DpTables } from "src/DpTables.sol";
import { Evaluator7 } from "src/Evaulator7.sol";
import { NoFlush7_1 } from "src/noflush7/NoFlush7_1.sol";
import { NoFlush7_10 } from "src/noflush7/NoFlush7_10.sol";
import { NoFlush7_11 } from "src/noflush7/NoFlush7_11.sol";
import { NoFlush7_12 } from "src/noflush7/NoFlush7_12.sol";
import { NoFlush7_13 } from "src/noflush7/NoFlush7_13.sol";
import { NoFlush7_14 } from "src/noflush7/NoFlush7_14.sol";
import { NoFlush7_15 } from "src/noflush7/NoFlush7_15.sol";
import { NoFlush7_16 } from "src/noflush7/NoFlush7_16.sol";
import { NoFlush7_17 } from "src/noflush7/NoFlush7_17.sol";
import { NoFlush7_2 } from "src/noflush7/NoFlush7_2.sol";
import { NoFlush7_3 } from "src/noflush7/NoFlush7_3.sol";
import { NoFlush7_4 } from "src/noflush7/NoFlush7_4.sol";
import { NoFlush7_5 } from "src/noflush7/NoFlush7_5.sol";
import { NoFlush7_6 } from "src/noflush7/NoFlush7_6.sol";
import { NoFlush7_7 } from "src/noflush7/NoFlush7_7.sol";
import { NoFlush7_8 } from "src/noflush7/NoFlush7_8.sol";
import { NoFlush7_9 } from "src/noflush7/NoFlush7_9.sol";

contract DeployEvaluator7 is BaseScript {
    bytes32 private constant SALT = bytes32(uint256(0));

    function _run(uint256, address) internal override {
        _enforceChain(ARBITRUM);

        address dpTables = _loadDeployment("DpTables");
        if (dpTables == address(0)) revert("DpTables not deployed");
        IHashtable[3] memory flushes;
        flushes[0] = IHashtable(_loadDeployment("Flush1"));
        flushes[1] = IHashtable(_loadDeployment("Flush2"));
        flushes[2] = IHashtable(_loadDeployment("Flush3"));
        if (address(flushes[0]) == address(0) || address(flushes[1]) == address(0) || address(flushes[2]) == address(0))
        {
            revert("Flushes not deployed");
        }

        address evaluator = _loadDeployment("Evaluator7");
        if (evaluator == address(0)) {
            IHashtable[17] memory noflushes;
            noflushes[0] = IHashtable(address(new NoFlush7_1{ salt: SALT }()));
            noflushes[1] = IHashtable(address(new NoFlush7_2{ salt: SALT }()));
            noflushes[2] = IHashtable(address(new NoFlush7_3{ salt: SALT }()));
            noflushes[3] = IHashtable(address(new NoFlush7_4{ salt: SALT }()));
            noflushes[4] = IHashtable(address(new NoFlush7_5{ salt: SALT }()));
            noflushes[5] = IHashtable(address(new NoFlush7_6{ salt: SALT }()));
            noflushes[6] = IHashtable(address(new NoFlush7_7{ salt: SALT }()));
            noflushes[7] = IHashtable(address(new NoFlush7_8{ salt: SALT }()));
            noflushes[8] = IHashtable(address(new NoFlush7_9{ salt: SALT }()));
            noflushes[9] = IHashtable(address(new NoFlush7_10{ salt: SALT }()));
            noflushes[10] = IHashtable(address(new NoFlush7_11{ salt: SALT }()));
            noflushes[11] = IHashtable(address(new NoFlush7_12{ salt: SALT }()));
            noflushes[12] = IHashtable(address(new NoFlush7_13{ salt: SALT }()));
            noflushes[13] = IHashtable(address(new NoFlush7_14{ salt: SALT }()));
            noflushes[14] = IHashtable(address(new NoFlush7_15{ salt: SALT }()));
            noflushes[15] = IHashtable(address(new NoFlush7_16{ salt: SALT }()));
            noflushes[16] = IHashtable(address(new NoFlush7_17{ salt: SALT }()));
            evaluator = address(new Evaluator7{ salt: SALT }(DpTables(dpTables), flushes, noflushes));
            _saveDeployment("NoFlush7_1", address(noflushes[0]));
            _saveDeployment("NoFlush7_2", address(noflushes[1]));
            _saveDeployment("NoFlush7_3", address(noflushes[2]));
            _saveDeployment("NoFlush7_4", address(noflushes[3]));
            _saveDeployment("NoFlush7_5", address(noflushes[4]));
            _saveDeployment("NoFlush7_6", address(noflushes[5]));
            _saveDeployment("NoFlush7_7", address(noflushes[6]));
            _saveDeployment("NoFlush7_8", address(noflushes[7]));
            _saveDeployment("NoFlush7_9", address(noflushes[8]));
            _saveDeployment("NoFlush7_10", address(noflushes[9]));
            _saveDeployment("NoFlush7_11", address(noflushes[10]));
            _saveDeployment("NoFlush7_12", address(noflushes[11]));
            _saveDeployment("NoFlush7_13", address(noflushes[12]));
            _saveDeployment("NoFlush7_14", address(noflushes[13]));
            _saveDeployment("NoFlush7_15", address(noflushes[14]));
            _saveDeployment("NoFlush7_16", address(noflushes[15]));
            _saveDeployment("NoFlush7_17", address(noflushes[16]));
            _saveDeployment("Evaluator7", evaluator);
        }
    }
}
