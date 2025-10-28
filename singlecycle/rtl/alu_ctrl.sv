/////////////////////////////////////////////////////////////////////
// Design unit: alu control
//            :
// File name  : alu_ctrl.sv
//            :
// Description: alu control for 32-bit RISC-V processor
//            :
// Limitations: this unit only handles R-TYPE and I-TYPE0 instructions.
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
////////////////////////////////////////////////////////////////////

`include "rvconstants.svh"

module alu_ctrl #(
	parameter OP_W = 7,
	parameter FUNCT7_W = 7,
	parameter FUNCT3_W = 3
	)(
    input logic [OP_W-1:0] opcode,
    input logic [FUNCT3_W-1:0] funct3, 
    input logic [FUNCT7_W-1:0] funct7, 
    output alu_op_e	alu_op
	);

always_comb
begin
//resets ctrl signal to 0
alu_op = ALU_ADD;

    unique case (opcode)
	`R_TYPE: begin
	unique case (funct3)
	//handling of ADD, SUB, and MUL
	`ADD_SUB_MUL_F3:	begin
	unique case (funct7)
	`ADD_F7: begin
			alu_op = ALU_ADD;
			end
	`SUB_F7: begin
			alu_op = ALU_SUB;
			end
	`MUL_F7: begin
			alu_op = ALU_MUL;
			end
	default: alu_op = ALU_ADD;
		endcase
			end
	//handling of XOR & DIV
	`XOR_DIV_F3:	begin
	unique case (funct7)
	`XOR_F7: begin
			alu_op = ALU_XOR;
			end
	`DIV_F7: begin
			alu_op = ALU_DIV;
			end
	default: alu_op = ALU_ADD;
		endcase
			end
	//handling of AND & REMU
	`AND_REMU_F3:	begin
	unique case (funct7)
	`AND_F7:	begin
			alu_op = ALU_AND;
			end
	`REMU_F7:	begin
			alu_op = ALU_REMU;
			end
	default: alu_op = ALU_ADD;
		endcase
			end
	//handling of OR & REM		
	`OR_REM_F3:		begin
	unique case (funct7)
	`OR_F7:		begin
			alu_op = ALU_OR;
			end
	`REM_F7:	begin
			alu_op = ALU_REM;
			end
	default: alu_op = ALU_ADD;
		endcase
			end
	//handling of SLL and MULH
	`SLL_MULH_F3:	begin
	unique case (funct7)
	`SLL_F7:	begin
			alu_op = ALU_SLL;
			end
	`MULH_F7:	begin
			alu_op = ALU_MULH;
			end
	default: alu_op = ALU_ADD;
		endcase
			end
	//handling of SRL, SRA and DIVU
	`SRL_SRA_DIVU_F3:	begin
	unique case (funct7)
	`SRL_F7:	begin
			alu_op = ALU_SRL;
			end
	`SRA_F7:	begin
			alu_op = ALU_SRA;
			end
	`DIVU_F7:	begin
			alu_op = ALU_DIVU;
			end
	default: alu_op = ALU_ADD;
		endcase
			end
	//handling of SLT and MULSU
	`SLT_MULSU_F3:	begin
	unique case (funct7)
	`SLT_F7:	begin
			alu_op = ALU_SLT;
			end
	`MULSU_F7:	begin
			alu_op = ALU_MULSU;
			end
	default: alu_op = ALU_ADD;
		endcase
			end
	//handling of SLTU and MULU
	`SLTU_MULU_F3:	begin
	unique case (funct7)
	`SLTU_F7:	begin
			alu_op = ALU_SLTU;
			end
	`MULU_F7:	begin
			alu_op = ALU_MULU;
			end
	default: alu_op = ALU_ADD;	
		endcase
			end
	endcase
	`I_TYPE0: begin
	unique case (funct3)
	`ADDI_F3:	begin
			alu_op = ALU_ADD;
			end
	`XORI_F3:	begin
			alu_op = ALU_XOR;
			end
	`ORI_F3:	begin
			alu_op = ALU_OR;
			end
	`ANDI_F3:	begin
			alu_op = ALU_AND;
			end
	/////blank for slli, srli, and srai
	`SLLI_F3:	begin
			alu_op = ALU_SLL;
			end
	`SRLI_SRAI_F3:	begin
	unique case (funct7)
	`SRLI_F7: begin
			alu_op = ALU_SRL;
			end
	`SRAI_F7:	begin
			alu_op = ALU_SRA;
			end
	default: alu_op = ALU_ADD;		
		endcase
			end
	`SLTI_F3: begin
			alu_op = ALU_SLT;
			end
	`SLTIU_F3: begin
			alu_op = ALU_SLTU;
			end
	default: alu_op = ALU_ADD;
		endcase
			end
	default: alu_op = ALU_ADD;
			end
    endcase
end
endmodule
