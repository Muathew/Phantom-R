
`include "rvconstants.svh"

module phantomrv_core #(
    parameter XLEN  = 32,
    parameter OP_W  = 7,
    parameter IMM_W = 3
)(
    input logic clk,
    input logic n_reset
);

//PC and IMEM
logic [XLEN-1:0] pc, next_pc;
logic [XLEN-1;0] instr;

pc_unit pc_inst(
    .clk(clk),
    .n_reset(n_reset),
    .branch(branch),
    .jump(jump),
    .branch_taken(branch_taken),
    .imm(imm),
    .alu_out(alu_out),
    .next_pc(next_pc),
    .pc(pc)
);

instr_mem #(
    .XLEN(XLEN),
    .MEM_SIZE(256)
)   imem_inst (
    .addr(pc),
    .instr(instr)
);

//Decode and control
logic alu_src, brach, jump, mem_read, mem_write, reg_write, mem_to_reg;
logic [IMM_W-1:0] imm_type;

ctrl_unit ctrl (
    .opcode(instr[6:0]),
    .alu_src(alu_src),
    .branch(branch),
    .jump(jump),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .reg_write(reg_write),
    .mem_to_reg(mem_to_reg),
    .imm_type(imm_type)
);

//Register file
logic [4:0] rs1, rs2, rd;
logic [XLEN-1:0] rs1_data, rs2_data, wb_data;

assign rs1 = instr[19:15];
assign rs2 = instr[24:20];
assign rd  = instr[11:7];

reg_file rf (
    .clk(clk),
    .n_reset(n_reset),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .rd_data(wb_data),
    .reg_write(reg_write),
    .rs1_data(rs1_data),
    .rs2_data(rs2_data)
);

//imm_gen
logic [XLEN-1:0] imm;

imm_gen immgen (
    .imm_type(imm_type),
    .instr(instr),
    .imm(imm)
);

//ALU contrl and execution
alu_ctrl aluctrl(
    .opcode(opcode),
    .funct3(funct3),
    .funct7(funct7),
    .alu_op(alu_op)
);

assign alu_in2 = alu_src ? imm : rs2_data;

alu alu_inst (
    .oprnd_a (rs1_data),
    .oprnd_b (alu_in2),
    .alu_op (alu_op),
    .alu_out (alu_out)
);

//DMEM
logic [XLEN-1:0] mem_read_data;

dmem dmem0 (
    .clk (clk),
    .addr (alu_out),
    .write_data (rs2_data),
    .mem_read (mem_read),
    .mem_write (mem_write),
    .read_data (mem_read_data)
);

//Writeback mux
assign wb_data = mem_to_reg ? mem_read_data : alu_out;
endmodule