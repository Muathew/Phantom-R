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
/////////////////////////////////////////////////////////////////////

module imm_gen #(parameter XLEN = 32, OP_W = 7)(
    input logic [XLEN-1:0] instr,
    output logic [XLEN-1:0] imm
)

logic [OP_W-1:0] opcode;

assign opcode = instr[6:0];

always_comb
begin
case (opcode)
        `R_TYPE: imm = 0;
        `I_OPIMM, `I_LOAD, `I_JALR, `I_SYSTEM:
                imm = {{20{instr[31]}}, instr[31:20]};
        `S_TYPE:
                imm = {{20{instr[31]}}, instr[30:25], instr[11:7]};
        `B_TYPE:
                imm = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
        `U_LUI, `U_AUIPC:
                imm = {instr[31:12], 12'b0};
        `J_JAL:
                imm = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};
        default: imm = 0;
endcase
end
endmodule