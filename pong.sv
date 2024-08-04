//------------------------------------------------------------------------------
// Title         : PONG
//------------------------------------------------------------------------------
// File          : pong.sv
// Author        : David Ramón Alamán
// Created       : 02.08.2024
//------------------------------------------------------------------------------
// Description: Single-player Pong-like arcade game. The game supports four 
//              difficulty levels: Easy (1 px/frame vertical and horizontal),
//              Medium (3 px/frame horizontal and 2 px/frame vertical),
//              Hard (5 px/frame horizontal and 3 px/frame vertical), and 
//              an Adaptive level that starts at Easy and progresses to Hard 
//              with three intermediate steps. The difficulty is set via two 
//              switches.
//
//              Each game consists of three balls (lives), and the highest score 
//              is recorded.
//
//              The game is designed to be used with a VGA screen 
//              (640x480 @ 60 Hz).
//
//              The project has been developed employing the Terasic DE10-Lite 
//              Dev-Board that provides a 50 MHz clock signal to the FPGA. 
//              (FPGA: Intel MAX10 10M50DAF484C7G)
//------------------------------------------------------------------------------

module pong(
    input logic clk_50MHz, arst_n, en,
	input logic[1:0] buttons, level_switch,
    output logic hsync, vsync,
    output logic[3:0] red, green, blue
);

logic clk_25MHz, next_hsync, next_vsync;
logic[2:0][3:0] rgb;
logic[9:0] v_count, h_count, next_v_count, next_h_count;

VGA vga(
    .clk_50MHz(clk_50MHz), 
    .arst_n(arst_n), 
    .en(en),
    .hsync(next_hsync), 
    .vsync(next_vsync), 
    .clk_25MHz(clk_25MHz),
    .v_count(next_v_count), 
    .h_count(next_h_count)
);

Pixel_generation pg(
    .clk(clk_50MHz), 
    .arst_n(arst_n), 
    .en(en),
	.buttons(buttons),
    .level_switch(level_switch),
    .v_count(v_count), 
    .h_count(h_count),
    .rgb(rgb)
);

// Sync signals to the 25 MHz clock

always_ff @(posedge clk_50MHz) begin
    if (clk_25MHz) begin 
        v_count <= next_v_count;
        h_count <= next_h_count;
        hsync   <= next_hsync;
        vsync   <= next_vsync;
        red     <= rgb[0];
        green   <= rgb[1];
        blue    <= rgb[2];
    end
end

endmodule