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
    
     wire [4:0] rs1,rs2,rd;
     wire [6:0] funct7,opcode;
     wire [2:0] funct3;    
     wire [63:0] op1,op2,final;
     wire [31:0] ins;
     reg [2:0] state = 3'b001;
     wire [2:0] aluop;
     wire [3:0] Alucontrol;
     wire [63:0] data_out;
    wire alusrc,memtoreg,memread,memwrite,branch,bsignal;
    wire [63:0] imm;
    reg [63:0] pc = 63'b0;
    wire jsignal;
    
        InsMem insmem(clk,reset,state,pc,ins);                
        Decoder decode(ins,clk,reset,rs1,rs2,rd,funct7,opcode,funct3,state);
        RegFile regfile(clk,reset,rs1,rs2,rd,op1,op2,state,data_out,opcode,regwrite);        
        DataMem datamem(clk,reset,final,memwrite,memread,memtoreg,state,op2,data_out);
        Control control(opcode,alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop);       
        ALU alu(clk,reset,op1,op2,Alucontrol,alusrc,imm,final,bsignal,pc,jsignal);
        ALUControl alucon(aluop,funct7,funct3,Alucontrol);
        ImmGen immgen(opcode,funct7,rs1,rs2,rd,funct3,ins,imm);

  always@(posedge clk)
    begin      
        case(state)
            3'b001 : state = 3'b010;
            3'b010 : state = 3'b011;
            3'b011 : state = 3'b100;
            3'b100 :
            begin
               state = 3'b101;
               if(bsignal & branch == 1)
                begin
                    if(opcode == 7'b1100111)
                    begin
                       pc = op1 + imm; 
                    end
                    else
                    begin
                        pc = imm + pc;
                    end
                end  
                else
                begin
                    pc = pc + 4;
                end
            end
            3'b101 : state = 3'b001;
        endcase
    end 
endmodule


