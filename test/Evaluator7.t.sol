// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import { Test, console } from "forge-std/Test.sol";

import { DpTables } from "src/evaluator/DpTables.sol";
import { Evaluator7 } from "src/evaluator/Evaulator7.sol";
import { Flush1 } from "src/evaluator/flush/Flush1.sol";
import { Flush2 } from "src/evaluator/flush/Flush2.sol";
import { Flush3 } from "src/evaluator/flush/Flush3.sol";
import { NoFlush1 } from "src/evaluator/noflush/NoFlush1.sol";

import { NoFlush10 } from "src/evaluator/noflush/NoFlush10.sol";
import { NoFlush11 } from "src/evaluator/noflush/NoFlush11.sol";
import { NoFlush12 } from "src/evaluator/noflush/NoFlush12.sol";
import { NoFlush13 } from "src/evaluator/noflush/NoFlush13.sol";
import { NoFlush14 } from "src/evaluator/noflush/NoFlush14.sol";
import { NoFlush15 } from "src/evaluator/noflush/NoFlush15.sol";
import { NoFlush16 } from "src/evaluator/noflush/NoFlush16.sol";
import { NoFlush17 } from "src/evaluator/noflush/NoFlush17.sol";
import { NoFlush2 } from "src/evaluator/noflush/NoFlush2.sol";
import { NoFlush3 } from "src/evaluator/noflush/NoFlush3.sol";
import { NoFlush4 } from "src/evaluator/noflush/NoFlush4.sol";
import { NoFlush5 } from "src/evaluator/noflush/NoFlush5.sol";
import { NoFlush6 } from "src/evaluator/noflush/NoFlush6.sol";
import { NoFlush7 } from "src/evaluator/noflush/NoFlush7.sol";
import { NoFlush8 } from "src/evaluator/noflush/NoFlush8.sol";
import { NoFlush9 } from "src/evaluator/noflush/NoFlush9.sol";

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

    uint8 public constant HIGH_CARD = 0;
    uint8 public constant ONE_PAIR = 1;
    uint8 public constant TWO_PAIR = 2;
    uint8 public constant THREE_OF_A_KIND = 3;
    uint8 public constant STRAIGHT = 4;
    uint8 public constant FLUSH = 5;
    uint8 public constant FULL_HOUSE = 6;
    uint8 public constant FOUR_OF_A_KIND = 7;
    uint8 public constant STRAIGHT_FLUSH = 8;

    address private owner = makeAddr("owner");
    address private treasury = makeAddr("treasury");
    address private alice = makeAddr("alice");
    address private bob = makeAddr("bob");
    address private charlie = makeAddr("charlie");

    Evaluator7 private evaluator;

    function setUp() public {
        address[3] memory flushes;
        flushes[0] = address(new Flush1());
        flushes[1] = address(new Flush2());
        flushes[2] = address(new Flush3());
        address[17] memory noflushes;
        noflushes[0] = address(new NoFlush1());
        noflushes[1] = address(new NoFlush2());
        noflushes[2] = address(new NoFlush3());
        noflushes[3] = address(new NoFlush4());
        noflushes[4] = address(new NoFlush5());
        noflushes[5] = address(new NoFlush6());
        noflushes[6] = address(new NoFlush7());
        noflushes[7] = address(new NoFlush8());
        noflushes[8] = address(new NoFlush9());
        noflushes[9] = address(new NoFlush10());
        noflushes[10] = address(new NoFlush11());
        noflushes[11] = address(new NoFlush12());
        noflushes[12] = address(new NoFlush13());
        noflushes[13] = address(new NoFlush14());
        noflushes[14] = address(new NoFlush15());
        noflushes[15] = address(new NoFlush16());
        noflushes[16] = address(new NoFlush17());
        evaluator = new Evaluator7(address(new DpTables()), flushes, noflushes);
    }

    function test_handRank_cases() public view {
        _assertHandRank("5c Th 3d Jh Qh Kh Ah", STRAIGHT_FLUSH);
        _assertHandRank("5c Th 3d Jh Qh Kh Ah", STRAIGHT_FLUSH);
        _assertHandRank("5c Th 3d Jh Qh Kh 9h", STRAIGHT_FLUSH);
        _assertHandRank("5c Th 3d Jh Js Jd Jc", FOUR_OF_A_KIND);
        _assertHandRank("5c Th 3d Jh Js Jd Tc", FULL_HOUSE);
        _assertHandRank("5c 8h 3d Jh Qh Kh 9h", FLUSH);
        _assertHandRank("5c Th 3d Jh Qh Kh As", STRAIGHT);
        _assertHandRank("5c As 3d 2h 3d 4h 5c", STRAIGHT);
        _assertHandRank("5c Th 3d Jh Js Jd 9c", THREE_OF_A_KIND);
        _assertHandRank("5c Th 3d Jh Js 9d 9c", TWO_PAIR);
        _assertHandRank("5c Th 3d Jh 2s 9d 9c", ONE_PAIR);
        _assertHandRank("5c Th 3d Jh 2s Ad 9c", HIGH_CARD);
    }

    function _assertHandRank(string memory hand, uint8 expectation) internal view {
        uint8 suit;
        uint8 rank;
        uint256[7] memory cardCodes;
        for (uint256 i; i < 7; ++i) {
            suit = _toSuit(bytes(hand)[3 * i + 1]);
            rank = _toRank(bytes(hand)[3 * i]);
            cardCodes[i] = _toCardCode(suit, rank);
            console.log(cardCodes[i]);
        }
        assertEq(
            evaluator.handRank(
                cardCodes[0], cardCodes[1], cardCodes[2], cardCodes[3], cardCodes[4], cardCodes[5], cardCodes[6]
            ),
            expectation
        );
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
                for (uint8 c2 = c1 + 1; c0 < 48; ++c2) {
                    for (uint8 c3 = c2 + 1; c3 < 49; ++c3) {
                        for (uint8 c4 = c3 + 1; c4 < 50; ++c4) {
                            for (uint8 c5 = c4 + 1; c5 < 51; ++c5) {
                                for (uint8 c6 = c5 + 1; c6 < 52; ++c6) {
                                    console.log(c0, c1, c2);
                                    console.log(c3, c4, c5, c6);
                                    uint8 result = evaluator.handRank(c0, c1, c2, c3, c4, c5, c6);
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
