`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Mayank Trehan
// 
// Create Date: 19.04.2023 11:03:22
// Design Name: 
// Module Name: TEST
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


module TEST();
reg clk,rst,night_sensor;
wire Red_Big_Highway,Red_Small_Highway;
wire Yellow_Big_Highway, Yellow_Small_Highway;
wire Green_Big_Highway, Green_Small_Highway;

TLC Block1(
           clk,
           rst,
           night_sensor,
           Red_Big_Highway,
           Red_Small_Highway,
           Yellow_Big_Highway,
           Yellow_Small_Highway,
           Green_Big_Highway,
           Green_Small_Highway
            );
always #10 clk = ~clk;

initial begin
rst =0;
clk = 0;
night_sensor =1;
#2000
night_sensor =0;
#2000 
$stop;            
end            
endmodule
