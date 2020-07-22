`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.01.2020 10:09:35
// Design Name: 
// Module Name: Alu
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

module ALU(
    input clk,
    input reset,
    input [63:0] a,
    input [63:0] b,
    input [3:0] alucontrol,
    input alusrc,
    input [63:0] imm,
    output reg [63:0] out,
    output reg bsignal,
    input [63:0] pc,
    output reg jsignal
    );
    
    reg [63:0] temp;

always@(*)
begin


    if(alusrc == 1)
    begin
        temp = imm;    
    
    end
    
    else
    begin
        temp = b;
    end

    //And
    if(alucontrol == 4'b0)
    begin
    
        out = a & temp;
        jsignal = 0;
        bsignal = 0;            
    
    end
        
    //Or
    if(alucontrol == 4'b0001)
    begin
    
        out = a | temp;
         jsignal = 0;
        bsignal = 0;
    
    end
    
    //XOR
    if(alucontrol == 4'b1011)
    begin
    
        out = a ^ temp;
         jsignal = 0;
        bsignal = 0;
    
    end
    
    
    //Add
    if(alucontrol == 4'b0010)
    begin
    
        out = a + temp;
         jsignal = 0;
        bsignal = 0;
    
    end
    
    
    //Sub
    if(alucontrol == 4'b0110)
    begin
    
        out = a - temp;
         jsignal = 0;
        bsignal = 0;
        
        
    end
    
    //SLL
    if(alucontrol == 4'b0011)
    begin
    
        out = a << temp;
         jsignal = 0;
        bsignal = 0;
    end
    
    //SRL
    if(alucontrol == 4'b0111)
    begin
    
        out = a >> temp;
         jsignal = 0;
        bsignal = 0;
    end
    
    //SRA
    if(alucontrol == 4'b1000)
    begin
    
        out = a >>> temp;
         jsignal = 0;
        bsignal = 0;
    end
    
    
    //BEQ
    if(alucontrol == 4'b1001)
    begin
    
            if(a == temp)
            begin
                
                bsignal = 1;
            
            end
            
        else
        begin
            bsignal = 0;
            
        end
        jsignal = 0;
    end
    
    //BNE
    if(alucontrol == 4'b1011)
    begin
        
        if(a == temp)
        begin
            
            bsignal = 0;
        
        end
            
        else
        begin
            bsignal = 1;
            
        end
          jsignal = 0;
    end
    
    //BLT
    if(alucontrol == 4'b1101)
    begin
        if(a < temp)
        begin
            
            bsignal = 1;
        
        end
            
        else
        begin
            bsignal = 0;
            
        end
          jsignal = 0;
    end
    
    //BGE
    if(alucontrol == 4'b1111)
    begin
    
        if(a >= temp)
        begin
            
            bsignal = 1;
        
        end
            
        else
        begin
            bsignal = 0;
            
        end
          jsignal = 0;
    
    end
    
    //JAL
    if(alucontrol == 4'b0100)
    begin
    
        $display("This is working");
        bsignal = 1;
        jsignal = 0;
        out = pc + 4;
       
    
    end
    
    if(alucontrol == 4'b0101)
    begin
        
        out = pc + 4;
        bsignal = 1;
        jsignal = 1;
    
    end

    
    

end
endmodule

    
    
    

