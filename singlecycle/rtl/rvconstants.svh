/////////////////////////////////////////////////////////////////////
// Design unit: opcode
//            :
// File name  : opcode.svh
//            :
// Description: constants for RISC-V RV32IM ISA and ALU operations.
//            :
// Limitations: determined by the number of bits and the needed operations - main limitaion is the available bits for  the op_w and the designer's choice.
//            :
// System     : SystemVerilog IEEE 1800-2005
//            :
// Author     : Muath Washili
//            : School of Electronics and Computer Science
//            : University of Southampton
//            : Southampton SO17 1BJ, UK
//            : mw14n23@soton.ac.uk
//
// Revision   : Version 1.0 17/06/25 initial size of operations could be 5-bits?  OP codes NO = 19, left = 13. The increments section might need improvement
/////////////////////////////////////////////////////////////////////

//instruction TYPE op-code
`define R_TYPE  7'h33
`define I_TYPE0  7'h13
`define I_TYPE1 7'h03
`define I_TYPE2 7'h67
`define I_TYPE3 7'h73
`define S_TYPE 7'h23
`define B_TYPE 7'h63
//could be extended in the future to fit the rest?
//	Room for additional operations

//funct3 field
//R-TYPE, the instructions are grouped together to avoid space wastage
`define ADD_SUB_MUL_F3 3'h0
`define XOR_DIV_F3 3'h4
`define OR_REM_F3 3'h6
`define AND_REMU_F3 3'h7
`define SLL_MULH_F3 3'h1
`define SRL_SRA_DIVU_F3 3'h5
`define SLT_MULSU_F3 3'h2
`define SLTU_MULU_F3 3'h3

//I-TYPE, some instructions are grouped together to avoid space wastage
`define ADDI_F3 `ADD_SUB_MUL_F3
`define XORI_F3 `XOR_DIV_F3
`define ORI_F3 `OR_REM_F3
`define ANDI_F3 `AND_REMU_F3
`define SLLI_F3 `SLL_MULH_F3
`define SRLI_SRAI_F3 `SRL_SRA_DIVU_F3
`define SLTI_F3 `SLT_MULSU_F3
`define SLTIU_F3 `SLTU_MULU_F3
`define LB_F3 3'h0
`define LH_F3 3'h1
`define LW_F3 3'h2
`define LBU_F3 3'h4
`define LHU_F3 3'h5

//I-TYPE jump and link reg
`define JALR_F3 3'h0

//I-TYPE environment
`define ECALL_F3 3'h0
`define EBREAK_F3 3'h0 //requires fine tuning to accomodate risc-v specifications in funct7 fields

//S-TYPE
`define SB_F3 3'h0
`define SH_F3 3'h1
`define SW_F3 3'h2

//B-TYPE
`define BEQ_F3 3'h0
`define BNE_F3 3'h1
`define BLT_F3 3'h4
`define BGE_F3 3'h5
`define BLTU_F3 3'h6
`define BGEU_F3 3'h7

//J-TYPE
`define JAL_F3 3'h0

//U-TYPE COMEBACK HERE
`define LUI_OP //COME
`define AUIPC_OP //BACK

//funct7 for R-TYPE instr
`define ADD_F7 7'h00
`define SUB_F7 7'h20
`define XOR_F7 7'h00
`define OR_F7 7'h00
`define AND_F7 7'h00
`define SLL_F7 7'h00
`define SRL_F7 7'h00
`define SRA_F7 7'h20
`define SLT_F7 7'h00
`define SLTU_F7 7'h00
`define MUL_F7 7'h01
`define MULH_F7 7'h01
`define MULSU_F7 7'h01
`define MULU_F7 7'h01
`define DIV_F7 7'h01
`define DIVU_F7 7'h01
`define REM_F7 7'h01
`define REMU_F7 7'h01

//funct7 for I-TYPE instr
`define SRLI_F7 7'h00
`define SRAI_F7 7'h20

//ALU_OP
typedef enum logic [4:0] {
  ALU_ADD,
  ALU_SUB,
  ALU_SLL,
  ALU_SRL,
  ALU_SRA,
  ALU_SLT,
  ALU_SLTU,
  ALU_XOR,
  ALU_OR,
  ALU_AND,
  ALU_MUL,
  ALU_MULH,
  ALU_MULSU,
  ALU_MULU,
  ALU_DIV,
  ALU_DIVU,
  ALU_REM,     
  ALU_REMU   
} alu_op_e;