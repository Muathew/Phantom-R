/////////////////////////////////////////////////////////////////////
// Design unit: decoder
//            :
// File name  : decoder.sv
//            :
// Description: Decoder for RV32IM RISC-V processor
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
// Revision   : Version 1.0 25/09/25 
/////////////////////////////////////////////////////////////////////

module decoder #(parameter XLEN = 32, OP_W = 7, FUNCT7_W = 7, FUNCT3_W = 3, ADDR_W = 5)(input logic [XLEN-1:0] instr,
        output logic [OP_FUNCT7W-1:0] opcode,
        output logic [FUNCT3_W-1:0] funct3,
        output logic [FUNCT7_W-1:0] funct7,
        output logic [ADDR_W-1:0] rs1,
        output logic [ADDR_W-1:0] rs2,
        output logic [ADDR_W-1:0] rd,
        output logic [XLEN-1:0] imm);

`include rvconstants.svh

assign opcode = instr[6:0];
assign rd = instr[11:7];
assign funct3 = instr[14:12];
assign rs1 = instr[19:15];
assign rs2 = instr[24:20];
assign funct7 = instr[31:25];

always_comb
begin
case (opcode)
        `I_type0: imm = {{20{instr[31]}}, instr[31:20]};
        `R_type: imm = 0;
        //S-type, B-type, J-type formats to be added here.
        default: imm = 0;
endcase
end
endmodule