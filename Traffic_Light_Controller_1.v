`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Mayank Trehan
// 
// Create Date: 18.04.2023 21:37:12
// Design Name: 
// Module Name: TLC
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


module TLC(
            input clk,
            input rst,
            input night_sensor,
            output reg Red_Big_Highway,
            output reg Red_Small_Highway,
            output reg Yellow_Big_Highway,
            output reg Yellow_Small_Highway,
            output reg Green_Big_Highway,
            output reg Green_Small_Highway
            );
////// BIG HIGHWAY____Small HIGHWAY///////////
parameter Yellow_Yellow = 0;
parameter Red_Green = 1;
parameter Red_Yellow = 2;
parameter Green_Red = 3;
parameter Yellow_Red = 4;
//////////////////////////////////////////////
integer Counter_Delay_5Count_Yellow = 0;
integer Counter_Delay_10Count_Green_Small = 0;
integer Counter_Delay_30Count_Green_Big = 0;
//////////////////////////////////////////////
reg [2:0] Present_State, Next_State;
reg Counter_Delay_5Count_Yellow_Pulse = 0;///////
reg Counter_Delay_10Count_Green_Small_Pulse = 0;//////
reg Counter_Delay_30Count_Green_Big_Pulse = 0;///////
//////////////////////////////////////////////
reg En_Counter_Delay_5Count_Yellow_Pulse = 0;///////
reg En_Counter_Delay_10Count_Green_Small_Pulse = 0;//////
reg En_Counter_Delay_30Count_Green_Big_Pulse = 0;///////
//////////////////////////////////////////////
initial begin
Present_State = Yellow_Yellow;
end
//////////////////////////////////////////////
always@(posedge clk)
    begin
        if (rst)
            Present_State = Yellow_Yellow;
        else 
            Present_State = Next_State;
    end
//////////////////////////////////////////////
always@(posedge clk)
begin
    if (En_Counter_Delay_5Count_Yellow_Pulse ==1 && Counter_Delay_5Count_Yellow < 5) begin
        Counter_Delay_5Count_Yellow = Counter_Delay_5Count_Yellow +1;
        Counter_Delay_5Count_Yellow_Pulse = 0;
        En_Counter_Delay_5Count_Yellow_Pulse = 1;
        end
    else if (En_Counter_Delay_5Count_Yellow_Pulse ==1 && Counter_Delay_5Count_Yellow == 5) begin
        Counter_Delay_5Count_Yellow = Counter_Delay_5Count_Yellow +1;
        Counter_Delay_5Count_Yellow_Pulse = 1;
        En_Counter_Delay_5Count_Yellow_Pulse = 1;
        end
    else if (En_Counter_Delay_5Count_Yellow_Pulse ==1 && Counter_Delay_5Count_Yellow == 6) begin
        Counter_Delay_5Count_Yellow = Counter_Delay_5Count_Yellow +1;
        Counter_Delay_5Count_Yellow_Pulse = 1;
        En_Counter_Delay_5Count_Yellow_Pulse = 1;
        end 
    else begin
        Counter_Delay_5Count_Yellow = 0;
        Counter_Delay_5Count_Yellow_Pulse = 0;
        En_Counter_Delay_5Count_Yellow_Pulse = 0;   
        end  
end
////////////////////////////////////////////// 
//////////////////////////////////////////////
always@(posedge clk)
begin
    if (En_Counter_Delay_10Count_Green_Small_Pulse ==1 && Counter_Delay_10Count_Green_Small < 10) begin
        Counter_Delay_10Count_Green_Small = Counter_Delay_10Count_Green_Small +1;
        Counter_Delay_10Count_Green_Small_Pulse = 0;
        En_Counter_Delay_10Count_Green_Small_Pulse = 1;
        end
    else if (En_Counter_Delay_10Count_Green_Small_Pulse ==1 && Counter_Delay_10Count_Green_Small == 10) begin
        Counter_Delay_10Count_Green_Small = Counter_Delay_10Count_Green_Small +1;
        Counter_Delay_10Count_Green_Small_Pulse = 1;
        En_Counter_Delay_10Count_Green_Small_Pulse = 1;
        end
    else if (En_Counter_Delay_10Count_Green_Small_Pulse ==1 && Counter_Delay_10Count_Green_Small == 11) begin
        Counter_Delay_10Count_Green_Small = Counter_Delay_10Count_Green_Small +1;
        Counter_Delay_10Count_Green_Small_Pulse = 1;
        En_Counter_Delay_10Count_Green_Small_Pulse = 1;
        end 
    else begin
        Counter_Delay_10Count_Green_Small = 0;
        Counter_Delay_10Count_Green_Small_Pulse = 0;
        En_Counter_Delay_10Count_Green_Small_Pulse = 0;   
        end  
end
//////////////////////////////////////////////
//////////////////////////////////////////////
always@(posedge clk)
begin
    if (En_Counter_Delay_30Count_Green_Big_Pulse ==1 && Counter_Delay_30Count_Green_Big < 30) begin
        Counter_Delay_30Count_Green_Big = Counter_Delay_30Count_Green_Big +1;
        Counter_Delay_30Count_Green_Big_Pulse = 0;
        En_Counter_Delay_30Count_Green_Big_Pulse = 1;
        end
    else if (En_Counter_Delay_30Count_Green_Big_Pulse ==1 && Counter_Delay_30Count_Green_Big == 30) begin
        Counter_Delay_30Count_Green_Big = Counter_Delay_30Count_Green_Big +1;
        Counter_Delay_30Count_Green_Big_Pulse = 1;
        En_Counter_Delay_30Count_Green_Big_Pulse = 1;
        end
    else if (En_Counter_Delay_30Count_Green_Big_Pulse ==1 && Counter_Delay_30Count_Green_Big == 31) begin
        Counter_Delay_30Count_Green_Big = Counter_Delay_30Count_Green_Big +1;
        Counter_Delay_30Count_Green_Big_Pulse = 1;
        En_Counter_Delay_30Count_Green_Big_Pulse = 0;
        end 
    else begin
        Counter_Delay_30Count_Green_Big = 0;
        Counter_Delay_30Count_Green_Big_Pulse = 0;
        En_Counter_Delay_30Count_Green_Big_Pulse = 0;   
        end  
end
//////////////////////////////////////////////      
always@(*)
    begin
        case(Present_State)
            Yellow_Yellow:begin
                if (night_sensor)
                    Next_State = Yellow_Yellow;
                else
                    Next_State = Red_Green;
                end
             Red_Green: begin
                if (night_sensor)
                    Next_State = Yellow_Yellow;
                else
                    if (Counter_Delay_10Count_Green_Small_Pulse)
                        Next_State = Red_Yellow;
                    else
                        Next_State = Red_Green;
                end
             Red_Yellow: begin
                if (night_sensor)
                    Next_State = Yellow_Yellow;
                else
                    if (Counter_Delay_5Count_Yellow_Pulse)
                        Next_State = Green_Red;
                    else
                        Next_State = Red_Yellow;
                end
             Green_Red: begin
                if (night_sensor)
                    Next_State = Yellow_Yellow;
                else
                    if (Counter_Delay_30Count_Green_Big_Pulse)
                        Next_State = Yellow_Red;
                    else
                        Next_State = Green_Red;
                end   
             Yellow_Red: begin
                if (night_sensor)
                    Next_State = Yellow_Yellow;
                else
                    if (Counter_Delay_5Count_Yellow_Pulse)
                        Next_State = Red_Green;
                    else
                        Next_State = Yellow_Red;
                end
        endcase
    end    
//////////////////////////////////////////////      
always@(*)
    begin
        case(Present_State)
            Yellow_Yellow:begin
                                Red_Big_Highway=0;
                                Red_Small_Highway=0;
                                Yellow_Big_Highway=1;
                                Yellow_Small_Highway=1;
                                Green_Big_Highway=0;
                                Green_Small_Highway=0;        
             end
             Red_Green: begin
                                Red_Big_Highway=1;
                                Red_Small_Highway=0;
                                Yellow_Big_Highway=0;
                                Yellow_Small_Highway=0;
                                Green_Big_Highway=0;
                                Green_Small_Highway=1;
                                En_Counter_Delay_10Count_Green_Small_Pulse = 1; 
             end
             Red_Yellow: begin
                                Red_Big_Highway=1;
                                Red_Small_Highway=0;
                                Yellow_Big_Highway=0;
                                Yellow_Small_Highway=1;
                                Green_Big_Highway=0;
                                Green_Small_Highway=0;
                                En_Counter_Delay_5Count_Yellow_Pulse = 1;
             end
             Green_Red: begin
                                Red_Big_Highway=0;
                                Red_Small_Highway=1;
                                Yellow_Big_Highway=0;
                                Yellow_Small_Highway=0;
                                Green_Big_Highway=1;
                                Green_Small_Highway=0;
                                En_Counter_Delay_30Count_Green_Big_Pulse = 1;
             end   
             Yellow_Red: begin
                                Red_Big_Highway=0;
                                Red_Small_Highway=1;
                                Yellow_Big_Highway=1;
                                Yellow_Small_Highway=0;
                                Green_Big_Highway=0;
                                Green_Small_Highway=0;
                                En_Counter_Delay_5Count_Yellow_Pulse = 1;
             end
        endcase
    end    
//////////////////////////////////////////////  
endmodule