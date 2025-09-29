/////////////////////////////////////////////////////////////////////
// Design unit: resgister
//            :
// File name  : register.sv
//            :
// Description: Output register for 16-bit? processor
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
/////////////////////////////////////////////////////////////////////

module register #(parameter WORD_W = 16, OP_W = 5)
				(output logic [WORD_W-1:0] digits,
				input logic [WORD_W-1:0] Wdata,
				input logic WE, clk)
				
always_ff @(posedge clk)
	begin
	if (WE)
		digits <= Wdata;
	end
endmodule