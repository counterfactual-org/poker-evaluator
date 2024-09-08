// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { BaseEvaluator } from "./BaseEvaluator.sol";
import { DpTables } from "./DpTables.sol";
import { IHashtable } from "./interfaces/IHashtable.sol";

contract Evaluator9 is BaseEvaluator {
    uint16[52] public binaries_by_id = [
        0x1,
        0x1,
        0x1,
        0x1,
        0x2,
        0x2,
        0x2,
        0x2,
        0x4,
        0x4,
        0x4,
        0x4,
        0x8,
        0x8,
        0x8,
        0x8,
        0x10,
        0x10,
        0x10,
        0x10,
        0x20,
        0x20,
        0x20,
        0x20,
        0x40,
        0x40,
        0x40,
        0x40,
        0x80,
        0x80,
        0x80,
        0x80,
        0x100,
        0x100,
        0x100,
        0x100,
        0x200,
        0x200,
        0x200,
        0x200,
        0x400,
        0x400,
        0x400,
        0x400,
        0x800,
        0x800,
        0x800,
        0x800,
        0x1000,
        0x1000,
        0x1000,
        0x1000
    ];

    uint16[52] public suitbit_by_id = [
        0x1,
        0x8,
        0x40,
        0x200,
        0x1,
        0x8,
        0x40,
        0x200,
        0x1,
        0x8,
        0x40,
        0x200,
        0x1,
        0x8,
        0x40,
        0x200,
        0x1,
        0x8,
        0x40,
        0x200,
        0x1,
        0x8,
        0x40,
        0x200,
        0x1,
        0x8,
        0x40,
        0x200,
        0x1,
        0x8,
        0x40,
        0x200,
        0x1,
        0x8,
        0x40,
        0x200,
        0x1,
        0x8,
        0x40,
        0x200,
        0x1,
        0x8,
        0x40,
        0x200,
        0x1,
        0x8,
        0x40,
        0x200,
        0x1,
        0x8,
        0x40,
        0x200
    ];

    DpTables public immutable dpTables;
    IHashtable public immutable flush;
    IHashtable[34] public noflushes;

    constructor(DpTables _dpTables, IHashtable _flush, IHashtable[34] memory _noflushes) {
        dpTables = _dpTables;
        flush = _flush;
        noflushes = _noflushes;
    }

    function evaluate(uint256[] memory c) public view override returns (uint256) {
        uint256 len = c.length;
        if (len != 9) revert InvalidNumberOfCards();

        uint256 value_flush = 10_000;
        uint256 value_noflush = 10_000;
        uint256[4] memory suit_counter;

        suit_counter[c[0] & 0x3]++;
        suit_counter[c[1] & 0x3]++;
        suit_counter[c[2] & 0x3]++;
        suit_counter[c[3] & 0x3]++;
        suit_counter[c[4] & 0x3]++;
        suit_counter[c[5] & 0x3]++;
        suit_counter[c[6] & 0x3]++;
        suit_counter[c[7] & 0x3]++;
        suit_counter[c[8] & 0x3]++;

        for (uint256 l = 0; l < 4; ++l) {
            if (suit_counter[l] >= 5) {
                uint256[4] memory suit_binary;
                suit_binary[c[0] & 0x3] |= binaries_by_id[c[0]];
                suit_binary[c[1] & 0x3] |= binaries_by_id[c[1]];
                suit_binary[c[2] & 0x3] |= binaries_by_id[c[2]];
                suit_binary[c[3] & 0x3] |= binaries_by_id[c[3]];
                suit_binary[c[4] & 0x3] |= binaries_by_id[c[4]];
                suit_binary[c[5] & 0x3] |= binaries_by_id[c[5]];
                suit_binary[c[6] & 0x3] |= binaries_by_id[c[6]];
                suit_binary[c[7] & 0x3] |= binaries_by_id[c[7]];
                suit_binary[c[8] & 0x3] |= binaries_by_id[c[8]];

                value_flush = flush.get(suit_binary[l]);

                break;
            }
        }

        uint8[13] memory quinary;
        quinary[(c[0] >> 2)]++;
        quinary[(c[1] >> 2)]++;
        quinary[(c[2] >> 2)]++;
        quinary[(c[3] >> 2)]++;
        quinary[(c[4] >> 2)]++;
        quinary[(c[5] >> 2)]++;
        quinary[(c[6] >> 2)]++;
        quinary[(c[7] >> 2)]++;
        quinary[(c[8] >> 2)]++;

        uint256 hash = DpTables(dpTables).hash_quinary(quinary, 9);

        value_noflush = noflushes[hash / 8000].get(hash % 8000);

        if (value_flush < value_noflush) return value_flush;
        else return value_noflush;
    }
}
