/////////////////////////////////////////////////////////////////////
// Design unit: ctrl_unit 
//            :
// File name  : ctrl_unit.sv
//            :
// Description: control unit for 32-bit RISC-V processor 
//            :
// Limitations:  
//            :
// System     : SystemVerilog IEEE 1800-2005
//            :
// Author     : Muath Washili
//            : School of Electronics and Computer Science
//            : University of Southampton
//            : Southampton SO17 1BJ, UK
//            : mw14n23@soton.ac.uk
//
// Revision   : Version 1.0 04/11/25
////////////////////////////////////////////////////////////////////

module ctrl_unit #(
    parameter OP_W = 7,
    parameter IMM_W = 3
    )(
    input logic [OP_W-1:0]  opcode,
    output logic alu_src,
    output logic branch,
    output logic jump,
    output logic mem_read,
    output logic mem_write,
    output logic reg_write,
    output logic mem_to_reg,
    output logic [IMM_W-1:0] imm_type);

`include "rvconstants.svh"

always_comb begin
    //default values
    alu_src     = 0;
    mem_to_reg  = 0;
    reg_write   = 0;
    mem_read    = 0;
    branch      = 0;
    jump        = 0;
    imm_type    = `IMM_X;

    unique case (opcode)
        `R_TYPE: begin
            alu_src    = 0;
            reg_write  = 1;
            imm_type = `IMM_X;
        end
        `I_OPIMM: begin
            alu_src     = 1;
            reg_write   = 1;
            imm_type    = `IMM_I;
        end
        `I_LOAD: begin
            alu_src     = 1;
            mem_to_reg  = 1;
            reg_write   = 1;
            mem_read    = 1;
            imm_type    = `IMM_I;
        end
        `S_TYPE: begin
            alu_src     = 1;
            mem_write   = 1;
            imm_type    = `IMM_S;
        end
        `B_TYPE: begin
            branch      = 1;
            imm_type    = `IMM_B;
        end
        `U_LUI, `U_AUIPC: begin
            alu_src     = 1;
            reg_write   = 1;
            imm_type    = `IMM_U;
        end
        `J_JAL: begin
            jump        = 1;
            reg_write   = 1;
            imm_type    = `IMM_J;
        end
        `I_JALR: begin
            jump        = 1;
            reg_write   = 1;
            imm_type    = `IMM_I;
        end
        default: imm_type = `IMM_X;
    endcase
end
endmodule