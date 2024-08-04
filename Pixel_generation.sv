//------------------------------------------------------------------------------
// Title         : Pixel generator
//------------------------------------------------------------------------------
// File          : Pixel_generation.sv
// Author        : David Ramón Alamán
// Created       : 02.08.2024
//------------------------------------------------------------------------------
// Description: Main logic file for the arcade. Takes the current pixel as input
//              and generates the correspondign rgb signal.
//------------------------------------------------------------------------------

module Pixel_generation(
    input logic clk, arst_n, en,
    input logic[1:0] buttons, level_switch,
    input logic[9:0] v_count, h_count,
    output logic[2:0][3:0] rgb
);

/************ SCREEN STATE MACHINE ************/

typedef enum logic[1:0] {START, GAME, OVER} statetype; 
statetype state, next_state;

// State register
always_ff @(posedge clk or negedge arst_n) begin
    if (!arst_n) begin
        state <= START; 
    end
    else if (en) begin
        state <= next_state;
    end
end

// Next state logic
always_comb begin
	case(state)
        START: begin
            if (buttons != 2'b11 && state_trans_en) begin // If any button pressed and transition timer finished
                next_state = GAME;                        // Transition to GAME
            end
			else begin
                next_state = START;
            end
        end
        GAME: begin
            if (balls == 0) begin  // If no balls left
                next_state = OVER; // Transition to OVER
            end
            else begin
                next_state = GAME;   
            end     
        end
        OVER: begin
            if (buttons != 2'b11 && state_trans_en) begin // If any button pressed and transition timer finished
                next_state = START;                       // Transition to START
            end	
            else begin
                next_state = OVER;
            end
        end
		  default: next_state = START;
    endcase
end

// Transition timer

logic state_trans_en;      // Transition timer finished indicator
logic[23:0] state_counter; // Transition timer counter

always_ff @(posedge clk or negedge arst_n) begin
    if (!arst_n) begin
        state_counter <= 24'd0;
    end else if (en) begin
        if (state != next_state) begin // When state transition
            state_counter <= 24'd1;    // Start timer
        end 
        else if (state_counter != 24'd0) begin  // While timer started
            state_counter <= state_counter + 1; // Increment counter
        end 
        else begin 
            state_counter <= 0; // Else remain stop
        end
    end
end

assign state_trans_en = state_counter ? 1'b0 : 1'b1; // If counter = 0 -> Timer finish = 1

/************ MAIN CONFIGURATION AND PARAMETERS ************/
parameter X_DIM = 640; // Screen width in pixels
parameter Y_DIM = 480; // Screen height in pixels

// Color definitions          // bgr (4 bits per color)
parameter WHITE            = 12'hFFF;
parameter BLACK            = 12'h000;
parameter RED              = 12'h00F;
parameter GREEN            = 12'h0F0;
parameter BACKGROUND_COLOR = 12'h333;
parameter BALL_COLOR       = 12'hFFF;
parameter PADDLE_COLOR     = 12'hFFF;
parameter BAR_COLOR        = 12'hFFF;

// Pulse generation at the end of one frame
logic refresh_tick;
assign refresh_tick = (v_count == Y_DIM && h_count == 0) ? 1 : 0;

// Indicates whether the counters are in the visible area [0: NOT VISIBLE, 1: VISIBLE]
logic video_on;
assign video_on = (v_count < Y_DIM && h_count < X_DIM) ? 1 : 0;

/************ LEVEL CONFIGURATION ************/

logic[1:0] level;

// Level register
always_ff @(posedge clk or negedge arst_n) begin
    if (!arst_n) begin
        level <= 0;
    end
    else if (en) begin
        // Store level configuration when transition from START to GAME
        if (next_state == GAME && state == START) begin 
            level <= level_switch; 
        end
    end
end

// Speed configuration for each level
always_comb begin
    case(level) 
        2'b00: begin // Easy
            ball_h_speed = 3'd1; // Horizontal [1 px/frame]
            ball_v_speed = 2'd1; // Vertical   [1 px/frame]
        end
        2'b01: begin // Medium
            ball_h_speed = 3'd3; // Horizontal [3 px/frame]
            ball_v_speed = 2'd2; // Vertical   [2 px/frame]
        end
        2'b10: begin // Hard
            ball_h_speed = 3'd5; // Horizontal [5 px/frame]
            ball_v_speed = 2'd3; // Horizontal [3 px/frame]
        end
        2'b11: begin // Adaptive -> Speed modified according to score
            // 0 <= Score < 15 -> Easy
            if (score < 12'h015) begin
                ball_h_speed = 3'd1; // Horizontal [1 px/frame]
                ball_v_speed = 2'd1; // Vertical   [1 px/frame]
            end 
            // 15 <= Score < 35 -> Easy - Medium
            else if (score < 12'h035) begin
                ball_h_speed = 3'd2; // Horizontal [2 px/frame]
                ball_v_speed = 2'd1; // Vertical   [1 px/frame]
            end
            // 35 <= Score < 60 -> Medium  
            else if (score < 12'h060) begin
                ball_h_speed = 3'd3; // Horizontal [3 px/frame]
                ball_v_speed = 2'd2; // Vertical   [2 px/frame]
            end
            // 60 <= Score < 100 -> Medium - Hard
            else if (score < 12'h0100) begin
                ball_h_speed = 3'd4; // Horizontal [4 px/frame]
                ball_v_speed = 2'd2; // Vertical   [2 px/frame]
            end
            // 100 <= Score -> Hard
            else begin
                ball_h_speed = 3'd5; // Horizontal [5 px/frame]
                ball_v_speed = 2'd3; // Vertical   [3 px/frame]
            end
        end
        default: begin // Default -> Easy
            ball_h_speed = 3'd1; // Horizontal [1 px/frame]
            ball_v_speed = 2'd1; // Vertical   [1 px/frame]
        end
    endcase
end

/************ BALL CONFIGURATION ************/

parameter BALL_DIM = 10;           // Ball diameter

logic next_ball_dir_v, ball_dir_v; // Vertical direction [0: UP, 1: DOWN]
logic next_ball_dir_h, ball_dir_h; // Horizontal direction [0: LEFT, 1: RIGHT]
logic[1:0] ball_v_speed;           // Ball vertical speed [pixels/frame]
logic[2:0] ball_h_speed;           // Ball horizontal speed [pixels/frame]
logic[9:0] next_ball_t, ball_t;    // Ball top position
logic[9:0] next_ball_b, ball_b;    // Ball bottom position
logic[10:0] next_ball_l, ball_l;   // Ball left position
logic[10:0] next_ball_r, ball_r;   // Ball right position

// Ball positions and directions registers
always_ff @(posedge clk or negedge arst_n) begin
    if (!arst_n) begin
        ball_t     <= 0;
        ball_b     <= BALL_DIM;
        ball_l     <= 0;
        ball_r     <= BALL_DIM;
        ball_dir_v <= 0;
        ball_dir_h <= 0;
    end 
    else if (en && refresh_tick)begin
        ball_t     <= next_ball_t;
        ball_b     <= next_ball_b;
        ball_l     <= next_ball_l;
        ball_r     <= next_ball_r;
        ball_dir_v <= next_ball_dir_v;
        ball_dir_h <= next_ball_dir_h;
    end
end

// Ball position calculation
always_comb begin
    
    // ---- VERTICAL DIMENSION ----
    
    // Default values
	next_ball_t = ball_t;
    next_ball_dir_v = ball_dir_v;

    if(state == GAME) begin // Calculate position in GAME state
        // Bounce top border (next ball position in over the bottom of the TOP BAR and is going up)
        if((ball_t < (ball_v_speed + TOP_BAR_POSITION + TOP_BAR_WIDTH)) && !next_ball_dir_v) begin 
            next_ball_t = ball_v_speed + TOP_BAR_POSITION + TOP_BAR_WIDTH - (ball_t - TOP_BAR_POSITION - TOP_BAR_WIDTH); // Next position after bounce
            next_ball_dir_v = 1; // Set direction to 1: DOWN
        end
        // Bounce bottom border (next ball position is >= 480 and is going down) 
        else if ((ball_b > (Y_DIM - ball_v_speed)) && next_ball_dir_v) begin 
            next_ball_t = Y_DIM - 1 - ball_v_speed + Y_DIM - 1 - ball_b - BALL_DIM; // Next position after bounce
            next_ball_dir_v = 0; // Set direction to 0: UP
        end
        // Update position while going DOWN
        else if (ball_dir_v) begin 
            next_ball_t = ball_t + ball_v_speed; 
        end 
        // Update position while going UP
        else if (!ball_dir_v) begin 
            next_ball_t = ball_t - ball_v_speed;
        end
    end
    else begin // In START and OVER states ball position remains centered
        next_ball_t = (Y_DIM - TOP_BAR_POSITION - TOP_BAR_WIDTH) / 2 + TOP_BAR_POSITION + TOP_BAR_WIDTH;
    end

    // Set next ball bottom postion
    next_ball_b = next_ball_t + BALL_DIM; 

    // ---- HORIZONTAL DIMENSION ----
    
    // Default values
    next_ball_l = ball_l;
    next_ball_dir_h = ball_dir_h;
	next_balls = balls;
	increment = 0;

    if(state == GAME) begin // Calculate position in GAME state
        // Ball colides with left border (next ball position will be <= 0 and ball going left)
        if((ball_l < ball_h_speed) && !next_ball_dir_h) begin 
            next_ball_l = 600; // Set ball at X = 600 pixels
            next_ball_dir_h = 0; // Set direction to 0: LEFT
            next_balls = balls - 1; // Subtract 1 ball           
        end 
        // Bounce in the paddle (next ball position is in the right paddle border, in the paddle height and going left)
        else if (((ball_l < ball_h_speed + PADDLE_R_POSITION) && (ball_b > paddle_t) && (ball_t < paddle_b)) && !next_ball_dir_h) begin
            next_ball_l = PADDLE_R_POSITION - ball_l + PADDLE_R_POSITION + ball_h_speed; // Next position after bounce
            next_ball_dir_h = 1; // Set direction to 1: RIGHT
            increment = 1; // Create pulse for the BCD Counter (Score counter)
        end
        // Bounce right border (next ball position is in the right border and ball going right)
        else if ((ball_r > (SIDE_BAR_POSITION - ball_h_speed)) && next_ball_dir_h) begin 
            next_ball_l = SIDE_BAR_POSITION - ball_h_speed + SIDE_BAR_POSITION - ball_r - BALL_DIM; // Next position after bounce
            next_ball_dir_h = 0; // Set direction to 0: LEFT
        end 
        // Update position while going RIGHT
        else if (ball_dir_h) begin  
            next_ball_l = ball_l + ball_h_speed;
        end 
        // Update position while going LEFT
        else if (!ball_dir_h) begin 
            next_ball_l = ball_l - ball_h_speed;
        end
    end
    else begin // In START and OVER states 
        next_ball_l = 600;   // ball position remains at position X = 600
        next_ball_dir_h = 0; // direction is set to 0: LEFT
        next_balls = 3;      // Reset balls
    end

    next_ball_r = next_ball_l + BALL_DIM; // Set next ball right position
end

// Indicates whether the counters are in the ball pixels [0: NOT BALL, 1: BALL PIXELS]
logic ball_on;
assign ball_on = (v_count >= ball_t && v_count < ball_b && h_count >= ball_l && h_count < ball_r);

/************ BAR CONFIGURATION ************/

parameter TOP_BAR_WIDTH    = 5;       // Top bar width
parameter TOP_BAR_POSITION = 10'h020; // Top bar top position

// Indicates whether the counters are in the top bar pixels [0: NOT TOP BAR, 1: TOP BAR PIXELS]
logic top_bar_on;
assign top_bar_on = (v_count >= TOP_BAR_POSITION && v_count < TOP_BAR_POSITION + TOP_BAR_WIDTH);

parameter SIDE_BAR_WIDTH    = 5;      // Side bar width
parameter SIDE_BAR_POSITION = X_DIM - SIDE_BAR_WIDTH - 1; // Side bar left position

// Indicates whether the counters are in the top side pixels [0: NOT SIDE BAR, 1: TOP SIDE PIXELS]
logic side_bar_on;
assign side_bar_on = (h_count >= SIDE_BAR_POSITION && v_count > TOP_BAR_POSITION);

// Indicates whether the counters are in either bar pixels [0: NOT BAR, 1: BAR PIXELS]
logic bar_on;
assign bar_on = top_bar_on | side_bar_on;

/************ PADDLE CONFIGURATION ************/

parameter PADDLE_WIDTH = 5;       // Paddle width
parameter PADDLE_LENGTH = 50;     // Paddle length
parameter PADDLE_L_POSITION = 16; // Paddle left position
parameter PADDLE_R_POSITION = PADDLE_L_POSITION + PADDLE_WIDTH; // Paddle right position
parameter PADDLE_SPEED = 2;       // Paddle movement speed [pixels/frame]
parameter PADDLE_INITIAL_POS = ((Y_DIM - TOP_BAR_POSITION - TOP_BAR_WIDTH) / 2) + TOP_BAR_POSITION + TOP_BAR_WIDTH - (PADDLE_LENGTH / 2);

logic[9:0] next_paddle_t, paddle_t;    // Paddle top position
logic[9:0] next_paddle_b, paddle_b;    // Paddle bottom position

// Paddle positions and directions registers
always_ff @(posedge clk or negedge arst_n) begin
    if (!arst_n) begin
        paddle_t     <= PADDLE_INITIAL_POS;
        paddle_b     <= PADDLE_INITIAL_POS + PADDLE_LENGTH;
    end 
    else if (en && refresh_tick)begin
        paddle_t     <= next_paddle_t;
        paddle_b     <= next_paddle_b;
    end
end

// Paddle moving logic
always_comb begin
    
    // Keep actual position if not buttons pressed
    next_paddle_t = paddle_t;
    next_paddle_b = paddle_b;

    // Paddle going down (buttons[0])
    if(buttons == 2'b10) begin 
        // If next paddle position is on the bottom screen border set position to border
        if(paddle_b > Y_DIM - 1 - PADDLE_SPEED) begin
            next_paddle_t = Y_DIM - 1 - PADDLE_LENGTH;
        end 
        // Else go down normally
        else begin
            next_paddle_t = paddle_t + PADDLE_SPEED;
        end
    end 

    // Paddle going up (buttons[1])
    else if(buttons == 2'b01) begin
        // If next paddle position is on top bar set position to touch top bar
        if(paddle_t < TOP_BAR_POSITION + TOP_BAR_WIDTH + PADDLE_SPEED) begin
            next_paddle_t = TOP_BAR_POSITION + TOP_BAR_WIDTH;
        end 
        // Else go up normally
        else begin
            next_paddle_t = paddle_t - PADDLE_SPEED;
        end 
    end

    // Update paddle bottom
    next_paddle_b = next_paddle_t + PADDLE_LENGTH;
end

// Indicates whether the counters are in the paddle pixels [0: NOT PADDLE, 1: PADDLE PIXELS]
logic paddle_on;
assign paddle_on = (v_count >= paddle_t && v_count < paddle_b && h_count >= PADDLE_L_POSITION && h_count < PADDLE_R_POSITION);

/************ TEXT CONFIGURATION ************/

// Wires connected to the memory
logic[3:0] text_row;  // Row of each character (least significant nibble memory addr) 
logic[5:0] text_char; // Memory direction of the character 
logic[7:0] data;      // Memory output (character row)

// Character memory
text_rom rom(
    .addr({text_char, text_row}),
    .data(data)
);

// SCORE STRING

// Indicates the score string display area [1: IS DISPLAY AREA]
logic score_on;
assign score_on = (v_count < TOP_BAR_POSITION && h_count[9:4] < 6'h11); 

// Indicates the best score string display area [1: IS DISPLAY AREA] 
// It only takes the score digits to display them in green when score record is being beaten
logic best_score_on;
assign best_score_on = (v_count < TOP_BAR_POSITION && h_count[9:4] >= 6'h06 && h_count[9:4] < 6'h09);

logic[3:0] s_row;  // Row of the character
logic[3:0] s_bit;  // Is used as index to select the bit of the memory output
logic[5:0] s_char; // Indicates the character

assign s_row = v_count[4:1]; // Scaled by 2
assign s_bit = h_count[3:1]; // Scaled by 2

// Character string
always_comb begin
    case(h_count[8:4])
        5'h00: s_char = 6'h12; // "S"
        5'h01: s_char = 6'h02; // "C"
        5'h02: s_char = 6'h0E; // "O"
        5'h03: s_char = 6'h11; // "R"
        5'h04: s_char = 6'h04; // "E"
        5'h05: s_char = 6'h1C; // ":"
        5'h06: s_char = {2'h2, score[2]}; // SCORE DIGIT 2
        5'h07: s_char = {2'h2, score[1]}; // SCORE DIGIT 1
        5'h08: s_char = {2'h2, score[0]}; // SCORE DIGIT 0
        5'h09: s_char = 6'h1A; // " "
        5'h0A: s_char = 6'h01; // "B"
        5'h0B: s_char = 6'h00; // "A"
        5'h0C: s_char = 6'h0B; // "L"
        5'h0D: s_char = 6'h0B; // "L"
        5'h0E: s_char = 6'h12; // "S"
        5'h0F: s_char = 6'h1C; // ":"
        5'h10: s_char = {4'h8, balls}; // BALLS VALUE
        default s_char = 6'h3F;
    endcase
end

// PONG STRING

// Indicates the PONG string display area [1: IS DISPLAY AREA]
logic pong_on;
assign pong_on = (v_count < 320 && v_count >= 192 && h_count < 448 && h_count >= 192);

logic[3:0] p_row;  // Row of the character
logic[3:0] p_bit;  // Is used as index to select the bit of the memory output
logic[5:0] p_char; // Indicates the character

assign p_row = v_count[6:3] - 4'b1000; // Scaled by 8
assign p_bit = h_count[5:3];           // Scaled by 8

// Character string
always_comb begin
    case(h_count[7:6] - 2'b11)
        2'h0: p_char = 6'h0F; // "P"
        2'h1: p_char = 6'h0E; // "O"
        2'h2: p_char = 6'h0D; // "N"
        2'h3: p_char = 6'h06; // "G"
        default p_char = 6'h3F;
    endcase
end

// START STRING

// Indicates the start string display area [1: IS DISPLAY AREA]
logic start_on;
assign start_on = (v_count < 400 && v_count >= 384 && h_count < 448 && h_count >= 192);

logic[3:0] start_row;  // Row of the character
logic[3:0] start_bit;  // Is used as index to select the bit of the memory output
logic[5:0] start_char; // Indicates the character

assign start_row = v_count[3:0]; // Scaled by 1
assign start_bit = h_count[2:0]; // Scaled by 1

// Character string
always_comb begin
    case(h_count[7:3] - 5'b11000)
        5'h00: start_char = 6'h1A; // " "
        5'h01: start_char = 6'h1A; // " "
        5'h02: start_char = 6'h1A; // " "
        5'h03: start_char = 6'h1A; // " "
        5'h04: start_char = 6'h1A; // " "
        5'h05: start_char = 6'h0F; // "P"
        5'h06: start_char = 6'h11; // "R"
        5'h07: start_char = 6'h04; // "E"
        5'h08: start_char = 6'h12; // "S"
        5'h09: start_char = 6'h12; // "S"
        5'h0A: start_char = 6'h1A; // " "
        5'h0B: start_char = 6'h00; // "A"
        5'h0C: start_char = 6'h0D; // "N"
        5'h0D: start_char = 6'h18; // "Y"
        5'h0E: start_char = 6'h1A; // " "
        5'h0F: start_char = 6'h0A; // "K"
        5'h10: start_char = 6'h04; // "E"
        5'h11: start_char = 6'h18; // "Y"
        5'h12: start_char = 6'h1A; // " "
        5'h13: start_char = 6'h13; // "T"
        5'h14: start_char = 6'h0E; // "O"
        5'h15: start_char = 6'h1A; // " "
        5'h16: start_char = 6'h12; // "S"
        5'h17: start_char = 6'h13; // "T"
        5'h18: start_char = 6'h00; // "A"
        5'h19: start_char = 6'h11; // "R"
        5'h1A: start_char = 6'h13; // "T"
        5'h1B: start_char = 6'h1A; // " "
        5'h1C: start_char = 6'h1A; // " "
        5'h1D: start_char = 6'h1A; // " "
        5'h1E: start_char = 6'h1A; // " "
        5'h1F: start_char = 6'h1A; // " "
        default start_char = 6'h3F;
    endcase
end

// GAME OVER STRING

// Indicates the GAME OVER string display area [1: IS DISPLAY AREA]
logic go_on;
assign go_on = (v_count < 192 && v_count >= 128 && h_count < 464 && h_count >= 176);

logic[3:0] go_row;  // Row of the character
logic[3:0] go_bit;  // Is used as index to select the bit of the memory output
logic[5:0] go_char; // Indicates the character

assign go_row = v_count[5:2];           // Scaled by 4
assign go_bit = h_count[5:2] - 4'b1100; // Scaled by 4

// Character string
always_comb begin
    case((h_count[8:4] - 5'b01011) >> 1)
        4'h0: go_char = 6'h06; // "G"
        4'h1: go_char = 6'h00; // "A"
        4'h2: go_char = 6'h0C; // "M"
        4'h3: go_char = 6'h04; // "E"
        4'h4: go_char = 6'h1A; // " "
        4'h5: go_char = 6'h0E; // "O"
        4'h6: go_char = 6'h15; // "V"
        4'h7: go_char = 6'h04; // "E"
        4'h8: go_char = 6'h11; // "R"
        default go_char = 6'h3F;
    endcase
end

// FINAL SCORE STRING

// Indicates the final score string display area [1: IS DISPLAY AREA]
logic final_on;
assign final_on = (v_count < 384 && v_count >= 320 && h_count < 464 && h_count >= 176);

logic[3:0] final_row;  // Row of the character
logic[3:0] final_bit;  // Is used as index to select the bit of the memory output
logic[5:0] final_char; // Indicates the character

assign final_row = v_count[5:2];           // Scaled by 4
assign final_bit = h_count[5:2] - 4'b1100; // Scaled by 4

// Character string
always_comb begin
    case((h_count[8:4] - 5'b01011) >> 1)
        4'h0: final_char = 6'h12; // "S"
        4'h1: final_char = 6'h02; // "C"
        4'h2: final_char = 6'h0E; // "O"
        4'h3: final_char = 6'h11; // "R"
        4'h4: final_char = 6'h04; // "E"
        4'h5: final_char = 6'h1C; // ":"
        4'h6: final_char = {2'h2, score[2]}; // SCORE DIGIT 2
        4'h7: final_char = {2'h2, score[1]}; // SCORE DIGIT 1
        4'h8: final_char = {2'h2, score[0]}; // SCORE DIGIT 0
        default final_char = 6'h3F;
    endcase
end

// LEVEL STRING

// Indicates the level select string display area [1: IS DISPLAY AREA]
logic level_on;
assign level_on = (v_count < 384 && v_count >= 352 && h_count < 384 && h_count >= 256);

logic[3:0] level_row;  // Row of the character
logic[3:0] level_bit;  // Is used as index to select the bit of the memory output
logic[5:0] level_char; // Indicates the character

assign level_row = v_count[4:1]; // Scaled by 2
assign level_bit = h_count[4:1]; // Scaled by 2

// Character string
always_comb begin
    case({level_switch, h_count[6:4]})
        5'h00: level_char = 6'h1A; // " "
        5'h01: level_char = 6'h1A; // " "
        5'h02: level_char = 6'h04; // "E"
        5'h03: level_char = 6'h00; // "A"
        5'h04: level_char = 6'h12; // "S"
        5'h05: level_char = 6'h18; // "Y"
        5'h06: level_char = 6'h1A; // " "
        5'h07: level_char = 6'h1A; // " "
        5'h08: level_char = 6'h1A; // " "
        5'h09: level_char = 6'h0C; // "M"
        5'h0A: level_char = 6'h04; // "E"
        5'h0B: level_char = 6'h03; // "D"
        5'h0C: level_char = 6'h08; // "I"
        5'h0D: level_char = 6'h14; // "U"
        5'h0E: level_char = 6'h0C; // "M"
        5'h0F: level_char = 6'h1A; // " "
        5'h10: level_char = 6'h1A; // " "
        5'h11: level_char = 6'h1A; // " "
        5'h12: level_char = 6'h07; // "H"
        5'h13: level_char = 6'h00; // "A"
        5'h14: level_char = 6'h11; // "R"
        5'h15: level_char = 6'h03; // "D"
        5'h16: level_char = 6'h1A; // " "
        5'h17: level_char = 6'h1A; // " "
        5'h18: level_char = 6'h00; // "A"
        5'h19: level_char = 6'h03; // "D"
        5'h1A: level_char = 6'h00; // "A"
        5'h1B: level_char = 6'h0F; // "P"
        5'h1C: level_char = 6'h13; // "T"
        5'h1D: level_char = 6'h08; // "I"
        5'h1E: level_char = 6'h15; // "V"
        5'h1F: level_char = 6'h04; // "E"
        default level_char = 6'h3F;
    endcase
end

/************ SCOREBOARD ************/

parameter SCORE_DIGITS = 3; // Number of digits for the score

logic[SCORE_DIGITS - 1:0][3:0] score, best_score; // Score
logic[1:0] balls, next_balls;                     // Balls

// Balls register
always_ff @(posedge clk or negedge arst_n) begin
    if (!arst_n) begin
        balls <= 3;
    end
    else if (en && refresh_tick) begin
        balls <= next_balls;
    end
end

// Reset score pulse (generated when OVER state is left)
logic score_rst;
assign score_rst = (next_state != OVER && state == OVER) ? 1'b1 : 1'b0;

// Score counter instantiation
BCD_Counter #(.BCD_DIGITS(SCORE_DIGITS)) counter
(
    .clk(clk), 
    .arst_n(arst_n), 
    .en(en),
    .rst(score_rst), 
    .increment(increment && refresh_tick),
    .bcd(score)
);

// Best score register
always_ff @(posedge clk or negedge arst_n) begin
    if (!arst_n) begin
        best_score <= 0;
    end
    else if (en) begin
        if (score > best_score) begin
            best_score <= score;
        end
    end
end

// Best score signal (set when the best score is equal to the actual score)
logic best_score_s;
assign best_score_s = (score == best_score && score != 0) ? 1'b1 : 1'b0;

/************ RGB GENERATION ************/

always_comb begin

    // Default values
    text_char = 6'h3;
    text_row  = 4'h0;
    rgb = BACKGROUND_COLOR;
    
    // If out of visible zone
    if (!video_on) begin       
        rgb = 12'h000; // RGB = BLACK
    end
    // Ball display (show when ball pixels and GAME state)
    else if (ball_on && (state == GAME)) begin    
        rgb = BALL_COLOR;      
    end
    // Display bars only on GAME state
    else if (bar_on && (state == GAME)) begin
        rgb = BAR_COLOR;
    end
    // Display paddle only in GAME state
    else if (paddle_on && (state == GAME)) begin
        rgb = PADDLE_COLOR;
    end
    // Display score in top left corner in GAME state
    else if (score_on && (state == GAME))begin
        text_char = s_char;
        text_row  = s_row;
        if (data[s_bit]) begin
            // If the best score is being beated show score value in GREEN
            if (best_score_on && best_score_s) begin
                rgb = GREEN;
            end
            else begin
                rgb = WHITE;
            end
        end
    end
    // Display PONG in START and OVER states
    else if (pong_on && ((state == START) || (state  == OVER)))begin
        text_char = p_char;
        text_row  = p_row;
        if (data[p_bit]) begin
            rgb = WHITE;
        end
    end
    // Display start string in START and OVER states
    else if (start_on && ((state == START) || (state  == OVER)))begin
        text_char = start_char;
        text_row  = start_row;
        if (data[start_bit]) begin
            rgb = WHITE;
        end
    end
    // Display GAME OVER in OVER state
    else if (go_on && (state == OVER))begin
        text_char = go_char;
        text_row  = go_row;
        if (data[go_bit]) begin
            rgb = RED;
        end
    end
    // Display score in GAME OVER SCREEN (OVER state)
    else if (final_on && (state == OVER))begin
        text_char = final_char;
        text_row  = final_row;
        if (data[final_bit]) begin
            // Show in GREEN when record beaten
            if (best_score_s) begin
                rgb = GREEN;
            end
            else begin
                rgb = WHITE;
            end
        end
    end
    // Display level selection string in START state
    else if (level_on && (state == START))begin
        text_char = level_char;
        text_row  = level_row;
        if (data[level_bit]) begin
            rgb = WHITE;
        end
    end
    // Else display background (dark grey)
	else begin
		rgb = BACKGROUND_COLOR;
	end
end
    
endmodule