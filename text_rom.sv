//------------------------------------------------------------------------------
// Title         : Character memory
//------------------------------------------------------------------------------
// File          : text_rom.sv
// Author        : David Ramón Alamán
// Created       : 02.08.2024
//------------------------------------------------------------------------------
// Description: Stores the bit representation of the characters. 
//------------------------------------------------------------------------------

module text_rom( 
    input logic[9:0] addr,
    output logic[7:0] data
);

always_comb begin
        case (addr)
            // "A"
            10'h000: data <= 8'b00000000; // 
            10'h001: data <= 8'b00000000; // 
            10'h002: data <= 8'b00000000; //
            10'h003: data <= 8'b00111100; //  ####       
            10'h004: data <= 8'b01111110; // ######
            10'h005: data <= 8'b01100110; // ##  ##
            10'h006: data <= 8'b01100110; // ##  ##
            10'h007: data <= 8'b01100110; // ##  ##
            10'h008: data <= 8'b01100110; // ##  ##
            10'h009: data <= 8'b01111110; // ######
            10'h00A: data <= 8'b01111110; // ######
            10'h00B: data <= 8'b01100110; // ##  ##
            10'h00C: data <= 8'b01100110; // ##  ##
            10'h00D: data <= 8'b00000000; //
            10'h00E: data <= 8'b00000000; //
            10'h00F: data <= 8'b00000000; //
            // "B"
            10'h010: data <= 8'b00000000; //
            10'h011: data <= 8'b00000000; //
            10'h012: data <= 8'b00000000; //
            10'h013: data <= 8'b00111110; // #####
            10'h014: data <= 8'b01111110; // ######
            10'h015: data <= 8'b01100110; // ##  ##
            10'h016: data <= 8'b01100110; // ##  ##
            10'h017: data <= 8'b00111110; // #####
            10'h018: data <= 8'b00111110; // #####
            10'h019: data <= 8'b01100110; // ##  ##
            10'h01A: data <= 8'b01100110; // ##  ##
            10'h01B: data <= 8'b01111110; // ######
            10'h01C: data <= 8'b00111110; // #####
            10'h01D: data <= 8'b00000000; //
            10'h01E: data <= 8'b00000000; //
            10'h01F: data <= 8'b00000000; //
            // "C"
            10'h020: data <= 8'b00000000; //
            10'h021: data <= 8'b00000000; //
            10'h022: data <= 8'b00000000; //
            10'h023: data <= 8'b00111100; //  ####
            10'h024: data <= 8'b01111110; // ######
            10'h025: data <= 8'b01100110; // ##  ##
            10'h026: data <= 8'b00000110; // ##
            10'h027: data <= 8'b00000110; // ##
            10'h028: data <= 8'b00000110; // ##
            10'h029: data <= 8'b00000110; // ##
            10'h02A: data <= 8'b01100110; // ##  ##
            10'h02B: data <= 8'b01111110; // ######
            10'h02C: data <= 8'b00111100; //  ####
            10'h02D: data <= 8'b00000000; //
            10'h02E: data <= 8'b00000000; //
            10'h02F: data <= 8'b00000000; //
            // "D"
            10'h030: data <= 8'b00000000; //
            10'h031: data <= 8'b00000000; //
            10'h032: data <= 8'b00000000; //
            10'h033: data <= 8'b00111110; // #####
            10'h034: data <= 8'b01111110; // ######
            10'h035: data <= 8'b01100110; // ##  ##
            10'h036: data <= 8'b01100110; // ##  ##
            10'h037: data <= 8'b01100110; // ##  ##
            10'h038: data <= 8'b01100110; // ##  ##
            10'h039: data <= 8'b01100110; // ##  ##
            10'h03A: data <= 8'b01100110; // ##  ##
            10'h03B: data <= 8'b01111110; // ######
            10'h03C: data <= 8'b00111110; // #####
            10'h03D: data <= 8'b00000000; //
            10'h03E: data <= 8'b00000000; //
            10'h03F: data <= 8'b00000000; //
            // "E"
            10'h040: data <= 8'b00000000; //
            10'h041: data <= 8'b00000000; //
            10'h042: data <= 8'b00000000; //
            10'h043: data <= 8'b01111110; // ######
            10'h044: data <= 8'b01111110; // ######
            10'h045: data <= 8'b00000110; // ##
            10'h046: data <= 8'b00000110; // ##
            10'h047: data <= 8'b00011110; // ####
            10'h048: data <= 8'b00011110; // ####
            10'h049: data <= 8'b00000110; // ##
            10'h04A: data <= 8'b00000110; // ##
            10'h04B: data <= 8'b01111110; // ######
            10'h04C: data <= 8'b01111110; // ######
            10'h04D: data <= 8'b00000000; //
            10'h04E: data <= 8'b00000000; //
            10'h04F: data <= 8'b00000000; //
            // "F"
            10'h050: data <= 8'b00000000; //
            10'h051: data <= 8'b00000000; //
            10'h052: data <= 8'b00000000; //
            10'h053: data <= 8'b01111110; // ######
            10'h054: data <= 8'b01111110; // ######
            10'h055: data <= 8'b00000110; // ##
            10'h056: data <= 8'b00000110; // ##
            10'h057: data <= 8'b00011110; // ####
            10'h058: data <= 8'b00011110; // ####
            10'h059: data <= 8'b00000110; // ##
            10'h05A: data <= 8'b00000110; // ##
            10'h05B: data <= 8'b00000110; // ##
            10'h05C: data <= 8'b00000110; // ##
            10'h05D: data <= 8'b00000000; //
            10'h05E: data <= 8'b00000000; //
            10'h05F: data <= 8'b00000000; //
            // "G"
            10'h060: data <= 8'b00000000; //
            10'h061: data <= 8'b00000000; //
            10'h062: data <= 8'b00000000; //
            10'h063: data <= 8'b00111100; //  ####
            10'h064: data <= 8'b01111110; // ######
            10'h065: data <= 8'b01100110; // ##  ##
            10'h066: data <= 8'b00000110; // ##
            10'h067: data <= 8'b01110110; // ## ###
            10'h068: data <= 8'b01110110; // ## ###
            10'h069: data <= 8'b01100110; // ##  ##
            10'h06A: data <= 8'b01100110; // ##  ##
            10'h06B: data <= 8'b01111110; // ######
            10'h06C: data <= 8'b00111100; //  ####
            10'h06D: data <= 8'b00000000; //
            10'h06E: data <= 8'b00000000; //
            10'h06F: data <= 8'b00000000; //
            // "H"
            10'h070: data <= 8'b00000000; //
            10'h071: data <= 8'b00000000; //
            10'h072: data <= 8'b00000000; //
            10'h073: data <= 8'b01100110; // ##  ##
            10'h074: data <= 8'b01100110; // ##  ##
            10'h075: data <= 8'b01100110; // ##  ##
            10'h076: data <= 8'b01100110; // ##  ##
            10'h077: data <= 8'b01111110; // ######
            10'h078: data <= 8'b01111110; // ######
            10'h079: data <= 8'b01100110; // ##  ##
            10'h07A: data <= 8'b01100110; // ##  ##
            10'h07B: data <= 8'b01100110; // ##  ##
            10'h07C: data <= 8'b01100110; // ##  ##
            10'h07D: data <= 8'b00000000; //
            10'h07E: data <= 8'b00000000; //
            10'h07F: data <= 8'b00000000; //
            // "I"
            10'h080: data <= 8'b00000000; //
            10'h081: data <= 8'b00000000; //
            10'h082: data <= 8'b00000000; //
            10'h083: data <= 8'b01111110; // ######
            10'h084: data <= 8'b01111110; // ######
            10'h085: data <= 8'b00011000; //   ##
            10'h086: data <= 8'b00011000; //   ##
            10'h087: data <= 8'b00011000; //   ##
            10'h088: data <= 8'b00011000; //   ##
            10'h089: data <= 8'b00011000; //   ##
            10'h08A: data <= 8'b00011000; //   ##
            10'h08B: data <= 8'b01111110; // ######
            10'h08C: data <= 8'b01111110; // ######
            10'h08D: data <= 8'b00000000; //
            10'h08E: data <= 8'b00000000; //
            10'h08F: data <= 8'b00000000; //
            // "J"
            10'h090: data <= 8'b00000000; //
            10'h091: data <= 8'b00000000; //
            10'h092: data <= 8'b00000000; //
            10'h093: data <= 8'b01111110; // ######
            10'h094: data <= 8'b01111110; // ######
            10'h095: data <= 8'b01100000; //     ##
            10'h096: data <= 8'b01100000; //     ##
            10'h097: data <= 8'b01100000; //     ##
            10'h098: data <= 8'b01100000; //     ##
            10'h099: data <= 8'b01100110; // ##  ##
            10'h09A: data <= 8'b01100110; // ##  ##
            10'h09B: data <= 8'b01111110; // ######
            10'h09C: data <= 8'b00111100; //  ####
            10'h09D: data <= 8'b00000000; //
            10'h09E: data <= 8'b00000000; //
            10'h09F: data <= 8'b00000000; //
            // "K"
            10'h0A0: data <= 8'b00000000; //
            10'h0A1: data <= 8'b00000000; //
            10'h0A2: data <= 8'b00000000; //
            10'h0A3: data <= 8'b01100110; // ##  ##
            10'h0A4: data <= 8'b01100110; // ##  ##
            10'h0A5: data <= 8'b01100110; // ##  ##
            10'h0A6: data <= 8'b01110110; // ## ###
            10'h0A7: data <= 8'b00111110; // #####
            10'h0A8: data <= 8'b00111110; // #####
            10'h0A9: data <= 8'b01110110; // ## ###
            10'h0AA: data <= 8'b01100110; // ##  ##
            10'h0AB: data <= 8'b01100110; // ##  ##
            10'h0AC: data <= 8'b01100110; // ##  ##
            10'h0AD: data <= 8'b00000000; //
            10'h0AE: data <= 8'b00000000; //
            10'h0AF: data <= 8'b00000000; //
            // "L" 
            10'h0B0: data <= 8'b00000000; //
            10'h0B1: data <= 8'b00000000; //
            10'h0B2: data <= 8'b00000000; //
            10'h0B3: data <= 8'b00000110; // ##
            10'h0B4: data <= 8'b00000110; // ##
            10'h0B5: data <= 8'b00000110; // ##
            10'h0B6: data <= 8'b00000110; // ##
            10'h0B7: data <= 8'b00000110; // ##
            10'h0B8: data <= 8'b00000110; // ##
            10'h0B9: data <= 8'b00000110; // ##
            10'h0BA: data <= 8'b00000110; // ##
            10'h0BB: data <= 8'b01111110; // ######
            10'h0BC: data <= 8'b01111110; // ######
            10'h0BD: data <= 8'b00000000; //
            10'h0BE: data <= 8'b00000000; //
            10'h0BF: data <= 8'b00000000; //
            // "M"
            10'h0C0: data <= 8'b00000000; //
            10'h0C1: data <= 8'b00000000; //
            10'h0C2: data <= 8'b00000000; //
            10'h0C3: data <= 8'b01100011; // ##   ##
            10'h0C4: data <= 8'b01100011; // ##   ##
            10'h0C5: data <= 8'b01110111; // ### ###
            10'h0C6: data <= 8'b01111111; // #######
            10'h0C7: data <= 8'b01101011; // ## # ##
            10'h0C8: data <= 8'b01100011; // ##   ##
            10'h0C9: data <= 8'b01100011; // ##   ##
            10'h0CA: data <= 8'b01100011; // ##   ##
            10'h0CB: data <= 8'b01100011; // ##   ##
            10'h0CC: data <= 8'b01100011; // ##   ##
            10'h0CD: data <= 8'b00000000; //
            10'h0CE: data <= 8'b00000000; //
            10'h0CF: data <= 8'b00000000; //
            // "N"
            10'h0D0: data <= 8'b00000000; //
            10'h0D1: data <= 8'b00000000; //
            10'h0D2: data <= 8'b00000000; //
            10'h0D3: data <= 8'b01100110; // ##  ##
            10'h0D4: data <= 8'b01100110; // ##  ##
            10'h0D5: data <= 8'b01101110; // ### ##
            10'h0D6: data <= 8'b01101110; // ### ##
            10'h0D7: data <= 8'b01111110; // ######
            10'h0D8: data <= 8'b01111110; // ######
            10'h0D9: data <= 8'b01110110; // ## ###
            10'h0DA: data <= 8'b01110110; // ## ###
            10'h0DB: data <= 8'b01100110; // ##  ##
            10'h0DC: data <= 8'b01100110; // ##  ##
            10'h0DD: data <= 8'b00000000; //
            10'h0DE: data <= 8'b00000000; //
            10'h0DF: data <= 8'b00000000; //
            // "O"
            10'h0E0: data <= 8'b00000000; //
            10'h0E1: data <= 8'b00000000; //
            10'h0E2: data <= 8'b00000000; //
            10'h0E3: data <= 8'b00111100; //  ####
            10'h0E4: data <= 8'b01111110; // ######
            10'h0E5: data <= 8'b01100110; // ##  ##
            10'h0E6: data <= 8'b01100110; // ##  ##
            10'h0E7: data <= 8'b01100110; // ##  ##
            10'h0E8: data <= 8'b01100110; // ##  ##
            10'h0E9: data <= 8'b01100110; // ##  ##
            10'h0EA: data <= 8'b01100110; // ##  ##
            10'h0EB: data <= 8'b01111110; // ######
            10'h0EC: data <= 8'b00111100; //  ####
            10'h0ED: data <= 8'b00000000; //
            10'h0EE: data <= 8'b00000000; //
            10'h0EF: data <= 8'b00000000; //
            // "P" 
            10'h0F0: data <= 8'b00000000; //
            10'h0F1: data <= 8'b00000000; //
            10'h0F2: data <= 8'b00000000; //
            10'h0F3: data <= 8'b00111110; // #####
            10'h0F4: data <= 8'b01111110; // ######
            10'h0F5: data <= 8'b01100110; // ##  ##
            10'h0F6: data <= 8'b01100110; // ##  ##
            10'h0F7: data <= 8'b01111110; // ######
            10'h0F8: data <= 8'b00111110; // #####
            10'h0F9: data <= 8'b00000110; // ##
            10'h0FA: data <= 8'b00000110; // ##
            10'h0FB: data <= 8'b00000110; // ##
            10'h0FC: data <= 8'b00000110; // ##
            10'h0FD: data <= 8'b00000000; //
            10'h0FE: data <= 8'b00000000; //
            10'h0FF: data <= 8'b00000000; //
            // "Q" 
            10'h100: data <= 8'b00000000; //
            10'h101: data <= 8'b00000000; //
            10'h102: data <= 8'b00000000; //
            10'h103: data <= 8'b00111100; //  ####
            10'h104: data <= 8'b01111110; // ######
            10'h105: data <= 8'b01100110; // ##  ##
            10'h106: data <= 8'b01100110; // ##  ##
            10'h107: data <= 8'b01100110; // ##  ##
            10'h108: data <= 8'b01100110; // ##  ##
            10'h109: data <= 8'b01100110; // ##  ##
            10'h10A: data <= 8'b01110110; // ## ###
            10'h10B: data <= 8'b00111110; // #####
            10'h10C: data <= 8'b01011100; //  ### # 
            10'h10D: data <= 8'b00000000; //
            10'h10E: data <= 8'b00000000; //
            10'h10F: data <= 8'b00000000; //
            // "R" 
            10'h110: data <= 8'b00000000; //
            10'h111: data <= 8'b00000000; //
            10'h112: data <= 8'b00000000; //
            10'h113: data <= 8'b00111110; // #####
            10'h114: data <= 8'b01111110; // ######
            10'h115: data <= 8'b01100110; // ##  ##
            10'h116: data <= 8'b01100110; // ##  ##
            10'h117: data <= 8'b00111110; // #####
            10'h118: data <= 8'b00111110; // ##### 
            10'h119: data <= 8'b01110110; // ## ###
            10'h11A: data <= 8'b01100110; // ##  ##
            10'h11B: data <= 8'b01100110; // ##  ##
            10'h11C: data <= 8'b01100110; // ##  ##
            10'h11D: data <= 8'b00000000; //
            10'h11E: data <= 8'b00000000; //
            10'h11F: data <= 8'b00000000; //
            // "S" 
            10'h120: data <= 8'b00000000; //
            10'h121: data <= 8'b00000000; //
            10'h122: data <= 8'b00000000; //
            10'h123: data <= 8'b00111100; //  ####
            10'h124: data <= 8'b01111110; // ######
            10'h125: data <= 8'b01100110; // ##  ##
            10'h126: data <= 8'b00000110; // ##
            10'h127: data <= 8'b00111110; // #####
            10'h128: data <= 8'b01111100; //  #####
            10'h129: data <= 8'b01100000; //     ##
            10'h12A: data <= 8'b01100110; // ##  ##
            10'h12B: data <= 8'b01111110; // ######
            10'h12C: data <= 8'b00111100; //  ####
            10'h12D: data <= 8'b00000000; //
            10'h12E: data <= 8'b00000000; //
            10'h12F: data <= 8'b00000000; //
            // "T" 
            10'h130: data <= 8'b00000000; //
            10'h131: data <= 8'b00000000; //
            10'h132: data <= 8'b00000000; //
            10'h133: data <= 8'b01111110; // ######
            10'h134: data <= 8'b01111110; // ######
            10'h135: data <= 8'b00011000; //   ##  
            10'h136: data <= 8'b00011000; //   ##
            10'h137: data <= 8'b00011000; //   ##
            10'h138: data <= 8'b00011000; //   ##
            10'h139: data <= 8'b00011000; //   ##
            10'h13A: data <= 8'b00011000; //   ##
            10'h13B: data <= 8'b00011000; //   ##
            10'h13C: data <= 8'b00011000; //   ##
            10'h13D: data <= 8'b00000000; //
            10'h13E: data <= 8'b00000000; //
            10'h13F: data <= 8'b00000000; //
            // "U" 
            10'h140: data <= 8'b00000000; //
            10'h141: data <= 8'b00000000; //
            10'h142: data <= 8'b00000000; //
            10'h143: data <= 8'b01100110; // ##  ##
            10'h144: data <= 8'b01100110; // ##  ##
            10'h145: data <= 8'b01100110; // ##  ##
            10'h146: data <= 8'b01100110; // ##  ##
            10'h147: data <= 8'b01100110; // ##  ##
            10'h148: data <= 8'b01100110; // ##  ##
            10'h149: data <= 8'b01100110; // ##  ##
            10'h14A: data <= 8'b01100110; // ##  ##
            10'h14B: data <= 8'b01111110; // ######
            10'h14C: data <= 8'b00111100; //  ####
            10'h14D: data <= 8'b00000000; //
            10'h14E: data <= 8'b00000000; //
            10'h14F: data <= 8'b00000000; //
            // "V" 
            10'h150: data <= 8'b00000000; //
            10'h151: data <= 8'b00000000; //
            10'h152: data <= 8'b00000000; //
            10'h153: data <= 8'b01100110; // ##  ##
            10'h154: data <= 8'b01100110; // ##  ##
            10'h155: data <= 8'b01100110; // ##  ##
            10'h156: data <= 8'b01100110; // ##  ##
            10'h157: data <= 8'b01100110; // ##  ##
            10'h158: data <= 8'b01100110; // ##  ##
            10'h159: data <= 8'b01100110; // ##  ##
            10'h15A: data <= 8'b01111110; // ######
            10'h15B: data <= 8'b00111100; //  ####
            10'h15C: data <= 8'b00011000; //   ##
            10'h15D: data <= 8'b00000000; //
            10'h15E: data <= 8'b00000000; //
            10'h15F: data <= 8'b00000000; //
            // "W" 
            10'h160: data <= 8'b00000000; //
            10'h161: data <= 8'b00000000; //
            10'h162: data <= 8'b00000000; //
            10'h163: data <= 8'b01100011; // ##   ##
            10'h164: data <= 8'b01100011; // ##   ##
            10'h165: data <= 8'b01100011; // ##   ##
            10'h166: data <= 8'b01100011; // ##   ##
            10'h167: data <= 8'b01100011; // ##   ##
            10'h168: data <= 8'b01100011; // ##   ##
            10'h169: data <= 8'b01110111; // ### ###
            10'h16A: data <= 8'b01111111; // #######
            10'h16B: data <= 8'b01101011; // ## # ##
            10'h16C: data <= 8'b01100011; // ##   ##
            10'h16D: data <= 8'b00000000; //
            10'h16E: data <= 8'b00000000; //
            10'h16F: data <= 8'b00000000; //
            // "X" 
            10'h170: data <= 8'b00000000; //
            10'h171: data <= 8'b00000000; //
            10'h172: data <= 8'b00000000; //
            10'h173: data <= 8'b01100110; // ##  ##
            10'h174: data <= 8'b01100110; // ##  ##
            10'h175: data <= 8'b01100110; // ##  ##
            10'h176: data <= 8'b00111100; //  ####
            10'h177: data <= 8'b00011000; //   ##
            10'h178: data <= 8'b00011000; //   ##
            10'h179: data <= 8'b00111100; //  ####
            10'h17A: data <= 8'b01100110; // ##  ##
            10'h17B: data <= 8'b01100110; // ##  ##
            10'h17C: data <= 8'b01100110; // ##  ##
            10'h17D: data <= 8'b00000000; //
            10'h17E: data <= 8'b00000000; //
            10'h17F: data <= 8'b00000000; //
            // "Y" 
            10'h180: data <= 8'b00000000; //
            10'h181: data <= 8'b00000000; //
            10'h182: data <= 8'b00000000; //
            10'h183: data <= 8'b01100110; // ##  ##
            10'h184: data <= 8'b01100110; // ##  ##
            10'h185: data <= 8'b01100110; // ##  ##
            10'h186: data <= 8'b01111110; // ######
            10'h187: data <= 8'b00111100; //  ####
            10'h188: data <= 8'b00011000; //   ##
            10'h189: data <= 8'b00011000; //   ##
            10'h18A: data <= 8'b00011000; //   ##
            10'h18B: data <= 8'b00011000; //   ##
            10'h18C: data <= 8'b00011000; //   ##
            10'h18D: data <= 8'b00000000; //
            10'h18E: data <= 8'b00000000; //
            10'h18F: data <= 8'b00000000; //
            // "Z" 
            10'h190: data <= 8'b00000000; //
            10'h191: data <= 8'b00000000; //
            10'h192: data <= 8'b00000000; //
            10'h193: data <= 8'b01111110; // ######
            10'h194: data <= 8'b01111110; // ######
            10'h195: data <= 8'b01100000; //     ##
            10'h196: data <= 8'b01110000; //    ###
            10'h197: data <= 8'b00111000; //   ###
            10'h198: data <= 8'b00011100; //  ###
            10'h199: data <= 8'b00001110; // ###
            10'h19A: data <= 8'b00000110; // ##
            10'h19B: data <= 8'b01111110; // ######
            10'h19C: data <= 8'b01111110; // ######
            10'h19D: data <= 8'b00000000; //
            10'h19E: data <= 8'b00000000; //
            10'h19F: data <= 8'b00000000; //
            // " "     > BLANK SPACE < 
            10'h1A0: data <= 8'b00000000; //
            10'h1A1: data <= 8'b00000000; //
            10'h1A2: data <= 8'b00000000; //
            10'h1A3: data <= 8'b00000000; //
            10'h1A4: data <= 8'b00000000; //
            10'h1A5: data <= 8'b00000000; //
            10'h1A6: data <= 8'b00000000; //
            10'h1A7: data <= 8'b00000000; //
            10'h1A8: data <= 8'b00000000; //
            10'h1A9: data <= 8'b00000000; //
            10'h1AA: data <= 8'b00000000; //
            10'h1AB: data <= 8'b00000000; //
            10'h1AC: data <= 8'b00000000; //
            10'h1AD: data <= 8'b00000000; //
            10'h1AE: data <= 8'b00000000; //
            10'h1AF: data <= 8'b00000000; //
            // "."
            10'h1B0: data <= 8'b00000000; //
            10'h1B1: data <= 8'b00000000; //
            10'h1B2: data <= 8'b00000000; //
            10'h1B3: data <= 8'b00000000; //
            10'h1B4: data <= 8'b00000000; //
            10'h1B5: data <= 8'b00000000; //
            10'h1B6: data <= 8'b00000000; //
            10'h1B7: data <= 8'b00000000; //
            10'h1B8: data <= 8'b00000000; //
            10'h1B9: data <= 8'b00000000; //
            10'h1BA: data <= 8'b00000000; //
            10'h1BB: data <= 8'b00000110; // ##
            10'h1BC: data <= 8'b00000110; // ##
            10'h1BD: data <= 8'b00000000; //
            10'h1BE: data <= 8'b00000000; //
            10'h1BF: data <= 8'b00000000; //
            // ":"
            10'h1C0: data <= 8'b00000000; //
            10'h1C1: data <= 8'b00000000; //
            10'h1C2: data <= 8'b00000000; //
            10'h1C3: data <= 8'b00000000; //
            10'h1C4: data <= 8'b00000000; //
            10'h1C5: data <= 8'b00000000; //
            10'h1C6: data <= 8'b00000000; //
            10'h1C7: data <= 8'b00000110; // ##
            10'h1C8: data <= 8'b00000110; // ##
            10'h1C9: data <= 8'b00000000; // 
            10'h1CA: data <= 8'b00000000; //
            10'h1CB: data <= 8'b00000110; // ##
            10'h1CC: data <= 8'b00000110; // ##
            10'h1CD: data <= 8'b00000000; //
            10'h1CE: data <= 8'b00000000; //
            10'h1CF: data <= 8'b00000000; //
            // ","
            10'h1D0: data <= 8'b00000000; //
            10'h1D1: data <= 8'b00000000; //
            10'h1D2: data <= 8'b00000000; //
            10'h1D3: data <= 8'b00000000; //
            10'h1D4: data <= 8'b00000000; //
            10'h1D5: data <= 8'b00000000; //
            10'h1D6: data <= 8'b00000000; //
            10'h1D7: data <= 8'b00000000; //
            10'h1D8: data <= 8'b00000000; //
            10'h1D9: data <= 8'b00000000; //
            10'h1DA: data <= 8'b00000000; //
            10'h1DB: data <= 8'b00000110; // ##
            10'h1DC: data <= 8'b00000110; // ##
            10'h1DD: data <= 8'b00000100; //  #
            10'h1DE: data <= 8'b00000010; // #
            10'h1DF: data <= 8'b00000000; //
            // "!"
            10'h1E0: data <= 8'b00000000; //
            10'h1E1: data <= 8'b00000000; //
            10'h1E2: data <= 8'b00000000; //
            10'h1E3: data <= 8'b00000110; // ##
            10'h1E4: data <= 8'b00000110; // ##
            10'h1E5: data <= 8'b00000110; // ##
            10'h1E6: data <= 8'b00000110; // ##
            10'h1E7: data <= 8'b00000110; // ##
            10'h1E8: data <= 8'b00000110; // ##
            10'h1E9: data <= 8'b00000110; // ##
            10'h1EA: data <= 8'b00000000; //
            10'h1EB: data <= 8'b00000110; // ##
            10'h1EC: data <= 8'b00000110; // ##
            10'h1ED: data <= 8'b00000000; //
            10'h1EE: data <= 8'b00000000; //
            10'h1EF: data <= 8'b00000000; //
            // "?"
            10'h1F0: data <= 8'b00000000; //
            10'h1F1: data <= 8'b00000000; //
            10'h1F2: data <= 8'b00000000; //
            10'h1F3: data <= 8'b00111100; //  ####
            10'h1F4: data <= 8'b01111110; // ######
            10'h1F5: data <= 8'b01100110; // ##  ##
            10'h1F6: data <= 8'b01100000; //     ##
            10'h1F7: data <= 8'b01110000; //    ###
            10'h1F8: data <= 8'b00111000; //   ###
            10'h1F9: data <= 8'b00011000; //   ##
            10'h1FA: data <= 8'b00000000; //
            10'h1FB: data <= 8'b00011000; //   ##
            10'h1FC: data <= 8'b00011000; //   ##
            10'h1FD: data <= 8'b00000000; //
            10'h1FE: data <= 8'b00000000; //
            10'h1FF: data <= 8'b00000000; //
            // "0"
            10'h200: data <= 8'b00000000; //
            10'h201: data <= 8'b00000000; //
            10'h202: data <= 8'b00000000; //
            10'h203: data <= 8'b00111100; //  ####
            10'h204: data <= 8'b01111110; // ######
            10'h205: data <= 8'b01100110; // ##  ##
            10'h206: data <= 8'b01110110; // ## ###
            10'h207: data <= 8'b01110110; // ## ###
            10'h208: data <= 8'b01101110; // ### ##
            10'h209: data <= 8'b01101110; // ### ##
            10'h20A: data <= 8'b01100110; // ##  ##
            10'h20B: data <= 8'b01111110; // ######
            10'h20C: data <= 8'b00111100; //  ####
            10'h20D: data <= 8'b00000000; //
            10'h20E: data <= 8'b00000000; //
            10'h20F: data <= 8'b00000000; //
            
            // "1"
            10'h210: data <= 8'b00000000; //
            10'h211: data <= 8'b00000000; //
            10'h212: data <= 8'b00000000; //
            10'h213: data <= 8'b00011000; //   ##
            10'h214: data <= 8'b00011110; // ####
            10'h215: data <= 8'b00011110; // ####
            10'h216: data <= 8'b00011000; //   ##
            10'h217: data <= 8'b00011000; //   ##
            10'h218: data <= 8'b00011000; //   ##
            10'h219: data <= 8'b00011000; //   ##
            10'h21A: data <= 8'b00011000; //   ##
            10'h21B: data <= 8'b01111110; // ######
            10'h21C: data <= 8'b01111110; // ######
            10'h21D: data <= 8'b00000000; //
            10'h21E: data <= 8'b00000000; //
            10'h21F: data <= 8'b00000000; //
            // "2"
            10'h220: data <= 8'b00000000; //
            10'h221: data <= 8'b00000000; //
            10'h222: data <= 8'b00000000; //
            10'h223: data <= 8'b00111100; //  ####
            10'h224: data <= 8'b01111110; // ######
            10'h225: data <= 8'b01100110; // ##  ##
            10'h226: data <= 8'b01100000; //     ##
            10'h227: data <= 8'b01111000; //   ####
            10'h228: data <= 8'b00111100; //  ####
            10'h229: data <= 8'b00001110; // ###
            10'h22A: data <= 8'b00000110; // ##
            10'h22B: data <= 8'b01111110; // ######
            10'h22C: data <= 8'b01111110; // ######
            10'h22D: data <= 8'b00000000; //
            10'h22E: data <= 8'b00000000; //
            10'h22F: data <= 8'b00000000; //
            // "3"
            10'h230: data <= 8'b00000000; //
            10'h231: data <= 8'b00000000; //
            10'h232: data <= 8'b00000000; //
            10'h233: data <= 8'b00111100; //  ####
            10'h234: data <= 8'b01111110; // ######
            10'h235: data <= 8'b01100110; // ##  ##
            10'h236: data <= 8'b01100000; //     ##
            10'h237: data <= 8'b00111000; //   ###
            10'h238: data <= 8'b00111000; //   ###
            10'h239: data <= 8'b01100000; //     ##
            10'h23A: data <= 8'b01100110; // ##  ##
            10'h23B: data <= 8'b01111110; // ######
            10'h23C: data <= 8'b00111100; //  ####
            10'h23D: data <= 8'b00000000; //
            10'h23E: data <= 8'b00000000; //
            10'h23F: data <= 8'b00000000; //
            // "4"
            10'h240: data <= 8'b00000000; //
            10'h241: data <= 8'b00000000; //
            10'h242: data <= 8'b00000000; //
            10'h243: data <= 8'b00000110; // ##
            10'h244: data <= 8'b01100110; // ##  ##
            10'h245: data <= 8'b01100110; // ##  ##
            10'h246: data <= 8'b01100110; // ##  ##
            10'h247: data <= 8'b01111110; // ######
            10'h248: data <= 8'b01111110; // ######
            10'h249: data <= 8'b01100000; //     ##
            10'h24A: data <= 8'b01100000; //     ##
            10'h24B: data <= 8'b01100000; //     ##
            10'h24C: data <= 8'b01100000; //     ##
            10'h24D: data <= 8'b00000000; //
            10'h24E: data <= 8'b00000000; //
            10'h24F: data <= 8'b00000000; //
            // "5"
            10'h250: data <= 8'b00000000; //
            10'h251: data <= 8'b00000000; //
            10'h252: data <= 8'b00000000; //
            10'h253: data <= 8'b01111110; // ######
            10'h254: data <= 8'b01111110; // ######
            10'h255: data <= 8'b00000110; // ##
            10'h256: data <= 8'b00000110; // ##
            10'h257: data <= 8'b00111110; // #####
            10'h258: data <= 8'b01111110; // ######
            10'h259: data <= 8'b01100000; //     ##
            10'h25A: data <= 8'b01100110; // ##  ##
            10'h25B: data <= 8'b01111110; // ######
            10'h25C: data <= 8'b00111100; //  ####
            10'h25D: data <= 8'b00000000; //
            10'h25E: data <= 8'b00000000; //
            10'h25F: data <= 8'b00000000; //
            // "6"
            10'h260: data <= 8'b00000000; //
            10'h261: data <= 8'b00000000; //
            10'h262: data <= 8'b00000000; //
            10'h263: data <= 8'b00111100; //  ####
            10'h264: data <= 8'b01111110; // ######
            10'h265: data <= 8'b01100110; // ##  ##
            10'h266: data <= 8'b00000110; // ##
            10'h267: data <= 8'b00111110; // #####
            10'h268: data <= 8'b01111110; // ######
            10'h269: data <= 8'b01100110; // ##  ##
            10'h26A: data <= 8'b01100110; // ##  ##
            10'h26B: data <= 8'b01111110; // ######
            10'h26C: data <= 8'b00111100; //  ####
            10'h26D: data <= 8'b00000000; //
            10'h26E: data <= 8'b00000000; //
            10'h26F: data <= 8'b00000000; //
            // "7"
            10'h270: data <= 8'b00000000; //
            10'h271: data <= 8'b00000000; //
            10'h272: data <= 8'b00000000; //
            10'h273: data <= 8'b01111110; // ######
            10'h274: data <= 8'b01111110; // ######
            10'h275: data <= 8'b01100000; //     ##
            10'h276: data <= 8'b01100000; //     ##
            10'h277: data <= 8'b01110000; //    ###
            10'h278: data <= 8'b00111000; //   ###
            10'h279: data <= 8'b00011000; //   ##
            10'h27A: data <= 8'b00011000; //   ##
            10'h27B: data <= 8'b00011000; //   ##
            10'h27C: data <= 8'b00011000; //   ##
            10'h27D: data <= 8'b00000000; //
            10'h27E: data <= 8'b00000000; //
            10'h27F: data <= 8'b00000000; //
            // "8"
            10'h280: data <= 8'b00000000; //
            10'h281: data <= 8'b00000000; //
            10'h282: data <= 8'b00000000; //
            10'h283: data <= 8'b00111100; //  ####
            10'h284: data <= 8'b01111110; // ######
            10'h285: data <= 8'b01100110; // ##  ##
            10'h286: data <= 8'b01100110; // ##  ##
            10'h287: data <= 8'b01111110; // ######
            10'h288: data <= 8'b01111110; // ######
            10'h289: data <= 8'b01100110; // ##  ##
            10'h28A: data <= 8'b01100110; // ##  ##
            10'h28B: data <= 8'b01111110; // ######
            10'h28C: data <= 8'b00111100; //  ####
            10'h28D: data <= 8'b00000000; //
            10'h28E: data <= 8'b00000000; //
            10'h28F: data <= 8'b00000000; //
            // "9"
            10'h290: data <= 8'b00000000; //
            10'h291: data <= 8'b00000000; //
            10'h292: data <= 8'b00000000; //
            10'h293: data <= 8'b00111100; //  ####
            10'h294: data <= 8'b01111110; // ######
            10'h295: data <= 8'b01100110; // ##  ##
            10'h296: data <= 8'b01100110; // ##  ##
            10'h297: data <= 8'b01111110; // ######
            10'h298: data <= 8'b01111100; //  #####
            10'h299: data <= 8'b01100000; //     ##
            10'h29A: data <= 8'b01100110; // ##  ##
            10'h29B: data <= 8'b01111110; // ######
            10'h29C: data <= 8'b00111100; //  ####
            10'h29D: data <= 8'b00000000; //
            10'h29E: data <= 8'b00000000; //
            10'h29F: data <= 8'b00000000; //
            // "+"
            10'h2A0: data <= 8'b00000000; //
            10'h2A1: data <= 8'b00000000; //
            10'h2A2: data <= 8'b00000000; //
            10'h2A3: data <= 8'b00000000; //
            10'h2A4: data <= 8'b00000000; //
            10'h2A5: data <= 8'b00011000; //   ##
            10'h2A6: data <= 8'b00011000; //   ##
            10'h2A7: data <= 8'b01111110; // ######
            10'h2A8: data <= 8'b01111110; // ######
            10'h2A9: data <= 8'b00011000; //   ##
            10'h2AA: data <= 8'b00011000; //   ##
            10'h2AB: data <= 8'b00000000; //
            10'h2AC: data <= 8'b00000000; //
            10'h2AD: data <= 8'b00000000; //
            10'h2AE: data <= 8'b00000000; //
            10'h2AF: data <= 8'b00000000; //
            // "-"
            10'h2B0: data <= 8'b00000000; //
            10'h2B1: data <= 8'b00000000; //
            10'h2B2: data <= 8'b00000000; //
            10'h2B3: data <= 8'b00000000; //
            10'h2B4: data <= 8'b00000000; //
            10'h2B5: data <= 8'b00000000; //
            10'h2B6: data <= 8'b00000000; //
            10'h2B7: data <= 8'b01111110; // ######
            10'h2B8: data <= 8'b01111110; // ######
            10'h2B9: data <= 8'b00000000; //
            10'h2BA: data <= 8'b00000000; //
            10'h2BB: data <= 8'b00000000; //
            10'h2BC: data <= 8'b00000000; //
            10'h2BD: data <= 8'b00000000; //
            10'h2BE: data <= 8'b00000000; //
            10'h2BF: data <= 8'b00000000; //
            // "/"
            10'h2C0: data <= 8'b00000000; //
            10'h2C1: data <= 8'b00000000; //
            10'h2C2: data <= 8'b00000000; //
            10'h2C3: data <= 8'b01100000; //     ##
            10'h2C4: data <= 8'b01100000; //     ##
            10'h2C5: data <= 8'b00110000; //    ##
            10'h2C6: data <= 8'b00110000; //    ##
            10'h2C7: data <= 8'b00011000; //   ##
            10'h2C8: data <= 8'b00011000; //   ##
            10'h2C9: data <= 8'b00001100; //  ##
            10'h2CA: data <= 8'b00001100; //  ##
            10'h2CB: data <= 8'b00000110; // ##
            10'h2CC: data <= 8'b00000110; // ##
            10'h2CD: data <= 8'b00000000; //
            10'h2CE: data <= 8'b00000000; //
            10'h2CF: data <= 8'b00000000; //
            // "*"
            10'h2D0: data <= 8'b00000000; //
            10'h2D1: data <= 8'b00000000; //
            10'h2D2: data <= 8'b00000000; //
            10'h2D3: data <= 8'b00000000; //
            10'h2D4: data <= 8'b00000000; //
            10'h2D5: data <= 8'b01100110; // ##  ##
            10'h2D6: data <= 8'b01100110; // ##  ##
            10'h2D7: data <= 8'b00011000; //   ##
            10'h2D8: data <= 8'b00011000; //   ##
            10'h2D9: data <= 8'b01100110; // ##  ##
            10'h2DA: data <= 8'b01100110; // ##  ##
            10'h2DB: data <= 8'b00000000; //
            10'h2DC: data <= 8'b00000000; //
            10'h2DD: data <= 8'b00000000; //
            10'h2DE: data <= 8'b00000000; //
            10'h2DF: data <= 8'b00000000; //
            // "="
            10'h2E0: data <= 8'b00000000; //
            10'h2E1: data <= 8'b00000000; //
            10'h2E2: data <= 8'b00000000; //
            10'h2E3: data <= 8'b00000000; //
            10'h2E4: data <= 8'b00000000; //
            10'h2E5: data <= 8'b01111110; // ######
            10'h2E6: data <= 8'b01111110; // ######
            10'h2E7: data <= 8'b00000000; //
            10'h2E8: data <= 8'b00000000; //
            10'h2E9: data <= 8'b01111110; // ######
            10'h2EA: data <= 8'b01111110; // ######
            10'h2EB: data <= 8'b00000000; //
            10'h2EC: data <= 8'b00000000; //
            10'h2ED: data <= 8'b00000000; //
            10'h2EE: data <= 8'b00000000; //
            10'h2EF: data <= 8'b00000000; //
            default: begin
                     data <= 8'b01010101; // # # # #
            end
        endcase
    end
endmodule