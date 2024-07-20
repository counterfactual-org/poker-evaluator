// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IEvaluator } from "./interfaces/IEvaluator.sol";

abstract contract BaseEvaluator is IEvaluator {
    // bit_of_div_4[a] = (1 << (a / 4))
    uint256[52] public bit_of_div_4 = [
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

    // bit_of_mod_4_x_3[a] = (1 << ((a % 4) * 3))
    uint256[52] public bit_of_mod_4_x_3 = [
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

    function handRank(uint256[] memory cards) public view returns (HandRank rank, uint256 eval) {
        eval = evaluate(cards);

        if (eval > 6185) return (HandRank.HighCard, eval); // 1277 high card
        if (eval > 3325) return (HandRank.OnePair, eval); // 2860 one pair
        if (eval > 2467) return (HandRank.TwoPair, eval); //  858 two pair
        if (eval > 1609) return (HandRank.ThreeOfAKind, eval); //  858 three-kind
        if (eval > 1599) return (HandRank.Straight, eval); //   10 straights
        if (eval > 322) return (HandRank.Flush, eval); // 1277 flushes
        if (eval > 166) return (HandRank.FullHouse, eval); //  156 full house
        if (eval > 10) return (HandRank.FourOfAKind, eval); //  156 four-kind
        return (HandRank.StraightFlush, eval); //   10 straight-flushes
    }

    function evaluate(uint256[] memory c) public view virtual returns (uint256);
}
