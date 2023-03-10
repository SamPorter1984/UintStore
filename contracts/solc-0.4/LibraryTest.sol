// SPDX-License-Identifier: MIT
pragma solidity ^0.4.18;

//import 'hardhat/console.sol';

import './UintStore.sol';

contract LibTest {
    using UintStore for uint;
    using UintStore for bool[];

    struct TestStruct {
        uint240 sstoreTest240;
        bool b;
        bool bb;
        uint256 sstoreTest256;
        bool bbb;
        bool bbbb;
    }

    mapping(address => TestStruct) testStruct;
    uint makeItIntoSomeBasicTransaction;
    uint makeItIntoSomeBasicTransactionBitShift;
    uint makeItIntoSomeBasicTransactionConv;
    uint makeItIntoSomeBasicTransactionConv1;
    uint sstoreTest;
    uint sstoreTestBitShift;
    uint240 sstoreTest240;
    bool b;
    bool bb;
    bool[] sstoreBools;

    function testPackAndUnpackBooleans(bool[] memory bools) public pure returns (bool[] memory) {
        uint uintBools = bools.packBools();
        return uintBools.extBools(bools.length);
    }

    function testPackAndUnpackBooleansBitShift(bool[] memory bools) public pure returns (bool[] memory) {
        uint uintBools = bools.packBoolsBitShift();
        return uintBools.extBoolsBitShift(bools.length);
    }

    function testPackAndUnpackBooleansWithUint(bool[] memory bools, uint n, uint base, uint bitSize) public pure returns (bool[] memory, uint) {
        uint uintStore = n.packBoolsWithUint(bools, base);
        bool[] memory extBools;
        uint z;
        (extBools, z) = uintStore.extBoolsWithUint(bitSize);
        return (extBools, z);
    }

    function testPackAndUnpackBooleansWithUintBitShift(bool[] memory bools, uint n, uint base) public pure returns (bool[] memory, uint) {
        uint uintStore = n.packBoolsWithUintBitShift(bools, base);
        bool[] memory extBools;
        uint z;
        (extBools, z) = uintStore.extBoolsWithUintBitShift(bools.length, base);
        return (extBools, z);
    }

    //sstore
    function sstoreBooleansPackedGasTest(bool[] memory bools) public {
        sstoreTest = bools.packBools();
    }

    function sstoreBooleansPackedBitShiftGasTest(bool[] memory bools) public {
        sstoreTestBitShift = bools.packBoolsBitShift();
    }

    function sstoreBoolsGasTest(bool[] memory bools) public {
        sstoreBools = bools;
    }

    function sstoreBoolsAndUintPackedGasTest(bool[] memory bools, uint n, uint base) public {
        sstoreTest = n.packBoolsWithUint(bools, base);
    }

    function sstoreBoolsAndUintPackedBitShiftGasTest(bool[] memory bools, uint n, uint base) public {
        sstoreTestBitShift = n.packBoolsWithUintBitShift(bools, base);
    }

    function sstore2BoolsAndUint240Conventionally(uint8 base) public {
        testStruct[msg.sender].sstoreTest240 = uint240(2 ** (base - 1));
        testStruct[msg.sender].b = true;
        testStruct[msg.sender].bb = true;
    }

    function sstore2BoolsAndUint256Conventionally(uint8 base) public {
        testStruct[msg.sender].sstoreTest256 = 2 ** (base - 1);
        testStruct[msg.sender].bbb = true;
        testStruct[msg.sender].bbbb = true;
    }

    //sload
    function sloadPackedBoolsAndExtGasTest(uint length) public {
        uint memoryTest = sstoreTest;
        bool[] memory bools = memoryTest.extBools(length);
        uint result;
        for (uint n = 0; n < bools.length; n++) {
            if (bools[n]) {
                result += 11111111111;
            }
        }
        makeItIntoSomeBasicTransaction = result;
    }

    function sloadPackedBoolsAndExtBitShiftGasTest(uint length) public {
        uint memoryTest = sstoreTestBitShift;
        bool[] memory bools = memoryTest.extBoolsBitShift(length);
        uint result;
        for (uint n = 0; n < bools.length; n++) {
            if (bools[n]) {
                result += 11111111111;
            }
        }
        makeItIntoSomeBasicTransactionBitShift = result;
    }

    function sloadPackedBoolsAndUintAndExtGasTest(uint bitSize) public {
        bool[] memory extBools;
        uint z;
        (extBools, z) = sstoreTest.extBoolsWithUint(bitSize);
        uint result = z;
        for (uint n = 0; n < extBools.length; n++) {
            if (extBools[n]) {
                result += 11111111111;
            }
        }
        makeItIntoSomeBasicTransaction = result;
    }

    function sloadPackedBoolsAndUintAndExtBitShiftGasTest(uint bitSize, uint msb) public {
        bool[] memory extBools;
        uint z;
        (extBools, z) = sstoreTestBitShift.extBoolsWithUintBitShift(bitSize, msb);

        uint result = z;
        for (uint n = 0; n < extBools.length; n++) {
            if (extBools[n]) {
                result += 11111111111;
            }
        }
        makeItIntoSomeBasicTransactionBitShift = result;
    }

    function sloadBoolsGasTest() public {
        bool[] memory bools = sstoreBools;
        uint result;
        for (uint n = 0; n < bools.length; n++) {
            if (bools[n]) {
                result += 11111111111;
            }
        }
        makeItIntoSomeBasicTransactionConv = result;
    }

    function sload2BoolsAndUint240Conventionally() public {
        uint result = testStruct[msg.sender].sstoreTest240;
        if (testStruct[msg.sender].b) {
            result += 2 ** 127;
        }
        if (testStruct[msg.sender].bb) {
            result += 2 ** 127;
        }
        makeItIntoSomeBasicTransactionConv = result;
    }

    function sload2BoolsAndUint256Conventionally() public {
        uint result = testStruct[msg.sender].sstoreTest256;
        if (testStruct[msg.sender].bbb) {
            result += 2 ** 127;
        }
        if (testStruct[msg.sender].bbbb) {
            result += 2 ** 127;
        }
        makeItIntoSomeBasicTransactionConv1 = result;
    }

    // sstop
    bool b0;
    bool b1;
    bool b2;
    bool b3;
    bool b4;
    bool b5;
    bool b6;
    bool b7;
    bool b8;
    bool b9;
    bool b10;
    bool b11;
    bool b12;
    bool b13;
    bool b14;
    bool b15;
    bool b16;
    bool b17;
    bool b18;
    bool b19;
    bool b20;
    bool b21;
    bool b22;
    bool b23;
    bool b24;
    bool b25;
    bool b26;
    bool b27;
    bool b28;
    bool b29;
    bool b30;
    bool b31;
    bool b32;
    bool b33;
    bool b34;
    bool b35;
    bool b36;
    bool b37;
    bool b38;
    bool b39;
    bool b40;
    bool b41;
    bool b42;
    bool b43;
    bool b44;
    bool b45;
    bool b46;
    bool b47;
    bool b48;
    bool b49;
    bool b50;
    bool b51;
    bool b52;
    bool b53;
    bool b54;
    bool b55;
    bool b56;
    bool b57;
    bool b58;
    bool b59;
    bool b60;
    bool b61;
    bool b62;
    bool b63;
    bool b64;
    bool b65;
    bool b66;
    bool b67;
    bool b68;
    bool b69;
    bool b70;
    bool b71;
    bool b72;
    bool b73;
    bool b74;
    bool b75;
    bool b76;
    bool b77;
    bool b78;
    bool b79;
    bool b80;
    bool b81;
    bool b82;
    bool b83;
    bool b84;
    bool b85;
    bool b86;
    bool b87;
    bool b88;
    bool b89;
    bool b90;
    bool b91;
    bool b92;
    bool b93;
    bool b94;
    bool b95;
    bool b96;
    bool b97;
    bool b98;
    bool b99;
    bool b100;
    bool b101;
    bool b102;
    bool b103;
    bool b104;
    bool b105;
    bool b106;
    bool b107;
    bool b108;
    bool b109;
    bool b110;
    bool b111;
    bool b112;
    bool b113;
    bool b114;
    bool b115;
    bool b116;
    bool b117;
    bool b118;
    bool b119;
    bool b120;
    bool b121;
    bool b122;
    bool b123;
    bool b124;
    bool b125;
    bool b126;
    bool b127;
    bool b128;
    bool b129;
    bool b130;
    bool b131;
    bool b132;
    bool b133;
    bool b134;
    bool b135;
    bool b136;
    bool b137;
    bool b138;
    bool b139;
    bool b140;
    bool b141;
    bool b142;
    bool b143;
    bool b144;
    bool b145;
    bool b146;
    bool b147;
    bool b148;
    bool b149;
    bool b150;
    bool b151;
    bool b152;
    bool b153;
    bool b154;
    bool b155;
    bool b156;
    bool b157;
    bool b158;
    bool b159;
    bool b160;
    bool b161;
    bool b162;
    bool b163;
    bool b164;
    bool b165;
    bool b166;
    bool b167;
    bool b168;
    bool b169;
    bool b170;
    bool b171;
    bool b172;
    bool b173;
    bool b174;
    bool b175;
    bool b176;
    bool b177;
    bool b178;
    bool b179;
    bool b180;
    bool b181;
    bool b182;
    bool b183;
    bool b184;
    bool b185;
    bool b186;
    bool b187;
    bool b188;
    bool b189;
    bool b190;
    bool b191;
    bool b192;
    bool b193;
    bool b194;
    bool b195;
    bool b196;
    bool b197;
    bool b198;
    bool b199;
    bool b200;
    bool b201;
    bool b202;
    bool b203;
    bool b204;
    bool b205;
    bool b206;
    bool b207;
    bool b208;
    bool b209;
    bool b210;
    bool b211;
    bool b212;
    bool b213;
    bool b214;
    bool b215;
    bool b216;
    bool b217;
    bool b218;
    bool b219;
    bool b220;
    bool b221;
    bool b222;
    bool b223;
    bool b224;
    bool b225;
    bool b226;
    bool b227;
    bool b228;
    bool b229;
    bool b230;
    bool b231;
    bool b232;
    bool b233;
    bool b234;
    bool b235;
    bool b236;
    bool b237;
    bool b238;
    bool b239;
    bool b240;
    bool b241;
    bool b242;
    bool b243;
    bool b244;
    bool b245;
    bool b246;
    bool b247;
    bool b248;
    bool b249;
    bool b250;
    bool b251;
    bool b252;
    bool b253;
    bool b254;
    bool b255;

    function sstoreSeparate256BoolsGasTest() public {
        b0 = true;
        b1 = true;
        b2 = true;
        b3 = true;
        b4 = true;
        b5 = true;
        b6 = true;
        b7 = true;
        b8 = true;
        b9 = true;
        b10 = true;
        b11 = true;
        b12 = true;
        b13 = true;
        b14 = true;
        b15 = true;
        b16 = true;
        b17 = true;
        b18 = true;
        b19 = true;
        b20 = true;
        b21 = true;
        b22 = true;
        b23 = true;
        b24 = true;
        b25 = true;
        b26 = true;
        b27 = true;
        b28 = true;
        b29 = true;
        b30 = true;
        b31 = true;
        b32 = true;
        b33 = true;
        b34 = true;
        b35 = true;
        b36 = true;
        b37 = true;
        b38 = true;
        b39 = true;
        b40 = true;
        b41 = true;
        b42 = true;
        b43 = true;
        b44 = true;
        b45 = true;
        b46 = true;
        b47 = true;
        b48 = true;
        b49 = true;
        b50 = true;
        b51 = true;
        b52 = true;
        b53 = true;
        b54 = true;
        b55 = true;
        b56 = true;
        b57 = true;
        b58 = true;
        b59 = true;
        b60 = true;
        b61 = true;
        b62 = true;
        b63 = true;
        b64 = true;
        b65 = true;
        b66 = true;
        b67 = true;
        b68 = true;
        b69 = true;
        b70 = true;
        b71 = true;
        b72 = true;
        b73 = true;
        b74 = true;
        b75 = true;
        b76 = true;
        b77 = true;
        b78 = true;
        b79 = true;
        b80 = true;
        b81 = true;
        b82 = true;
        b83 = true;
        b84 = true;
        b85 = true;
        b86 = true;
        b87 = true;
        b88 = true;
        b89 = true;
        b90 = true;
        b91 = true;
        b92 = true;
        b93 = true;
        b94 = true;
        b95 = true;
        b96 = true;
        b97 = true;
        b98 = true;
        b99 = true;
        b100 = true;
        b101 = true;
        b102 = true;
        b103 = true;
        b104 = true;
        b105 = true;
        b106 = true;
        b107 = true;
        b108 = true;
        b109 = true;
        b110 = true;
        b111 = true;
        b112 = true;
        b113 = true;
        b114 = true;
        b115 = true;
        b116 = true;
        b117 = true;
        b118 = true;
        b119 = true;
        b120 = true;
        b121 = true;
        b122 = true;
        b123 = true;
        b124 = true;
        b125 = true;
        b126 = true;
        b127 = true;
        b128 = true;
        b129 = true;
        b130 = true;
        b131 = true;
        b132 = true;
        b133 = true;
        b134 = true;
        b135 = true;
        b136 = true;
        b137 = true;
        b138 = true;
        b139 = true;
        b140 = true;
        b141 = true;
        b142 = true;
        b143 = true;
        b144 = true;
        b145 = true;
        b146 = true;
        b147 = true;
        b148 = true;
        b149 = true;
        b150 = true;
        b151 = true;
        b152 = true;
        b153 = true;
        b154 = true;
        b155 = true;
        b156 = true;
        b157 = true;
        b158 = true;
        b159 = true;
        b160 = true;
        b161 = true;
        b162 = true;
        b163 = true;
        b164 = true;
        b165 = true;
        b166 = true;
        b167 = true;
        b168 = true;
        b169 = true;
        b170 = true;
        b171 = true;
        b172 = true;
        b173 = true;
        b174 = true;
        b175 = true;
        b176 = true;
        b177 = true;
        b178 = true;
        b179 = true;
        b180 = true;
        b181 = true;
        b182 = true;
        b183 = true;
        b184 = true;
        b185 = true;
        b186 = true;
        b187 = true;
        b188 = true;
        b189 = true;
        b190 = true;
        b191 = true;
        b192 = true;
        b193 = true;
        b194 = true;
        b195 = true;
        b196 = true;
        b197 = true;
        b198 = true;
        b199 = true;
        b200 = true;
        b201 = true;
        b202 = true;
        b203 = true;
        b204 = true;
        b205 = true;
        b206 = true;
        b207 = true;
        b208 = true;
        b209 = true;
        b210 = true;
        b211 = true;
        b212 = true;
        b213 = true;
        b214 = true;
        b215 = true;
        b216 = true;
        b217 = true;
        b218 = true;
        b219 = true;
        b220 = true;
        b221 = true;
        b222 = true;
        b223 = true;
        b224 = true;
        b225 = true;
        b226 = true;
        b227 = true;
        b228 = true;
        b229 = true;
        b230 = true;
        b231 = true;
        b232 = true;
        b233 = true;
        b234 = true;
        b235 = true;
        b236 = true;
        b237 = true;
        b238 = true;
        b239 = true;
        b240 = true;
        b241 = true;
        b242 = true;
        b243 = true;
        b244 = true;
        b245 = true;
        b246 = true;
        b247 = true;
        b248 = true;
        b249 = true;
        b250 = true;
        b251 = true;
        b252 = true;
        b253 = true;
        b254 = true;
        b255 = true;
    }
}
