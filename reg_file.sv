//////////////////  ///////////////////////////////////////////////////
// Design unit: resgister file
//            :
// File name  : register.sv
//            :
// Description: register file for RISC-V RV32IM processor soft core
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
//              Version 1.1 24/09/25
/////////////////////////////////////////////////////////////////////

module reg_file #(parameter ADDR_W = 5, XLEN = 32, REGFILE = 32;)(input logic clk, we
    input logic [ADDR_W-1:0] rs1,
    input logic [ADDR_W-1:0] rs2,
    input logic [ADDR_W-1:0] rd,
    input logic [XLEN-1:0] write_data,
    output logic [XLEN-1:0] oprnd_a,
    output logic [XLEN-1:0] oprnd_b);

logic [XLEN-1:0]    reg [0:REGFILE-1];

initial reg [0] = 0;

always_ff @(posedge clk)
    begin
    if (we)
        if (rd! = 0)
        reg [rd] <= write_data;
    end

always_comb 
    begin
    
    oprnd_a = (rs1 == 0) ? 0 : reg [rs1];
    oprnd_b = (rs2 == 0) ? 0 : reg [rs2];
   //reg [0] = 0; pitfall.

    end

endmodule