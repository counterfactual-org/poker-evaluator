// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { BaseScript } from "./BaseScript.s.sol";

import { IHashtable } from "src/interfaces/IHashtable.sol";
import { DpTables } from "src/DpTables.sol";
import { Evaluator5 } from "src/Evaulator5.sol";
import { NoFlush5_1 } from "src/noflush5/NoFlush5_1.sol";
import { NoFlush5_2 } from "src/noflush5/NoFlush5_2.sol";
import { NoFlush5_3 } from "src/noflush5/NoFlush5_3.sol";

contract DeployEvaluator5 is BaseScript {
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

        address evaluator = _loadDeployment("Evaluator5");
        if (evaluator == address(0)) {
            IHashtable[3] memory noflushes;
            noflushes[0] = IHashtable(address(new NoFlush5_1{ salt: SALT }()));
            noflushes[1] = IHashtable(address(new NoFlush5_2{ salt: SALT }()));
            noflushes[2] = IHashtable(address(new NoFlush5_3{ salt: SALT }()));
            evaluator = address(new Evaluator5{ salt: SALT }(DpTables(dpTables), flushes, noflushes));
            _saveDeployment("NoFlush5_1", address(noflushes[0]));
            _saveDeployment("NoFlush5_2", address(noflushes[1]));
            _saveDeployment("NoFlush5_3", address(noflushes[2]));
            _saveDeployment("Evaluator5", evaluator);
        }
    }
}
