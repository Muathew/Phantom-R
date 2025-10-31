/////////////////////////////////////////////////////////////////////
// Design unit: alu control
//            :
// File name  : alu_ctrl.sv
//            :
// Description: alu control for 32-bit RISC-V processor
//            :
// Limitations: this unit only handles R-TYPE and I-OPIMM instructions.
//			  : Other instructions have their dedicated units.
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
//			  : Version 2.0 26/09/25 better readibility
////////////////////////////////////////////////////////////////////

`include "rvconstants.svh"

module alu_ctrl #(
	parameter OP_W = 7,
	parameter FUNCT7_W = 7,
	parameter FUNCT3_W = 3
	)(
    input logic [OP_W-1:0]		opcode,
    input logic [FUNCT3_W-1:0]	funct3, 
    input logic [FUNCT7_W-1:0]	funct7, 
    output alu_op_e				alu_op
	);

always_comb
begin
//Rests to illegal alu instruction => alu_out = 0
alu_op = ALU_ILL;

//concatanation was used to avoid large trees of case statements
    unique case (opcode)
	`R_TYPE: begin
		unique case ({funct7, funct3})
		{`ADD_F7,	`ADD_F3}: alu_op = ALU_ADD;
		{`SUB_F7,	`SUB_F3}: alu_op = ALU_SUB;
		{`XOR_F7,	`XOR_F3}: alu_op = ALU_XOR;
		{`OR_F7,	`OR_F3}: alu_op = ALU_OR;
		{`AND_F7,	`AND_F3}: alu_op = ALU_AND;
		{`SLL_F7,	`SLL_F3}: alu_op = ALU_SLL;
		{`SRL_F7,	`SRL_F7}: alu_op = ALU_SRL;
		{`SRA_F7,	`SRA_F3}: alu_op = ALU_SRA;
		{`SLT_F7,	`SLT_F3}: alu_op = ALU_SLT;
		{`SLTU_F7,	`SLTU_F3}: alu_op = ALU_SLTU;
		{`MUL_F7,	`MUL_F3}: alu_op = ALU_MUL;
		{`MULH_F7,	`MULH_F3}: alu_op = ALU_MULH;
		{`MULHSU_F3,	`MULHSU_F3}: alu_op = ALU_MULHSU;
		{`MULHU_F7,	`MULHU_F3}: alu_op = ALU_MULHU;
		{`DIV_F7,	`DIV_F3}: alu_op = ALU_DIV;
		{`DIVU_F7,	`DIVU_F3}: alu_op = ALU_DIVU;
		{`REM_F7,	`REM_F3}: alu_op = ALU_REM;
		{`REMU_F7,	`REMU_F3}: alu_op = ALU_REMU;
		default: alu_op = ALU_ILL; //Default for non-existent funct fields
		endcase
		end
	`I_OPIMM: begin
		unique case ({funct7, funct3})
		{`DONT_CARE_F7, `ADDI_F3}: alu_op = ALU_ADD;
		{`DONT_CARE_F7, `XORI_F3}: alu_op = ALU_XOR;
		{`DONT_CARE_F7, `ORI_F3}: alu_op = ALU_OR;
		{`DONT_CARE_F7, `ANDI_F3}: alu_op = ALU_AND;
		{`DONT_CARE_F7, `SLLI_F3}: alu_op = ALU_SLL;
		{`SRLI_F7, `SRLI_F3}: alu_op = ALU_SRL;
		{`SRAI_F7, `SRAI_F3}: alu_op = ALU_SRA;
		{`DONT_CARE_F7, `SLTI_F3}: alu_op = ALU_SLT;
		{`DONT_CARE_F7, `SLTIU_F3}: alu_op = ALU_SLTU;
		default: alu_op = ALU_ILL; //Default for non-existent funct fields
		endcase
		end
		default: alu_op = ALU_ILL; //Default for non-existent opcodes
		endcase
end
endmodule
