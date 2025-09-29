/////////////////////////////////////////////////////////////////////
// Design unit: alu 
//            :
// File name  : alu.sv
//            :
// Description: alu control for 32-bit RISC-V processor
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

module alu #(parameter XLEN = 32, CTRLSIGW_W = 4;)(
		input logic	[XLEN-1:0] oprnd_a, [XLEN-1:0] oprnd_b,
		input alu_op_e	alu_op,
		output logic [XLEN-1:0] alu_out,
		output logic zero_flag);

`include rvconstants.sv
always_comb
begin

unique case (alu_op)
	`ALU_ADD:	begin
				alu_out = oprnd_a + oprnd_b;
				end
	`ALU_SUB:	begin
				alu_out = oprnd_a - oprnd_b;
				end
	`ALU_XOR:	begin
				alu_out = oprnd_a ^ oprnd_b;
				end
	`ALU_AND:	begin
				alu_out = oprnd_a & oprnd_b;
				end
	`ALU_OR:	begin
				alu_out = oprnd_a | oprnd_b;
				end
	`ALU_SLL:	begin
				alu_out = oprnd_a << oprnd_b;
				end
	`ALU_SRL:	begin
				alu_out = oprnd_a >> oprnd_b;
				end			
	`ALU_MUL:	begin
				alu_out = oprnd_a * oprnd_b;
				end
	`ALU_DIV:	begin
				alu_out = oprnd_a / oprnd_b;
				end
				default: alu_out = oprnd_a + oprnd_b; /*for a better readability, remove the bit representation via headers like alu_ctrl.sv.
				moreover, divison needs more the 1 LoC*/
	endcase
end
endmodule