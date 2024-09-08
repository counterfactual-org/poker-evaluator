// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { BaseScript } from "./BaseScript.s.sol";

import { IHashtable } from "src/interfaces/IHashtable.sol";
import { DpTables } from "src/DpTables.sol";
import { Evaluator9 } from "src/Evaluator9.sol";
import { Noflush9_00 } from "src/hashtables/Noflush9_00.sol";
import { Noflush9_01 } from "src/hashtables/Noflush9_01.sol";
import { Noflush9_02 } from "src/hashtables/Noflush9_02.sol";
import { Noflush9_03 } from "src/hashtables/Noflush9_03.sol";
import { Noflush9_04 } from "src/hashtables/Noflush9_04.sol";
import { Noflush9_05 } from "src/hashtables/Noflush9_05.sol";
import { Noflush9_06 } from "src/hashtables/Noflush9_06.sol";
import { Noflush9_07 } from "src/hashtables/Noflush9_07.sol";
import { Noflush9_08 } from "src/hashtables/Noflush9_08.sol";
import { Noflush9_09 } from "src/hashtables/Noflush9_09.sol";
import { Noflush9_10 } from "src/hashtables/Noflush9_10.sol";
import { Noflush9_11 } from "src/hashtables/Noflush9_11.sol";
import { Noflush9_12 } from "src/hashtables/Noflush9_12.sol";
import { Noflush9_13 } from "src/hashtables/Noflush9_13.sol";
import { Noflush9_14 } from "src/hashtables/Noflush9_14.sol";
import { Noflush9_15 } from "src/hashtables/Noflush9_15.sol";
import { Noflush9_16 } from "src/hashtables/Noflush9_16.sol";
import { Noflush9_17 } from "src/hashtables/Noflush9_17.sol";
import { Noflush9_18 } from "src/hashtables/Noflush9_18.sol";
import { Noflush9_19 } from "src/hashtables/Noflush9_19.sol";
import { Noflush9_20 } from "src/hashtables/Noflush9_20.sol";
import { Noflush9_21 } from "src/hashtables/Noflush9_21.sol";
import { Noflush9_22 } from "src/hashtables/Noflush9_22.sol";
import { Noflush9_23 } from "src/hashtables/Noflush9_23.sol";
import { Noflush9_24 } from "src/hashtables/Noflush9_24.sol";
import { Noflush9_25 } from "src/hashtables/Noflush9_25.sol";
import { Noflush9_26 } from "src/hashtables/Noflush9_26.sol";
import { Noflush9_27 } from "src/hashtables/Noflush9_27.sol";
import { Noflush9_28 } from "src/hashtables/Noflush9_28.sol";
import { Noflush9_29 } from "src/hashtables/Noflush9_29.sol";
import { Noflush9_30 } from "src/hashtables/Noflush9_30.sol";
import { Noflush9_31 } from "src/hashtables/Noflush9_31.sol";
import { Noflush9_32 } from "src/hashtables/Noflush9_32.sol";
import { Noflush9_33 } from "src/hashtables/Noflush9_33.sol";

contract DeployEvaluator9 is BaseScript {
    bytes32 private constant SALT = bytes32(uint256(0));

    function _run(uint256, address) internal override {
        address dpTables = _loadDeployment("DpTables");
        if (dpTables == address(0)) revert("DpTables not deployed");
        IHashtable flush = IHashtable(_loadDeployment("Flush"));
        if (address(flush) == address(0)) revert("Flush not deployed");

        address evaluator = _loadDeployment("Evaluator9");
        if (evaluator == address(0)) {
            IHashtable[34] memory noflushes;
            noflushes[0] = IHashtable(address(new Noflush9_00{ salt: SALT }()));
            noflushes[1] = IHashtable(address(new Noflush9_01{ salt: SALT }()));
            noflushes[2] = IHashtable(address(new Noflush9_02{ salt: SALT }()));
            noflushes[3] = IHashtable(address(new Noflush9_03{ salt: SALT }()));
            noflushes[4] = IHashtable(address(new Noflush9_04{ salt: SALT }()));
            noflushes[5] = IHashtable(address(new Noflush9_05{ salt: SALT }()));
            noflushes[6] = IHashtable(address(new Noflush9_06{ salt: SALT }()));
            noflushes[7] = IHashtable(address(new Noflush9_07{ salt: SALT }()));
            noflushes[8] = IHashtable(address(new Noflush9_08{ salt: SALT }()));
            noflushes[9] = IHashtable(address(new Noflush9_09{ salt: SALT }()));
            noflushes[10] = IHashtable(address(new Noflush9_10{ salt: SALT }()));
            noflushes[11] = IHashtable(address(new Noflush9_11{ salt: SALT }()));
            noflushes[12] = IHashtable(address(new Noflush9_12{ salt: SALT }()));
            noflushes[13] = IHashtable(address(new Noflush9_13{ salt: SALT }()));
            noflushes[14] = IHashtable(address(new Noflush9_14{ salt: SALT }()));
            noflushes[15] = IHashtable(address(new Noflush9_15{ salt: SALT }()));
            noflushes[16] = IHashtable(address(new Noflush9_16{ salt: SALT }()));
            noflushes[17] = IHashtable(address(new Noflush9_17{ salt: SALT }()));
            noflushes[18] = IHashtable(address(new Noflush9_18{ salt: SALT }()));
            noflushes[19] = IHashtable(address(new Noflush9_19{ salt: SALT }()));
            noflushes[20] = IHashtable(address(new Noflush9_20{ salt: SALT }()));
            noflushes[21] = IHashtable(address(new Noflush9_21{ salt: SALT }()));
            noflushes[22] = IHashtable(address(new Noflush9_22{ salt: SALT }()));
            noflushes[23] = IHashtable(address(new Noflush9_23{ salt: SALT }()));
            noflushes[24] = IHashtable(address(new Noflush9_24{ salt: SALT }()));
            noflushes[25] = IHashtable(address(new Noflush9_25{ salt: SALT }()));
            noflushes[26] = IHashtable(address(new Noflush9_26{ salt: SALT }()));
            noflushes[27] = IHashtable(address(new Noflush9_27{ salt: SALT }()));
            noflushes[28] = IHashtable(address(new Noflush9_28{ salt: SALT }()));
            noflushes[29] = IHashtable(address(new Noflush9_29{ salt: SALT }()));
            noflushes[30] = IHashtable(address(new Noflush9_30{ salt: SALT }()));
            noflushes[31] = IHashtable(address(new Noflush9_31{ salt: SALT }()));
            noflushes[32] = IHashtable(address(new Noflush9_32{ salt: SALT }()));
            noflushes[33] = IHashtable(address(new Noflush9_33{ salt: SALT }()));
            evaluator = address(new Evaluator9{ salt: SALT }(DpTables(dpTables), flush, noflushes));
            _saveDeployment("NoFlush9_00", address(noflushes[0]));
            _saveDeployment("NoFlush9_01", address(noflushes[1]));
            _saveDeployment("NoFlush9_02", address(noflushes[2]));
            _saveDeployment("NoFlush9_03", address(noflushes[3]));
            _saveDeployment("NoFlush9_04", address(noflushes[4]));
            _saveDeployment("NoFlush9_05", address(noflushes[5]));
            _saveDeployment("NoFlush9_06", address(noflushes[6]));
            _saveDeployment("NoFlush9_07", address(noflushes[7]));
            _saveDeployment("NoFlush9_08", address(noflushes[8]));
            _saveDeployment("NoFlush9_09", address(noflushes[9]));
            _saveDeployment("NoFlush9_10", address(noflushes[10]));
            _saveDeployment("NoFlush9_11", address(noflushes[11]));
            _saveDeployment("NoFlush9_12", address(noflushes[12]));
            _saveDeployment("NoFlush9_13", address(noflushes[13]));
            _saveDeployment("NoFlush9_14", address(noflushes[14]));
            _saveDeployment("NoFlush9_15", address(noflushes[15]));
            _saveDeployment("NoFlush9_16", address(noflushes[16]));
            _saveDeployment("NoFlush9_17", address(noflushes[17]));
            _saveDeployment("NoFlush9_18", address(noflushes[18]));
            _saveDeployment("NoFlush9_19", address(noflushes[19]));
            _saveDeployment("NoFlush9_20", address(noflushes[20]));
            _saveDeployment("NoFlush9_21", address(noflushes[21]));
            _saveDeployment("NoFlush9_22", address(noflushes[22]));
            _saveDeployment("NoFlush9_23", address(noflushes[23]));
            _saveDeployment("NoFlush9_24", address(noflushes[24]));
            _saveDeployment("NoFlush9_25", address(noflushes[25]));
            _saveDeployment("NoFlush9_26", address(noflushes[26]));
            _saveDeployment("NoFlush9_27", address(noflushes[27]));
            _saveDeployment("NoFlush9_28", address(noflushes[28]));
            _saveDeployment("NoFlush9_29", address(noflushes[29]));
            _saveDeployment("NoFlush9_30", address(noflushes[30]));
            _saveDeployment("NoFlush9_31", address(noflushes[31]));
            _saveDeployment("NoFlush9_32", address(noflushes[32]));
            _saveDeployment("NoFlush9_33", address(noflushes[33]));
            _saveDeployment("Evaluator9", evaluator);
        }
    }
}
