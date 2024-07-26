// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import { Test, console } from "forge-std/Test.sol";

import { IEvaluator } from "src/interfaces/IEvaluator.sol";
import { IHashtable } from "src/interfaces/IHashtable.sol";
import { DpTables } from "src/DpTables.sol";
import { Evaluator7 } from "src/Evaulator7.sol";
import { Flush } from "src/hashtables/Flush.sol";
import { Noflush7_0 } from "src/hashtables/Noflush7_0.sol";
import { Noflush7_1 } from "src/hashtables/Noflush7_1.sol";
import { Noflush7_2 } from "src/hashtables/Noflush7_2.sol";
import { Noflush7_3 } from "src/hashtables/Noflush7_3.sol";
import { Noflush7_4 } from "src/hashtables/Noflush7_4.sol";
import { Noflush7_5 } from "src/hashtables/Noflush7_5.sol";
import { Noflush7_6 } from "src/hashtables/Noflush7_6.sol";

contract Evaluator7Test is Test {
    uint8 public constant SUIT_SPADE = 0;
    uint8 public constant SUIT_HEART = 1;
    uint8 public constant SUIT_DIAMOND = 2;
    uint8 public constant SUIT_CLUB = 3;

    uint8 public constant RANK_TWO = 0;
    uint8 public constant RANK_THREE = 1;
    uint8 public constant RANK_FOUR = 2;
    uint8 public constant RANK_FIVE = 3;
    uint8 public constant RANK_SIX = 4;
    uint8 public constant RANK_SEVEN = 5;
    uint8 public constant RANK_EIGHT = 6;
    uint8 public constant RANK_NINE = 7;
    uint8 public constant RANK_TEN = 8;
    uint8 public constant RANK_JACK = 9;
    uint8 public constant RANK_QUEEN = 10;
    uint8 public constant RANK_KING = 11;
    uint8 public constant RANK_ACE = 12;

    address private owner = makeAddr("owner");
    address private treasury = makeAddr("treasury");
    address private alice = makeAddr("alice");
    address private bob = makeAddr("bob");
    address private charlie = makeAddr("charlie");

    Evaluator7 private evaluator;

    function setUp() public {
        IHashtable flush = new Flush();
        IHashtable[7] memory noflushes;
        noflushes[0] = IHashtable(address(new Noflush7_0()));
        noflushes[1] = IHashtable(address(new Noflush7_1()));
        noflushes[2] = IHashtable(address(new Noflush7_2()));
        noflushes[3] = IHashtable(address(new Noflush7_3()));
        noflushes[4] = IHashtable(address(new Noflush7_4()));
        noflushes[5] = IHashtable(address(new Noflush7_5()));
        noflushes[6] = IHashtable(address(new Noflush7_6()));
        evaluator = new Evaluator7(new DpTables(), flush, noflushes);
    }

    function test_handRank_cases() public view {
        _assertHandRank("5c Th 3d Jh Qh Kh Ah", IEvaluator.HandRank.StraightFlush);
        _assertHandRank("5c Th 3d Jh Qh Kh Ah", IEvaluator.HandRank.StraightFlush);
        _assertHandRank("5c Th 3d Jh Qh Kh 9h", IEvaluator.HandRank.StraightFlush);
        _assertHandRank("5c Th 3d Jh Js Jd Jc", IEvaluator.HandRank.FourOfAKind);
        _assertHandRank("5c Th 3d Jh Js Jd Tc", IEvaluator.HandRank.FullHouse);
        _assertHandRank("5c 8h 3d Jh Qh Kh 9h", IEvaluator.HandRank.Flush);
        _assertHandRank("5c Th 3d Jh Qh Kh As", IEvaluator.HandRank.Straight);
        _assertHandRank("5c As 3d 2h 3d 4h 5c", IEvaluator.HandRank.Straight);
        _assertHandRank("5c Th 3d Jh Js Jd 9c", IEvaluator.HandRank.ThreeOfAKind);
        _assertHandRank("5c Th 3d Jh Js 9d 9c", IEvaluator.HandRank.TwoPair);
        _assertHandRank("5c Th 3d Jh 2s 9d 9c", IEvaluator.HandRank.OnePair);
        _assertHandRank("5c Th 3d Jh 2s Ad 9c", IEvaluator.HandRank.HighCard);
    }

    function _assertHandRank(string memory hand, IEvaluator.HandRank expected) internal view {
        uint8 suit;
        uint8 rank;
        uint256[] memory cardCodes = new uint256[](7);
        for (uint256 i; i < 7; ++i) {
            suit = _toSuit(bytes(hand)[3 * i + 1]);
            rank = _toRank(bytes(hand)[3 * i]);
            cardCodes[i] = _toCardCode(suit, rank);
        }
        (IEvaluator.HandRank actual,) = evaluator.handRank(cardCodes);
        assertEq(uint8(actual), uint8(expected));
    }

    function _toSuit(bytes1 b) internal pure returns (uint8 suit) {
        if (b == "s") {
            suit = SUIT_SPADE;
        } else if (b == "h") {
            suit = SUIT_HEART;
        } else if (b == "d") {
            suit = SUIT_DIAMOND;
        } else if (b == "c") {
            suit = SUIT_CLUB;
        }
    }

    function _toRank(bytes1 b) internal pure returns (uint8 rank) {
        if (b == "2") {
            rank = RANK_TWO;
        } else if (b == "3") {
            rank = RANK_THREE;
        } else if (b == "4") {
            rank = RANK_FOUR;
        } else if (b == "5") {
            rank = RANK_FIVE;
        } else if (b == "6") {
            rank = RANK_SIX;
        } else if (b == "7") {
            rank = RANK_SEVEN;
        } else if (b == "8") {
            rank = RANK_EIGHT;
        } else if (b == "9") {
            rank = RANK_NINE;
        } else if (b == "T") {
            rank = RANK_TEN;
        } else if (b == "J") {
            rank = RANK_JACK;
        } else if (b == "Q") {
            rank = RANK_QUEEN;
        } else if (b == "K") {
            rank = RANK_KING;
        } else if (b == "A") {
            rank = RANK_ACE;
        }
    }

    function _toCardCode(uint8 suit, uint8 rank) internal pure returns (uint256) {
        return (uint256(rank) * 4) | suit;
    }

    function test_evaluate_all() public view {
        uint256[9] memory results;
        uint256 count;
        for (uint8 c0; c0 < 46; ++c0) {
            for (uint8 c1 = c0 + 1; c1 < 47; ++c1) {
                for (uint8 c2 = c1 + 1; c2 < 48; ++c2) {
                    for (uint8 c3 = c2 + 1; c3 < 49; ++c3) {
                        for (uint8 c4 = c3 + 1; c4 < 50; ++c4) {
                            for (uint8 c5 = c4 + 1; c5 < 51; ++c5) {
                                for (uint8 c6 = c5 + 1; c6 < 52; ++c6) {
                                    uint256[] memory c = new uint256[](6);
                                    c[0] = c0;
                                    c[1] = c1;
                                    c[2] = c2;
                                    c[3] = c3;
                                    c[4] = c4;
                                    c[5] = c5;
                                    c[6] = c6;
                                    (IEvaluator.HandRank result,) = evaluator.handRank(c);
                                    results[uint8(result)]++;
                                    count++;
                                }
                            }
                        }
                    }
                }
            }
        }
        uint256 testCount;
        for (uint256 i; i < 9; ++i) {
            console.log(results[i]);
            testCount += results[i];
        }
        console.log(count);

        assertEq(testCount, count);
        assertEq(count, 133_784_560);
        assertEq(results[0], 23_294_460); // HighCard
        assertEq(results[1], 58_627_800); // OnePair
        assertEq(results[2], 31_433_400); // TwoPair
        assertEq(results[3], 6_461_620); // ThreeOfAKind
        assertEq(results[4], 6_180_020); // Straight
        assertEq(results[5], 4_047_644); // Flush
        assertEq(results[6], 3_473_184); // FullHouse
        assertEq(results[7], 224_848); // FourOfAKind
        assertEq(results[8], 41_584); // StraightFlush
    }
}
