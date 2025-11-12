/////////////////////////////////////////////////////////////////////
// Design unit: program counter
//            :
// File name  : pc_unit.sv
//            :
// Description: program counter for 32-bit RISC-V processor
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
//              Version 2.0 12/11/25 restructre for top level integration
////////////////////////////////////////////////////////////////////

module pc_unit #(parameter XLEN = 32)(
    input  logic clk,
    input  logic n_reset,
    input  logic branch,
    input  logic jump,
    input  logic branch_taken, //from ALU or comparator
    input  logic [XLEN-1:0] imm,
    input  logic [XLEN-1:0] alu_out,
    output logic [XLEN-1:0] next_pc,
    output logic [XLEN-1:0] pc
);

always_comb
begin
    next_pc = pc + 32'd4;

    if (branch && branch_taken)
        next_pc = pc + imm;
    else if (jump)
        next_pc = alu_result;
end

always_ff @(posedge clk, negedge n_reset)
    begin
    if (!n_reset)
        pc <= '0;
    else
        pc <= next_pc;
end
endmodule