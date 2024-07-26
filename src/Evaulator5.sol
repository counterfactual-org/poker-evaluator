// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { BaseEvaluator } from "./BaseEvaluator.sol";
import { DpTables } from "./DpTables.sol";
import { IHashtable } from "./interfaces/IHashtable.sol";

contract Evaluator5 is BaseEvaluator {
    DpTables public immutable dpTables;
    IHashtable public immutable flush;
    IHashtable public immutable noflush;

    constructor(DpTables _dpTables, IHashtable _flush, IHashtable _noflush) {
        dpTables = _dpTables;
        flush = _flush;
        noflush = _noflush;
    }

    function evaluate(uint256[] memory c) public view override returns (uint256) {
        uint256 len = c.length;
        if (len != 5) revert InvalidNumberOfCards();

        uint256 suit_hash;

        suit_hash += bit_of_mod_4_x_3[c[0]];
        suit_hash += bit_of_mod_4_x_3[c[1]];
        suit_hash += bit_of_mod_4_x_3[c[2]];
        suit_hash += bit_of_mod_4_x_3[c[3]];
        suit_hash += bit_of_mod_4_x_3[c[4]];

        uint256 suits = DpTables(dpTables).suits(suit_hash);

        if (suits > 0) {
            uint256[4] memory suit_binary;

            suit_binary[c[0] & 0x3] |= bit_of_div_4[c[0]];
            suit_binary[c[1] & 0x3] |= bit_of_div_4[c[1]];
            suit_binary[c[2] & 0x3] |= bit_of_div_4[c[2]];
            suit_binary[c[3] & 0x3] |= bit_of_div_4[c[3]];
            suit_binary[c[4] & 0x3] |= bit_of_div_4[c[4]];

            return flush.get(suit_binary[suits - 1]);
        }

        uint8[13] memory quinary;

        quinary[(c[0] >> 2)]++;
        quinary[(c[1] >> 2)]++;
        quinary[(c[2] >> 2)]++;
        quinary[(c[3] >> 2)]++;
        quinary[(c[4] >> 2)]++;

        return noflush.get(DpTables(dpTables).hash_quinary(quinary, 5));
    }
}
