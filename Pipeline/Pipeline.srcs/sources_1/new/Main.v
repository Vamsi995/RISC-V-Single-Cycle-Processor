`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.01.2020 05:52:38
// Design Name: 
// Module Name: Main
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module Main(
      input clk,
      input reset
    );
    
    reg [95:0] if_id;
    reg [273:0] id_ex;
    reg [202:0] ex_mem;
    reg [134:0] mem_wb;
    
    reg [63:0] pc = 63'b0;
    
    
    wire [31:0] ins;
    wire [63:0] op1,op2;
    
    wire [4:0] rs1,rs2,rd;
    wire [6:0] opcode,funct7;
    wire [2:0] funct3;
    
    
    wire [63:0] write_data;
    wire [63:0] imm;
    
    
   wire memtoreg,regwrite,memread,memwrite,branch,alusrc;
   wire [2:0] aluop;
    
    reg [31:0] ins_r;
    
    reg [63:0] op1_r,op2_r,imm_r,pc_r;
    reg [3:0] aluCinp;
    reg [4:0] rd_r;
    reg [3:0] ex;
    reg [2:0] m;
    reg [1:0] wb;
    
    
    reg [4:0] rd_e;
    reg [63:0] op_e,alu_e,pc_e; 
    reg bsignal_e;
    reg [2:0] m_e;
    reg [1:0] wb_e;
    
    
    reg [63:0] write_w,alu_w;
    reg [4:0] rd_w;
    reg [1:0] wb_w;
    
    
    wire [3:0] control;
    
    wire [63:0] out;
    wire bsignal;
    
    
    
   
    
    InsMem insmem(clk,reset,pc,ins);
    RegFile regfile(clk,reset,ins,rs1,rs2,rd,funct7,opcode,funct3,op1,op2);
    ALU alu(op1_r,op2_r,control,ex[3],imm_r,out,bsignal,pc_r);
    
    Control con(ins_r[6:0],alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop);
    
    ALUControl alucon(aluop,aluCinp[3],aluCinp[2:0],control);        
    ImmGen immgen(opcode,funct7,rs1,rs2,rd,funct3,ins,imm);
    DataMem datamem(clk,reset,alu_e,m_e[1],m_e[2],op_e,write_data);
    WbReg wbreg(clk,reset,write_w,alu_w,wb_w[0],wb[1],rd_w);
    
    
    
    
always@(posedge clk)
begin

    ins_r = if_id[95:65]; //if_id stage
    
    //id_ex stage
    pc_r = id_ex[63:0];
    op1_r = id_ex[127:64];
    op2_r = id_ex[191:128];
    imm_r = id_ex[255:192];
    rd_r = id_ex[260:256];
    aluCinp = id_ex[264:261];
    wb = id_ex[266:265];
    m = id_ex[269:267];
    ex = id_ex[273:270];
    
    //ex_mem stage
    rd_e = ex_mem[4:0];
    op_e = ex_mem[68:5];
    alu_e = ex_mem[132:69];
    bsignal_e = ex_mem[133];
    pc_e = ex_mem[197:134];
    m_e = ex_mem[200:198];
    wb_e = ex_mem[202:201];
    
    if(bsignal_e & m_e[0] != 1)
    begin
        pc = pc + 1;
        
    end
    
    
    //mem_wb stage
    rd_w = mem_wb[4:0];
    alu_w = mem_wb[68:5];
    write_w = mem_wb[132:69];
    wb_w = mem_wb[134:133];
    
    
    
    
    
    if_id <= {ins,pc};
    id_ex <= {alusrc,aluop,memread,memwrite,branch,memtoreg,regwrite,ins_r[30],ins_r[14:12],ins_r[11:7],imm,op2,op1,pc};
    ex_mem <= {wb,m,pc_r + imm_r,bsignal,out,op2_r,rd_r};
    mem_wb <= {wb_e,write_data,alu_e,rd_e};
    
    


end

    
    
endmodule




