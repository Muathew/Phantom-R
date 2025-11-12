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
//              Version 2.0 12/11/25 restructure to match with pc_unit
////////////////////////////////////////////////////////////////////

module instr_mem #(
    parameter XLEN = 32,
    parameter MEM_SIZE = 256
)( 
    input logic clk, 
    input logic [XLEN-1:0] Iaddress,
    output logic [XLEN-1:0] Idata
);

// Memory array
logic [XLEN-1:0] mem [0:MEM_SIZE-1];

// Initialize memory with NOPs, then load program
initial begin
    for (int i = 0; i < MEM_SIZE; i++)
        mem[i] = 32'h00000013; // NOP = addi x0, x0, 0

    $readmemh("inst_mem.txt", mem);
end

// Asynchronous read (combinational)
assign instr = mem[addr[$clog2(MEM_SIZE)+1:2]];

endmodule