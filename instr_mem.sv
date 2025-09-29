/////////////////////////////////////////////////////////////////////
// Design unit: instr_mem
//            :
// File name  : instr_mem.sv
//            :
// Description: instruction memory for 32-bit RISC-V processor
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

module instr_mem #(parameter XLEN = 32, MEM_SIZE = 256;)( 
    input logic clk, 
    input logic [XLEN-1:0] Iaddress,
    output logic [XLEN-1:0] Idata
);

logic[XLEN-1:0]   mem[MEM_SIZE-1:0];

initial
    begin 
    for (int i = 0; i < MEM_SIZE; i++) mem[i] = 32'h00000013; //NOP to avoid undefined memory 
$readmemh("inst_mem.txt", mem);
    end

always_ff @(posedge clk)
    begin

    Idata <= mem[Iaddress[11:2]];

    end

endmodule