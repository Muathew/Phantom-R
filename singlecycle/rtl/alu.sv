/////////////////////////////////////////////////////////////////////
// Design unit: alu 
//            :
// File name  : alu.sv
//            :
// Description: alu control for 32-bit RISC-V processor 
//            :
// Limitations: dumb mul/div 
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
		input logic	[XLEN-1:0] oprnd_a, oprnd_b,
		input alu_op_e			alu_op,
		output logic [XLEN-1:0]	alu_out,
		output logic			zero_flag);

`include "rvconstants.svh"

assign zero_flag = (alu_out == `ZERO);

always_comb

logic signed [(2*XLEN-1):0] mul_res;

unique case (alu_op)
	`ALU_ADD:	alu_out = oprnd_a + oprnd_b;
	`ALU_SUB:	alu_out = oprnd_a - oprnd_b;
	`ALU_SLL:	alu_out = oprnd_a << oprnd_b [4:0];
	`ALU_SRL:	alu_out = oprnd_a >> oprnd_b [4:0];	
	`ALU_SRA:	alu_out = oprnd_a >>> oprnd_b [4:0];
	`ALU_SLT:	alu_out = (oprnd_a < oprnd_b) ? 31'd1 : 31'd0;
	`ALU_SLTU:	alu_out = ($unsigned(oprnd_a) < $unsigned (oprnd_b)) ? 31'd1 : 31'd0;
	`ALU_XOR:	alu_out = oprnd_a ^ oprnd_b;
	`ALU_AND:	alu_out = oprnd_a & oprnd_b;
	`ALU_OR:	alu_out = oprnd_a | oprnd_b;
	//M-Extension
	`ALU_MUL:	begin
				mul_res = oprnd_a * oprnd_b;
				alu_out = mul_res [XLEN-1:0];
				end
	`ALU_MULH:	begin
				mul_res = oprnd_a * oprnd_b;
				alu_out = mul_res [(2*XLEN-1):XLEN];
				end
	`ALU_MULHSU:begin
				mul_res = oprnd_a * $unsigned(oprnd_b);
				alu_out = mul_res [(2*XLEN-1):XLEN];
				end
	`ALU_MULHU:	begin
				mul_res = $unsigned(oprnd_a) * $unsigned(oprnd_b);
				alu_out = mul_res [(2*XLEN-1):XLEN]; 
				end
	`ALU_DIV:	begin
				if (oprnd_b == `ZERO)	
					alu_out = -32'd1;	//Division by 0 condition
				else if	(oprnd_a == -32'h80000000 && oprnd_b == -32'd1)
					alu_out = -32'h80000000; //overflow condition
				else alu_out = oprnd_a / oprnd_b;
				end
	`ALU_DIVU:	begin
				if (oprnd_b == `ZERO)
					alu_out = 32'hFFFFFFFF;
				else
					alu_out = $unsigned(oprnd_a) / $unsigned(oprnd_b);
				end
	`ALU_REM:	begin
				if (oprnd_b == `ZERO)
					alu_out = oprnd_a;
				else if (oprnd_a == -32'h80000000 && oprnd_b == -32'd1)
					alu_out = `ZERO; //overflow condition
				else alu_out = oprnd_a % oprnd_b;
				end
	`ALU_REMU:	begin
				if (oprnd_b == `ZERO)
					alu_out = oprnd_a;
				else alu_out = oprnd_a % oprnd_b;
				end
	//Non-existent instructions prevention
	`ALU_ILL:	alu_out = `ZERO;
				zero_flag = `ON;
				default: alu_out = `ZERO, zero_flag = `ON;
endcase
endmodule