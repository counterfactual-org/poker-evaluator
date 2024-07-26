// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { BaseEvaluator } from "./BaseEvaluator.sol";
import { DpTables } from "./DpTables.sol";
import { IHashtable } from "./interfaces/IHashtable.sol";

contract Evaluator7 is BaseEvaluator {
    DpTables public immutable dpTables;
    IHashtable public immutable flush;
    IHashtable[7] public noflushes;

    constructor(DpTables _dpTables, IHashtable _flush, IHashtable[7] memory _noflushes) {
        dpTables = _dpTables;
        flush = _flush;
        noflushes = _noflushes;
    }

    function evaluate(uint256[] memory c) public view override returns (uint256) {
        uint256 len = c.length;
        if (len != 7) revert InvalidNumberOfCards();

        uint256 suit_hash;

        suit_hash += bit_of_mod_4_x_3[c[0]];
        suit_hash += bit_of_mod_4_x_3[c[1]];
        suit_hash += bit_of_mod_4_x_3[c[2]];
        suit_hash += bit_of_mod_4_x_3[c[3]];
        suit_hash += bit_of_mod_4_x_3[c[4]];
        suit_hash += bit_of_mod_4_x_3[c[5]];
        suit_hash += bit_of_mod_4_x_3[c[6]];

        uint256 suits = DpTables(dpTables).suits(suit_hash);

        if (suits > 0) {
            uint256[4] memory suit_binary;

            suit_binary[c[0] & 0x3] |= bit_of_div_4[c[0]];
            suit_binary[c[1] & 0x3] |= bit_of_div_4[c[1]];
            suit_binary[c[2] & 0x3] |= bit_of_div_4[c[2]];
            suit_binary[c[3] & 0x3] |= bit_of_div_4[c[3]];
            suit_binary[c[4] & 0x3] |= bit_of_div_4[c[4]];
            suit_binary[c[5] & 0x3] |= bit_of_div_4[c[5]];
            suit_binary[c[6] & 0x3] |= bit_of_div_4[c[6]];

            return flush.get(suit_binary[suits - 1]);
        }

        uint8[13] memory quinary;

        quinary[(c[0] >> 2)]++;
        quinary[(c[1] >> 2)]++;
        quinary[(c[2] >> 2)]++;
        quinary[(c[3] >> 2)]++;
        quinary[(c[4] >> 2)]++;
        quinary[(c[5] >> 2)]++;
        quinary[(c[6] >> 2)]++;

        uint256 hash = DpTables(dpTables).hash_quinary(quinary, 7);

        return noflushes[hash / 8000].get(hash % 8000);
    }
}
