`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.02.2020 05:09:04
// Design Name: 
// Module Name: Control
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


module Control(
    input [6:0] opcode,
    output reg alusrc,
    output reg memtoreg,
    output reg regwrite,
    output reg memread,
    output reg memwrite,
    output reg branch,
    output reg [2:0] Aluop
    );
  
  
  
always@(*)
begin
    //R - type  
    if(opcode == 7'b0110011)
    begin
      
        alusrc = 0;
        memtoreg = 0;
        regwrite = 1;
        memread = 0;
        memwrite = 0;
        branch = 0;
        Aluop = 3'b100;
        
    end

    //I - Type
    if(opcode == 7'b0010011)
    begin
        alusrc = 1;
        memtoreg = 0;
        regwrite = 1;
        memread = 0;
        memwrite = 0;
        branch = 0;
        Aluop = 3'b110;
    end

    //I - type Load
    if(opcode == 7'b0000011)
    begin
        
        alusrc = 1;
        memtoreg = 1;
        regwrite = 1;
        memread = 1;
        memwrite = 0;
        branch = 0;
        Aluop = 3'b000;
    end

    //S-type Store
    if(opcode == 7'b0100011)
    begin
    
       
        alusrc = 1;
        memtoreg = -1;
        regwrite = 0;
        memread = 0;
        memwrite = 1;
        branch = 0;
        Aluop = 3'b000;    
    
    end
    
    //Branch Equals
    if(opcode == 7'b1100011)
    begin
        
        alusrc = 0;
        memtoreg = -1;
        regwrite = 0;
        memread = 0;
        memwrite = 0;
        branch = 1;
        Aluop = 3'b010; 
    
    end
    
    //JAL
    if(opcode == 7'b1101111)
    begin
        branch = 1;
        alusrc = 1;
        memtoreg = 0;
        regwrite = 1;
        memread = 0;
        memwrite = 0;
        Aluop = 3'b101;
        
    end
    
    
    //JALR
    if(opcode == 7'b1100111)
    begin
    
        branch = 1;
        alusrc = 1;
        memtoreg = 0;
        regwrite = 1;
        memread = 0;
        memwrite = 0;
        Aluop = 3'b001;    
    
    end
end
endmodule
