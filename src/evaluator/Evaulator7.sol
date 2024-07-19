// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import { DpTables } from "./DpTables.sol";

import { Flush1 } from "./flush/Flush1.sol";
import { Flush2 } from "./flush/Flush2.sol";
import { Flush3 } from "./flush/Flush3.sol";

import { NoFlush1 } from "./noFlush/NoFlush1.sol";

import { NoFlush10 } from "./noFlush/NoFlush10.sol";
import { NoFlush11 } from "./noFlush/NoFlush11.sol";
import { NoFlush12 } from "./noFlush/NoFlush12.sol";
import { NoFlush13 } from "./noFlush/NoFlush13.sol";
import { NoFlush14 } from "./noFlush/NoFlush14.sol";
import { NoFlush15 } from "./noFlush/NoFlush15.sol";
import { NoFlush16 } from "./noFlush/NoFlush16.sol";
import { NoFlush17 } from "./noFlush/NoFlush17.sol";
import { NoFlush2 } from "./noFlush/NoFlush2.sol";
import { NoFlush3 } from "./noFlush/NoFlush3.sol";
import { NoFlush4 } from "./noFlush/NoFlush4.sol";
import { NoFlush5 } from "./noFlush/NoFlush5.sol";
import { NoFlush6 } from "./noFlush/NoFlush6.sol";
import { NoFlush7 } from "./noFlush/NoFlush7.sol";
import { NoFlush8 } from "./noFlush/NoFlush8.sol";
import { NoFlush9 } from "./noFlush/NoFlush9.sol";

contract Evaluator7 {
    address public immutable DP_TABLES;
    address[3] public FLUSH_ADDRESSES;
    address[17] public NOFLUSH_ADDRESSES;

    uint8 public constant HIGH_CARD = 0;
    uint8 public constant ONE_PAIR = 1;
    uint8 public constant TWO_PAIR = 2;
    uint8 public constant THREE_OF_A_KIND = 3;
    uint8 public constant STRAIGHT = 4;
    uint8 public constant FLUSH = 5;
    uint8 public constant FULL_HOUSE = 6;
    uint8 public constant FOUR_OF_A_KIND = 7;
    uint8 public constant STRAIGHT_FLUSH = 8;

    uint256[52] public bit_of_mod_4 = [ // 52
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

    uint256[52] public bit_of_mod_4_x_3 = [ // 52
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

    constructor(address _dpTables, address[3] memory _flushes, address[17] memory _noflushes) {
        DP_TABLES = _dpTables;

        for (uint256 i = 0; i < _flushes.length; i++) {
            FLUSH_ADDRESSES[i] = _flushes[i];
        }

        for (uint256 j = 0; j < _noflushes.length; j++) {
            NOFLUSH_ADDRESSES[j] = _noflushes[j];
        }
    }

    function handRank(uint256 a, uint256 b, uint256 c, uint256 d, uint256 e, uint256 f, uint256 g)
        public
        view
        returns (uint8)
    {
        uint256 val = evaluate(a, b, c, d, e, f, g);

        if (val > 6185) return HIGH_CARD; // 1277 high card
        if (val > 3325) return ONE_PAIR; // 2860 one pair
        if (val > 2467) return TWO_PAIR; //  858 two pair
        if (val > 1609) return THREE_OF_A_KIND; //  858 three-kind
        if (val > 1599) return STRAIGHT; //   10 straights
        if (val > 322) return FLUSH; // 1277 flushes
        if (val > 166) return FULL_HOUSE; //  156 full house
        if (val > 10) return FOUR_OF_A_KIND; //  156 four-kind
        return STRAIGHT_FLUSH; //   10 straight-flushes
    }

    function evaluate(uint256 a, uint256 b, uint256 c, uint256 d, uint256 e, uint256 f, uint256 g)
        public
        view
        returns (uint256)
    {
        uint256 suit_hash;

        suit_hash += bit_of_mod_4_x_3[a]; // (1 << ((a % 4) * 3))
        suit_hash += bit_of_mod_4_x_3[b]; // (1 << ((a % 4) * 3))
        suit_hash += bit_of_mod_4_x_3[c]; // (1 << ((a % 4) * 3))
        suit_hash += bit_of_mod_4_x_3[d]; // (1 << ((a % 4) * 3))
        suit_hash += bit_of_mod_4_x_3[e]; // (1 << ((a % 4) * 3))
        suit_hash += bit_of_mod_4_x_3[f]; // (1 << ((a % 4) * 3))
        suit_hash += bit_of_mod_4_x_3[g]; // (1 << ((a % 4) * 3))

        uint256 suits = DpTables(DP_TABLES).suits(suit_hash);

        if (suits > 0) {
            uint256[4] memory suit_binary;

            suit_binary[a & 0x3] |= bit_of_mod_4[a];
            suit_binary[b & 0x3] |= bit_of_mod_4[b];
            suit_binary[c & 0x3] |= bit_of_mod_4[c];
            suit_binary[d & 0x3] |= bit_of_mod_4[d];
            suit_binary[e & 0x3] |= bit_of_mod_4[e];
            suit_binary[f & 0x3] |= bit_of_mod_4[f];
            suit_binary[g & 0x3] |= bit_of_mod_4[g];

            uint256 sb = suit_binary[suits - 1];
            if (sb < 3000) {
                return Flush1(FLUSH_ADDRESSES[0]).flush(suit_binary[suits - 1]);
            } else if (sb < 6000) {
                return Flush2(FLUSH_ADDRESSES[1]).flush(suit_binary[suits - 1] - 3000);
            } else {
                return Flush3(FLUSH_ADDRESSES[2]).flush(suit_binary[suits - 1] - 6000);
            }
        }

        uint8[13] memory quinary;

        quinary[(a >> 2)]++;
        quinary[(b >> 2)]++;
        quinary[(c >> 2)]++;
        quinary[(d >> 2)]++;
        quinary[(e >> 2)]++;
        quinary[(f >> 2)]++;
        quinary[(g >> 2)]++;

        uint256 hsh = hash_quinary(quinary, 7);

        if (hsh < 3000) {
            return NoFlush1(NOFLUSH_ADDRESSES[0]).noflush(hsh);
        } else if (hsh < 6000) {
            return NoFlush2(NOFLUSH_ADDRESSES[1]).noflush(hsh - 3000);
        } else if (hsh < 9000) {
            return NoFlush3(NOFLUSH_ADDRESSES[2]).noflush(hsh - 6000);
        } else if (hsh < 12_000) {
            return NoFlush4(NOFLUSH_ADDRESSES[3]).noflush(hsh - 9000);
        } else if (hsh < 15_000) {
            return NoFlush5(NOFLUSH_ADDRESSES[4]).noflush(hsh - 12_000);
        } else if (hsh < 18_000) {
            return NoFlush6(NOFLUSH_ADDRESSES[5]).noflush(hsh - 15_000);
        } else if (hsh < 21_000) {
            return NoFlush7(NOFLUSH_ADDRESSES[6]).noflush(hsh - 18_000);
        } else if (hsh < 24_000) {
            return NoFlush8(NOFLUSH_ADDRESSES[7]).noflush(hsh - 21_000);
        } else if (hsh < 27_000) {
            return NoFlush9(NOFLUSH_ADDRESSES[8]).noflush(hsh - 24_000);
        } else if (hsh < 30_000) {
            return NoFlush10(NOFLUSH_ADDRESSES[9]).noflush(hsh - 27_000);
        } else if (hsh < 33_000) {
            return NoFlush11(NOFLUSH_ADDRESSES[10]).noflush(hsh - 30_000);
        } else if (hsh < 36_000) {
            return NoFlush12(NOFLUSH_ADDRESSES[11]).noflush(hsh - 33_000);
        } else if (hsh < 39_000) {
            return NoFlush13(NOFLUSH_ADDRESSES[12]).noflush(hsh - 36_000);
        } else if (hsh < 42_000) {
            return NoFlush14(NOFLUSH_ADDRESSES[13]).noflush(hsh - 39_000);
        } else if (hsh < 45_000) {
            return NoFlush15(NOFLUSH_ADDRESSES[14]).noflush(hsh - 42_000);
        } else if (hsh < 48_000) {
            return NoFlush16(NOFLUSH_ADDRESSES[15]).noflush(hsh - 45_000);
        } else {
            return NoFlush17(NOFLUSH_ADDRESSES[16]).noflush(hsh - 48_000);
        }
    }

    function hash_quinary(uint8[13] memory q, int256 k) public view returns (uint256 sum) {
        uint256 len = 13;
        for (uint256 i = 0; i < len; i++) {
            sum += DpTables(DP_TABLES).dp(q[i], (len - i - 1), uint256(k));

            k -= int256(uint256(q[i]));

            if (k <= 0) break;
        }
    }
}
