// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import { Test, console } from "forge-std/Test.sol";

import { IEvaluator } from "src/interfaces/IEvaluator.sol";
import { IHashtable } from "src/interfaces/IHashtable.sol";
import { DpTables } from "src/DpTables.sol";
import { Evaluator9 } from "src/Evaluator9.sol";
import { Flush } from "src/hashtables/Flush.sol";
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

contract Evaluator9Test is Test {
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

    Evaluator9 private evaluator;

    function setUp() public {
        IHashtable flush = new Flush();
        IHashtable[34] memory noflushes;
        noflushes[0] = IHashtable(address(new Noflush9_00()));
        noflushes[1] = IHashtable(address(new Noflush9_01()));
        noflushes[2] = IHashtable(address(new Noflush9_02()));
        noflushes[3] = IHashtable(address(new Noflush9_03()));
        noflushes[4] = IHashtable(address(new Noflush9_04()));
        noflushes[5] = IHashtable(address(new Noflush9_05()));
        noflushes[6] = IHashtable(address(new Noflush9_06()));
        noflushes[7] = IHashtable(address(new Noflush9_07()));
        noflushes[8] = IHashtable(address(new Noflush9_08()));
        noflushes[9] = IHashtable(address(new Noflush9_09()));
        noflushes[10] = IHashtable(address(new Noflush9_10()));
        noflushes[11] = IHashtable(address(new Noflush9_11()));
        noflushes[12] = IHashtable(address(new Noflush9_12()));
        noflushes[13] = IHashtable(address(new Noflush9_13()));
        noflushes[14] = IHashtable(address(new Noflush9_14()));
        noflushes[15] = IHashtable(address(new Noflush9_15()));
        noflushes[16] = IHashtable(address(new Noflush9_16()));
        noflushes[17] = IHashtable(address(new Noflush9_17()));
        noflushes[18] = IHashtable(address(new Noflush9_18()));
        noflushes[19] = IHashtable(address(new Noflush9_19()));
        noflushes[20] = IHashtable(address(new Noflush9_20()));
        noflushes[21] = IHashtable(address(new Noflush9_21()));
        noflushes[22] = IHashtable(address(new Noflush9_22()));
        noflushes[23] = IHashtable(address(new Noflush9_23()));
        noflushes[24] = IHashtable(address(new Noflush9_24()));
        noflushes[25] = IHashtable(address(new Noflush9_25()));
        noflushes[26] = IHashtable(address(new Noflush9_26()));
        noflushes[27] = IHashtable(address(new Noflush9_27()));
        noflushes[28] = IHashtable(address(new Noflush9_28()));
        noflushes[29] = IHashtable(address(new Noflush9_29()));
        noflushes[30] = IHashtable(address(new Noflush9_30()));
        noflushes[31] = IHashtable(address(new Noflush9_31()));
        noflushes[32] = IHashtable(address(new Noflush9_32()));
        noflushes[33] = IHashtable(address(new Noflush9_33()));
        evaluator = new Evaluator9(new DpTables(), flush, noflushes);
    }

    function test_handRank_cases() public view {
        _assertHandRank("5c Th 3d Jh Qh Kh Ah 2s 2h", IEvaluator.HandRank.StraightFlush);
        _assertHandRank("5c Th 3d Jh Qh Kh Ah 2s 2h", IEvaluator.HandRank.StraightFlush);
        _assertHandRank("5c Th 3d Jh Qh Kh 9h 2s 2h", IEvaluator.HandRank.StraightFlush);
        _assertHandRank("5c Th 3d Jh Js Jd Jc 2s 2h", IEvaluator.HandRank.FourOfAKind);
        _assertHandRank("5c Th 3d Jh Js Jd Tc 2s 2h", IEvaluator.HandRank.FullHouse);
        _assertHandRank("5c 8h 3d Jh Qh Kh 9h 2s 2h", IEvaluator.HandRank.Flush);
        _assertHandRank("5c Th 3d Jh Qh Kh As 2s 2d", IEvaluator.HandRank.Straight);
        _assertHandRank("5c As 3d 2h 3d 4h 5c 2s 4h", IEvaluator.HandRank.Straight);
        _assertHandRank("5c Th 3d Jh Js Jd 9c 2s 4h", IEvaluator.HandRank.ThreeOfAKind);
        _assertHandRank("5c Th 3d Jh Js 9d 9c 2s 4h", IEvaluator.HandRank.TwoPair);
        _assertHandRank("5c Th 3d Jh 2s 9d 9c 4s 7h", IEvaluator.HandRank.OnePair);
        _assertHandRank("5c Th 3d Jh 2s Ad 9c 6s 7h", IEvaluator.HandRank.HighCard);
    }

    function _assertHandRank(string memory hand, IEvaluator.HandRank expected) internal view {
        uint8 suit;
        uint8 rank;
        uint256[] memory cardCodes = new uint256[](9);
        for (uint256 i; i < 9; ++i) {
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
}
