//------------------------------------------------------------------------------
// Title         : BCD Counter
//------------------------------------------------------------------------------
// File          : BCD_Counter.sv
// Author        : David Ramón Alamán
// Created       : 02.08.2024
//------------------------------------------------------------------------------
// Description: Parametrized BCD counter. The counter adds 1 to the value every
//              clock cycle when the "increment" signal is asserted. And returns
//              to zero when the "rst" signal is asserted.
//------------------------------------------------------------------------------

module BCD_Counter #(parameter BCD_DIGITS)
(
    input logic clk, arst_n, en,
    input logic rst, increment,
    output logic [BCD_DIGITS-1:0][3:0] bcd
);

logic [BCD_DIGITS-1:0][3:0] next_bcd;

always_comb begin
    next_bcd = bcd;
    
    // If increment is high add 1 to the previous value
    if (increment) begin
        next_bcd[0] = bcd[0] + 1;
        // For all digits except [0] check if the previous
        // digit is ten and then set that digit to zero 
        // and add 1 to the current digit.
        for (int i = 1; i < BCD_DIGITS; i++) begin
            if (next_bcd[i - 1] == 10) begin
                next_bcd[i - 1] = 0;
                next_bcd[i]     = bcd[i] + 1;
            end
        end
    end
end

always_ff @(posedge clk or negedge arst_n) begin
    if (!arst_n) begin
        bcd <= 0;
    end
    else if (en) begin
        if(rst) begin
            bcd <= 0;
        end
        else if(increment) begin
            bcd <= next_bcd;
        end
    end
end

endmodule