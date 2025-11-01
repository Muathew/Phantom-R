/////////////////////////////////////////////////////////////////////
// Design unit: data memory
//            :
// File name  : dmem.sv
//            :
// Description: dmem for RV32IM RISC-V processor
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

module dmem #(parameter XLEN = 32, FUNCT3_W = 3, DMEM_W = 1024)(
    input logic clk,
    input logic n_reset,
    input logic mem_read,
    input logic mem_write,
    input logic [FUNCT3_W-1:0] funct3,
    input logic [XLEN-1:0] addr,
    input logic [XLEN-1:0] write_data,
    output logic [XLEN-1:0] read_data
);

`include "rvconstants.svh"

//Memory array
logic [XLEN-1:0] mem [0:DMEM_W-1];
logic [XLEN-1:0] rdata;

//combinational memory read
always_comb
begin

//The "a + b*addr[] " is used to appropriately address the memory as per RISC-V specifications,
//where memory uses byte-addressing (every 8 bits = 1 byte) 

//Memory read
if (mem_read) begin
    rdata = `ZERO;
        unique case (funct3)
        `LB_F3:  rdata = {{24{mem[addr[31:2]][8*addr[1:0]+7]}},
                         mem[addr[31:2]][8*addr[1:0]+7 : 8*addr[1:0]]};
        `LH_F3:  rdata = {{16{mem[addr[31:2]][16*addr[1]+15]}}, 
                        mem[addr[31:2]][16*addr[1]+15 : 16*addr[1]]};
        `LW_F3:  rdata = mem[addr[31:2]];
        `LBU_F3: rdata = {24'b0, mem[addr[31:2]][8*addr[1:0]+7 : 8*addr[1:0]]};
        `LHU_F3: rdata = {16'b0, mem[addr[31:2]][16*addr[1]+15 : 16*addr[1]]};
        default: rdata = `ZERO; 
        endcase
    end
end

assign read_data = rdata;

//Sequential write
always_ff @(posedge clk)
begin
    if (mem_write) begin
        unique case (funct3)
        `SB_F3: mem[addr[31:2]][8*addr[1:0]+7 : 8*addr[1:0]] <= write_data[7:0];
        `SH_F3: mem[addr[31:2]][16*addr[1]+15 : 16*addr[1]] <= write_data[15:0];
        `SW_F3: mem[addr[31:2]] <= write_data;
        endcase
    end
end
endmodule