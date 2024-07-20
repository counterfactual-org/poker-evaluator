// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import { Test, console } from "forge-std/Test.sol";

import { IEvaluator } from "src/interfaces/IEvaluator.sol";
import { IHashtable } from "src/interfaces/IHashtable.sol";
import { DpTables } from "src/DpTables.sol";
import { Evaluator5 } from "src/Evaulator5.sol";
import { Flush1 } from "src/flush/Flush1.sol";
import { Flush2 } from "src/flush/Flush2.sol";
import { Flush3 } from "src/flush/Flush3.sol";
import { NoFlush5_1 } from "src/noflush5/NoFlush5_1.sol";
import { NoFlush5_2 } from "src/noflush5/NoFlush5_2.sol";
import { NoFlush5_3 } from "src/noflush5/NoFlush5_3.sol";

contract Evaluator5Test is Test {
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

    Evaluator5 private evaluator;

    function setUp() public {
        IHashtable[3] memory flushes;
        flushes[0] = IHashtable(address(new Flush1()));
        flushes[1] = IHashtable(address(new Flush2()));
        flushes[2] = IHashtable(address(new Flush3()));
        IHashtable[3] memory noflushes;
        noflushes[0] = IHashtable(address(new NoFlush5_1()));
        noflushes[1] = IHashtable(address(new NoFlush5_2()));
        noflushes[2] = IHashtable(address(new NoFlush5_3()));
        evaluator = new Evaluator5(new DpTables(), flushes, noflushes);
    }

    function test_handRank_cases() public view {
        _assertHandRank("Th Jh Qh Kh Ah", IEvaluator.HandRank.StraightFlush);
        _assertHandRank("Th Jh Qh Kh 9h", IEvaluator.HandRank.StraightFlush);
        _assertHandRank("Th Jh Js Jd Jc", IEvaluator.HandRank.FourOfAKind);
        _assertHandRank("Th Jh Js Jd Tc", IEvaluator.HandRank.FullHouse);
        _assertHandRank("8h Jh Qh Kh 9h", IEvaluator.HandRank.Flush);
        _assertHandRank("Th Jh Qh Kh As", IEvaluator.HandRank.Straight);
        _assertHandRank("As 2h 3d 4h 5c", IEvaluator.HandRank.Straight);
        _assertHandRank("Th Jh Js Jd 9c", IEvaluator.HandRank.ThreeOfAKind);
        _assertHandRank("Th Jh Js 9d 9c", IEvaluator.HandRank.TwoPair);
        _assertHandRank("Th Jh 2s 9d 9c", IEvaluator.HandRank.OnePair);
        _assertHandRank("Th Jh 2s Ad 9c", IEvaluator.HandRank.HighCard);
    }

    function _assertHandRank(string memory hand, IEvaluator.HandRank expected) internal view {
        uint8 suit;
        uint8 rank;
        uint256[] memory cardCodes = new uint256[](5);
        for (uint256 i; i < 5; ++i) {
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
        for (uint8 c0; c0 < 48; ++c0) {
            for (uint8 c1 = c0 + 1; c1 < 49; ++c1) {
                for (uint8 c2 = c1 + 1; c2 < 50; ++c2) {
                    for (uint8 c3 = c2 + 1; c3 < 51; ++c3) {
                        for (uint8 c4 = c3 + 1; c4 < 52; ++c4) {
                            uint256[] memory c = new uint256[](5);
                            c[0] = c0;
                            c[1] = c1;
                            c[2] = c2;
                            c[3] = c3;
                            c[4] = c4;
                            (IEvaluator.HandRank result,) = evaluator.handRank(c);
                            results[uint8(result)]++;
                            count++;
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
        assertEq(count, 2_598_960);
        assertEq(results[0], 1_302_540); // HighCard
        assertEq(results[1], 1_098_240); // OnePair
        assertEq(results[2], 123_552); // TwoPair
        assertEq(results[3], 54_912); // ThreeOfAKind
        assertEq(results[4], 10_200); // Straight
        assertEq(results[5], 5108); // Flush
        assertEq(results[6], 3744); // FullHouse
        assertEq(results[7], 624); // FourOfAKind
        assertEq(results[8], 40); // StraightFlush
    }
}
