/////////////////////////////////////////////////////////////////////
// Design unit: program counter
//            :
// File name  : pc.sv
//            :
// Description: program counter for 32-bit RISC-V processor
//            :
// Limitations: None
//            :
// System     : SystemVerilog IEEE 1800-2005
//            :
// Author     : Muath Washili
//            : School of Electronics and Computer Science
//            : University of Southampton
//            : Southampton SO17 1BJ, UK
//            : mw14n23@soton.ac.uk
//
// Revision   : Version 1.0 17/06/25
////////////////////////////////////////////////////////////////////

module pc #(parameter WORD_W = 32)(
    input logic clk, n_reset, load_PC
    input logic [WORD_W-1:0] PC_in
    output logic [WORD_W-1:0] Iaddress
);
s
always_ff @(posedge clk, negedge n_reset)
    begin
    if (!n_reset)
        Iaddress <= 0;
    else
        if (load_PC)
            Iaddress <= PC_in;
            else
            Iaddress <= PC_in + 4;
    end
endmodule