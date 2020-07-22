`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.02.2020 06:06:00
// Design Name: 
// Module Name: ALUControl
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


module ALUControl(
    input [2:0] aluop,
    input [6:0] funct7,
    input [2:0] funct3,
    output reg [3:0] control
    );
    
    
always@(*)
begin

    if(aluop == 3'b000)
    begin
        control = 4'b0010;
    end

    //Branch Operations
    if(aluop == 3'b010)
    begin
        //BEQ
        if(funct3 == 3'b0)
        begin
            control = 4'b1001;
        end
        
        //BNE
        if(funct3 == 3'b001)
        begin
            control = 4'b1011;
        end
        
        //BLT
          if(funct3 == 3'b100)
        begin
            control = 4'b1101;
        end
        
        //BGE
        if(funct3 == 3'b101)
        begin
            control = 4'b1111;
        end
    end
    
    //R - Type
    if(aluop == 3'b100)
    begin
        //ADD
        if(funct7 == 7'b0 && funct3 == 3'b0)
        begin
            control = 4'b0010;
        end

        if(funct7 == 7'b0100000)
        begin
            //SUB
            if(funct3 == 3'b0)
            begin
                control = 4'b0110;
            end
            //SRA
            if(funct3 == 3'b101)
            begin
                control = 4'b1000;
            end
        end

        if(funct7 == 7'b0)
        begin
            //AND
            if(funct3 == 3'b111)
            begin
                control = 4'b0000;
            end
            
            //OR
            if(funct3 == 3'b110)
            begin
                control = 4'b0001;
            end
            
            //XOR
            if(funct3 == 3'b100)
            begin
                control = 4'b1011;
            end

            //SLL
            if(funct3 == 3'b001)
            begin  
                control = 4'b0011;
            end
            
            //SRL
            if(funct3 == 3'b101)
            begin
                control = 4'b0111;
            end
        end
    end
    
    
    //I - Type
    if(aluop == 3'b110)
    begin
        //Addi
        if(funct3 == 3'b0)
        begin
            control = 4'b0010;
        end
        
        //XORI
        if(funct3 == 3'b100)
        begin
            control = 4'b1011;
        
        end

        if(funct7 == 7'b0)
        begin
            if(funct3 == 3'b001)
            begin
                control = 4'b0011;
            end
            
            if(funct3 == 3'b101)
            begin
                control = 4'b0111;
            end
        end
        
        if(funct7 == 7'b0100000)
        begin
            if(funct3 == 3'b101)
            begin
                control = 4'b0111;   
            end
        end
    end
    
    
    //JAL
    if(aluop == 3'b101)
    begin
        control = 4'b0100;
    end
    
    //JALR
    if(aluop == 3'b001)
    begin
        control = 4'b0101;
    end
end    
    
    
endmodule
