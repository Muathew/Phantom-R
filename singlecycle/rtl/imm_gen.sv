/////////////////////////////////////////////////////////////////////
// Design unit: immediate generator
//            :
// File name  : imm_gen.sv
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
//              Version 2.0 12/11/25 Changed the control signals to imm_type
/////////////////////////////////////////////////////////////////////

module imm_gen #(
        parameter XLEN = 32,
        parameter IMM_W = 3
        )(
        input  logic [IMM_W-1:0] imm_type,
        input  logic [XLEN-1:0] instr,
        output logic [XLEN-1:0] imm);

`include "rvconstants.svh"

always_comb
begin
unique case (imm_type)
        `IMM_X: imm = `ZERO;
        `IMM_I:
                imm = {{20{instr[31]}}, instr[31:20]};
        `IMM_S:
                imm = {{20{instr[31]}}, instr[30:25], instr[11:7]};
        `IMM_B:
                imm = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
        `IMM_U:
                imm = {instr[31:12], 12'b0};
        `IMM_J:
                imm = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};
        default: imm = `ZERO;
endcase
end
endmodule