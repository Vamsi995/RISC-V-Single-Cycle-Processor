`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.02.2020 06:24:41
// Design Name: 
// Module Name: ImmGen
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


module ImmGen(
    input [6:0] opcode,funct7,
    input [4:0] rs1,rs2,rd,
    input [2:0] funct3,
    input [31:0] ins,
    output reg [63:0] imm
    
    );
    
    reg [11:0] temp;
    reg [12:0] temp1;
    reg [4:0] shamt;
    reg [19:0] Jtemp;
    reg [20:0] Ktemp;
    
always@(*)
begin
    
    //Itype
    if(opcode == 7'b0010011)
    begin
        if(funct3 == 3'b001 || funct3 == 3'b101)
        begin
            shamt = rs2;
            imm = shamt;
        end
        else
        begin
            temp = {funct7,rs2};
            imm = $signed(temp);
        end
    end
    
    //Load
    if(opcode == 7'b0000011)
    begin
        temp = {funct7,rs2};
        imm = $signed(temp);
    end
    //Store
    if(opcode == 7'b0100011)
    begin
        temp = {funct7,rd};
        imm = $signed(temp);
    end
    //SB -TYPE
    if(opcode == 7'b1100011)
    begin
        temp1 = {ins[31],ins[7],funct7[5:0],rd[4:1],1'b0};
        imm = $signed(temp1);
    end
    //JAL - UJ Format
    if(opcode == 7'b1101111)
    begin
        Ktemp = {ins[31],ins[19:12],ins[20],ins[30:21],1'b0};
        imm = $signed(Ktemp);
    end
   //JALR 
    if(opcode == 7'b1100111)
    begin
        temp = {funct7,rs2};
        imm = $signed(temp);
    end
end
endmodule
