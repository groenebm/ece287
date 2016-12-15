module test(clk, rst, sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7, sw8, sw9, sw10, sw11, sw12, sw13, sw14, sw15, sw16, sw17, key0, key1,
 key2, key3, ledr0, ledr1, ledr2, ledr3, ledr4, ledr5, ledr6, ledr7, ledr8, ledr9, ledr10, ledr11, ledr12, ledr13, ledr14, ledr15,
 ledr16, ledr17, hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7, noonlight, morninglight,  VGA_R, VGA_B, VGA_G, VGA_BLANK_N, VGA_SYNC_N, VGA_HS, VGA_VS, VGA_CLK, ledg2);
input clk, rst;
output reg ledg2;
reg life;
reg rainy;
input sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7, sw8, sw9, sw10, sw11, sw12, sw13, sw14, sw15, sw16, sw17, key0, key1, key2, key3;
output reg ledr0, ledr1, ledr2, ledr3, ledr4, ledr5, ledr6, ledr7, ledr8, ledr9, ledr10, ledr11, ledr12, ledr13, ledr14, ledr15, ledr16, ledr17;
output [6:0] hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7;
output [7:0] VGA_R, VGA_B, VGA_G;
output VGA_HS, VGA_VS, VGA_BLANK_N, VGA_CLK, VGA_SYNC_N;
reg[31:0]height = 31'd200;
reg[31:0]place = 31'd100;
reg cold;
sevenseg needlight(needed[3],needed[2],needed[1],needed[0], hex4);
sevenseg rightlights(correct[3],correct[2],correct[1],correct[0], hex6);
tester2 vga(clk, VGA_R, VGA_B, VGA_G, VGA_BLANK_N, VGA_SYNC_N , VGA_HS, VGA_VS, !rst, VGA_CLK, height, place, life, rainy, cold);
reg [25:0] q;
reg [5:0] S;
reg [5:0] NS;
reg [23:0] counter;
reg rain;
reg deer; 
reg frost;
reg [2:0]actions; //000 = do nothing, 001 = water, 010 = hunt, 100 = put a heater out;
reg [8:0]correct;
reg [8:0]needed;
reg[2:0]scenario; //000 = rain, 001 = sun, 010 = deer, 100 = frost;
parameter day1a = 8'b00000001, day1b = 8'b00000010, day2a = 8'b00000011, day2b = 8'b00000100, day3a = 8'b00000101, day3b = 8'b00000110, day4a = 8'b00000111, day4b = 8'b00001000, day5a = 8'b00001001,
day5b = 8'b00001010, day6a = 8'b00001011, day6b = 8'b00001100, day7a = 8'b00001101, day7b = 8'b00001110, day8a = 8'b00001111, day8b = 8'b00010000, day9a = 8'b00010001, day9b = 8'b00010010, day10a = 8'b00010011,
day10b = 8'b00010100, day11a = 8'b00010101, day11b = 8'b00010110, day12a = 8'b00010111, day12b = 8'b00011000, day13a = 8'b00011001, day13b = 8'b00011010, day14a = 8'b00011011, day14b = 8'b00011100, day15a = 8'b00011101,
day15b = 8'b00011110, day16a = 8'b00011111, day16b = 8'b00100000, day17a = 8'b00100001, day17b = 8'b00100010, day18a = 8'b00100011, day18b = 8'b00100100;
				
output reg morninglight, noonlight;


always @ (posedge key3)begin


	

	if (rst == 1'b0) begin
		 S <= day1a; //start at day 1a
		 height <= 31'd200;
		 place <= 31'd100;
		 correct <= 1'b0;
		 needed <= 1'b0;
		 life <= 1'b1;
	 end else begin
	 
	actions[2] = sw17;
	actions[1] = sw16;
	actions[0] = sw15;

	 
	 S <= NS;
	 
	
	 if(life == 1'b1) begin
	 height = height + 42;
	 place  = place - 50;
	 end
	 needed = needed + 1'b1;
	 
	 
	if(scenario == actions && life == 1'b0 && needed > 2 ) begin
	correct = correct + 2'd2;
	end
	if(scenario == actions && life == 1'b1) begin
	correct = correct + 2'd1;
	end
	  
	if(correct < needed) begin
	life = 1'b0;
	ledg2 = life;
	end else begin
	life = 1'b1;
	ledg2 = life;
	end
	if(scenario == rain) begin
	rainy = 1'b1;
	end else begin
	rainy = 1'b0;
	end
	if(scenario == 3'b010 | deer) begin
	cold = 1'b1;
	end else begin
	cold = 1'b0;
	end
	
end	
end
	
always @ (*) begin
	case (S)
		day1a: NS = day1b;
		day1b: NS = day2a;
		day2a: NS = day2b;
		day2b: NS = day3a;
		day3a: NS = day3b;
		day3b: NS = day4a;
		day4a: NS = day4b;
		day4b: NS = day5a;
		day5a: NS = day5b;
		day5b: NS = day6a;
		day6a: NS = day6b;
		day6b: NS = day7a; 
		day7a: NS = day7b;
		day7b: NS = day8a;
		day8a: NS = day8b;
		day8b: NS = day9a;
		day9a: NS = day9b;
		day9b: NS = day10a;
		default: NS = day1b;
	endcase
end

always @ (posedge clk)
begin
	if (rst ==1'b0) begin
				ledr0 <= 1'b0;
				ledr1 <= 1'b1;
				ledr2 <= 1'b0;
				ledr3 <= 1'b1;
				ledr4 <= 1'b0;
				ledr5 <= 1'b1;
				ledr6 <= 1'b0;
				ledr7 <= 1'b1;
				ledr8 <= 1'b0;
				ledr9 <= 1'b1;
				ledr10 <= 1'b0;
				ledr11 <= 1'b1;
				ledr12 <= 1'b0;
				ledr13 <= 1'b1;
				ledr14 <= 1'b0;
				ledr15 <= 1'b1;
				ledr16 <= 1'b0;
				ledr17 <= 1'b1;
				morninglight <= 1'b1;
				noonlight <= 1'b1;
				scenario <= 3'b001;  //sun
	
	end
	else begin
	case (S)
		day1a: begin ledr0 <= 1'b0;
				ledr1 <= 1'b0;
				ledr2 <= 1'b0;
				ledr3 <= 1'b0;
				ledr4 <= 1'b0;
				ledr5 <= 1'b0;
				ledr6 <= 1'b0;
				ledr7 <= 1'b0;
				ledr8 <= 1'b0;
				ledr9 <= 1'b0;
				ledr10 <= 1'b0;
				ledr11 <= 1'b0;
				ledr12 <= 1'b0;
				ledr13 <= 1'b0;
				ledr14 <= 1'b0;
				ledr15 <= 1'b0;
				ledr16 <= 1'b0;
				ledr17 <= 1'b1;
				morninglight <= 1'b1;
				noonlight <= 1'b0;
				scenario <= 3'b001;
				end
				
		day1b: begin ledr0 <= 1'b0;
				ledr1 <= 1'b0;
				ledr2 <= 1'b0;
				ledr3 <= 1'b0;
				ledr4 <= 1'b0;
				ledr5 <= 1'b0;
				ledr6 <= 1'b0;
				ledr7 <= 1'b0;
				ledr8 <= 1'b0;
				ledr9 <= 1'b0;
				ledr10 <= 1'b0;
				ledr11 <= 1'b0;
				ledr12 <= 1'b0;
				ledr13 <= 1'b0;
				ledr14 <= 1'b0;
				ledr15 <= 1'b0;
				ledr16 <= 1'b0;
				ledr17 <= 1'b1;
				morninglight <= 1'b0;
				noonlight <= 1'b1;
				scenario <= 3'b001;
				end		
				
		day2a: begin ledr0 <= 1'b0;
				ledr1 <= 1'b0;
				ledr2 <= 1'b0;
				ledr3 <= 1'b0;
				ledr4 <= 1'b0;
				ledr5 <= 1'b0;
				ledr6 <= 1'b0;
				ledr7 <= 1'b0;
				ledr8 <= 1'b0;
				ledr9 <= 1'b0;
				ledr10 <= 1'b0;
				ledr11 <= 1'b0;
				ledr12 <= 1'b0;
				ledr13 <= 1'b0;
				ledr14 <= 1'b0;
				ledr15 <= 1'b0;
				ledr16 <= 1'b1;
				ledr17 <= 1'b0;
				morninglight <= 1'b1;
				noonlight <= 1'b0;
				scenario <= 3'b000;
				end
				
		day2b: begin ledr0 <= 1'b0;
				ledr1 <= 1'b0;
				ledr2 <= 1'b0;
				ledr3 <= 1'b0;
				ledr4 <= 1'b0;
				ledr5 <= 1'b0;
				ledr6 <= 1'b0;
				ledr7 <= 1'b0;
				ledr8 <= 1'b0;
				ledr9 <= 1'b0;
				ledr10 <= 1'b0;
				ledr11 <= 1'b0;
				ledr12 <= 1'b0;
				ledr13 <= 1'b0;
				ledr14 <= 1'b0;
				ledr15 <= 1'b0;
				ledr16 <= 1'b1;
				ledr17 <= 1'b0;
				morninglight <= 1'b0;
				noonlight <= 1'b1;
				scenario <= 3'b001;
				end
				
		day3a: begin ledr0 <= 1'b0;
				ledr1 <= 1'b0;
				ledr2 <= 1'b0;
				ledr3 <= 1'b0;
				ledr4 <= 1'b0;
				ledr5 <= 1'b0;
				ledr6 <= 1'b0;
				ledr7 <= 1'b0;
				ledr8 <= 1'b0;
				ledr9 <= 1'b0;
				ledr10 <= 1'b0;
				ledr11 <= 1'b0;
				ledr12 <= 1'b0;
				ledr13 <= 1'b0;
				ledr14 <= 1'b0;
				ledr15 <= 1'b1;
				ledr16 <= 1'b0;
				ledr17 <= 1'b0;
				morninglight <= 1'b1;
				noonlight <= 1'b0;
				scenario <= 3'b001;
				end
				
		day3b: begin ledr0 <= 1'b0;
				ledr1 <= 1'b0;
				ledr2 <= 1'b0;
				ledr3 <= 1'b0;
				ledr4 <= 1'b0;
				ledr5 <= 1'b0;
				ledr6 <= 1'b0;
				ledr7 <= 1'b0;
				ledr8 <= 1'b0;
				ledr9 <= 1'b0;
				ledr10 <= 1'b0;
				ledr11 <= 1'b0;
				ledr12 <= 1'b0;
				ledr13 <= 1'b0;
				ledr14 <= 1'b0;
				ledr15 <= 1'b1;
				ledr16 <= 1'b0;
				ledr17 <= 1'b0;
				morninglight <= 1'b0;
				noonlight <= 1'b1;
				scenario <= 3'b010;
				end
				
		day4a:  begin ledr0 <= 1'b0;
				ledr1 <= 1'b0;
				ledr2 <= 1'b0;
				ledr3 <= 1'b0;
				ledr4 <= 1'b0;
				ledr5 <= 1'b0;
				ledr6 <= 1'b0;
				ledr7 <= 1'b0;
				ledr8 <= 1'b0;
				ledr9 <= 1'b0;
				ledr10 <= 1'b0;
				ledr11 <= 1'b0;
				ledr12 <= 1'b0;
				ledr13 <= 1'b0;
				ledr14 <= 1'b1;
				ledr15 <= 1'b0;
				ledr16 <= 1'b0;
				ledr17 <= 1'b0;
				morninglight <= 1'b1;
				noonlight <= 1'b0;
				scenario <= 3'b010;
				end
				
		day4b:  begin ledr0 <= 1'b0;
				ledr1 <= 1'b0;
				ledr2 <= 1'b0;
				ledr3 <= 1'b0;
				ledr4 <= 1'b0;
				ledr5 <= 1'b0;
				ledr6 <= 1'b0;
				ledr7 <= 1'b0;
				ledr8 <= 1'b0;
				ledr9 <= 1'b0;
				ledr10 <= 1'b0;
				ledr11 <= 1'b0;
				ledr12 <= 1'b0;
				ledr13 <= 1'b0;
				ledr14 <= 1'b1;
				ledr15 <= 1'b0;
				ledr16 <= 1'b0;
				ledr17 <= 1'b0;
				morninglight <= 1'b0;
				noonlight <= 1'b1;
				scenario <= 3'b000;
				end
				
		day5a: begin ledr0 <= 1'b0;
				ledr1 <= 1'b0;
				ledr2 <= 1'b0;
				ledr3 <= 1'b0;
				ledr4 <= 1'b0;
				ledr5 <= 1'b0;
				ledr6 <= 1'b0;
				ledr7 <= 1'b0;
				ledr8 <= 1'b0;
				ledr9 <= 1'b0;
				ledr10 <= 1'b0;
				ledr11 <= 1'b0;
				ledr12 <= 1'b0;
				ledr13 <= 1'b1;
				ledr14 <= 1'b0;
				ledr15 <= 1'b0;
				ledr16 <= 1'b0;
				ledr17 <= 1'b0;
				morninglight <= 1'b1;
				noonlight <= 1'b0;
				scenario <= 3'b001;
				end
			
		day5b: begin ledr0 <= 1'b0;
				ledr1 <= 1'b0;
				ledr2 <= 1'b0;
				ledr3 <= 1'b0;
				ledr4 <= 1'b0;
				ledr5 <= 1'b0;
				ledr6 <= 1'b0;
				ledr7 <= 1'b0;
				ledr8 <= 1'b0;
				ledr9 <= 1'b0;
				ledr10 <= 1'b0;
				ledr11 <= 1'b0;
				ledr12 <= 1'b0;
				ledr13 <= 1'b1;
				ledr14 <= 1'b0;
				ledr15 <= 1'b0;
				ledr16 <= 1'b0;
				ledr17 <= 1'b0;
				morninglight <= 1'b0;
				noonlight <= 1'b1;
				scenario <= 3'b001;
				end
				
		day6a: begin ledr0 <= 1'b0;
				ledr1 <= 1'b0;
				ledr2 <= 1'b0;
				ledr3 <= 1'b0;
				ledr4 <= 1'b0;
				ledr5 <= 1'b0;
				ledr6 <= 1'b0;
				ledr7 <= 1'b0;
				ledr8 <= 1'b0;
				ledr9 <= 1'b0;
				ledr10 <= 1'b0;
				ledr11 <= 1'b0;
				ledr12 <= 1'b1;
				ledr13 <= 1'b0;
				ledr14 <= 1'b0;
				ledr15 <= 1'b0;
				ledr16 <= 1'b0;
				ledr17 <= 1'b0;
				morninglight <= 1'b1;
				noonlight <= 1'b0;
				scenario <= 3'b000;
				end
				
		day6b: begin ledr0 <= 1'b0;
				ledr1 <= 1'b0;
				ledr2 <= 1'b0;
				ledr3 <= 1'b0;
				ledr4 <= 1'b0;
				ledr5 <= 1'b0;
				ledr6 <= 1'b0;
				ledr7 <= 1'b0;
				ledr8 <= 1'b0;
				ledr9 <= 1'b0;
				ledr10 <= 1'b0;
				ledr11 <= 1'b0;
				ledr12 <= 1'b1;
				ledr13 <= 1'b0;
				ledr14 <= 1'b0;
				ledr15 <= 1'b0;
				ledr16 <= 1'b0;
				ledr17 <= 1'b0;
				morninglight <= 1'b0;
				noonlight <= 1'b1;
				scenario <= 3'b000;
				end		
				
		day7a: begin ledr0 <= 1'b0;
				ledr1 <= 1'b0;
				ledr2 <= 1'b0;
				ledr3 <= 1'b0;
				ledr4 <= 1'b0;
				ledr5 <= 1'b0;
				ledr6 <= 1'b0;
				ledr7 <= 1'b0;
				ledr8 <= 1'b0;
				ledr9 <= 1'b0;
				ledr10 <= 1'b0;
				ledr11 <= 1'b1;
				ledr12 <= 1'b0;
				ledr13 <= 1'b0;
				ledr14 <= 1'b0;
				ledr15 <= 1'b0;
				ledr16 <= 1'b0;
				ledr17 <= 1'b0;
				morninglight <= 1'b1;
				noonlight <= 1'b0;
				scenario <= 3'b000;
				end 
			
		day7b: begin ledr0 <= 1'b0;
				ledr1 <= 1'b0;
				ledr2 <= 1'b0;
				ledr3 <= 1'b0;
				ledr4 <= 1'b0;
				ledr5 <= 1'b0;
				ledr6 <= 1'b0;
				ledr7 <= 1'b0;
				ledr8 <= 1'b0;
				ledr9 <= 1'b0;
				ledr10 <= 1'b0;
				ledr11 <= 1'b1;
				ledr12 <= 1'b0;
				ledr13 <= 1'b0;
				ledr14 <= 1'b0;
				ledr15 <= 1'b0;
				ledr16 <= 1'b0;
				ledr17 <= 1'b0;
				morninglight <= 1'b0;
				noonlight <= 1'b1;
				scenario <= 3'b100;
				end 	
		
		day8a:  begin 
				ledr0 <= 1'b0;
				ledr1 <= 1'b0;
				ledr2 <= 1'b0;
				ledr3 <= 1'b0;
				ledr4 <= 1'b0;
				ledr5 <= 1'b0;
				ledr6 <= 1'b0;
				ledr7 <= 1'b0;
				ledr8 <= 1'b0;
				ledr9 <= 1'b0;
				ledr10 <= 1'b1;
				ledr11 <= 1'b0;
				ledr12 <= 1'b0;
				ledr13 <= 1'b0;
				ledr14 <= 1'b0;
				ledr15 <= 1'b0;
				ledr16 <= 1'b0;
				ledr17 <= 1'b0;
				morninglight <= 1'b1;
				noonlight <= 1'b0;
				scenario <= 3'b100;
				end	
				
		day8b:  begin 
				ledr0 <= 1'b0;
				ledr1 <= 1'b0;
				ledr2 <= 1'b0;
				ledr3 <= 1'b0;
				ledr4 <= 1'b0;
				ledr5 <= 1'b0;
				ledr6 <= 1'b0;
				ledr7 <= 1'b0;
				ledr8 <= 1'b0;
				ledr9 <= 1'b0;
				ledr10 <= 1'b1;
				ledr11 <= 1'b0;
				ledr12 <= 1'b0;
				ledr13 <= 1'b0;
				ledr14 <= 1'b0;
				ledr15 <= 1'b0;
				ledr16 <= 1'b0;
				ledr17 <= 1'b0;
				morninglight <= 1'b0;
				noonlight <= 1'b1;
				scenario <= 3'b001;
				end
				
		day9a: begin ledr0 <= 1'b0;
				ledr1 <= 1'b0;
				ledr2 <= 1'b0;
				ledr3 <= 1'b0;
				ledr4 <= 1'b0;
				ledr5 <= 1'b0;
				ledr6 <= 1'b0;
				ledr7 <= 1'b0;
				ledr8 <= 1'b0;
				ledr9 <= 1'b1;
				ledr10 <= 1'b0;
				ledr11 <= 1'b0;
				ledr12 <= 1'b0;
				ledr13 <= 1'b0;
				ledr14 <= 1'b0;
				ledr15 <= 1'b0;
				ledr16 <= 1'b0;
				ledr17 <= 1'b0;
				morninglight <= 1'b1;
				noonlight <= 1'b0;
				scenario <= 3'b001;
					end
					
		day9b: begin ledr0 <= 1'b0;
				ledr1 <= 1'b0;
				ledr2 <= 1'b0;
				ledr3 <= 1'b0;
				ledr4 <= 1'b0;
				ledr5 <= 1'b0;
				ledr6 <= 1'b0;
				ledr7 <= 1'b0;
				ledr8 <= 1'b0;
				ledr9 <= 1'b1;
				ledr10 <= 1'b0;
				ledr11 <= 1'b0;
				ledr12 <= 1'b0;
				ledr13 <= 1'b0;
				ledr14 <= 1'b0;
				ledr15 <= 1'b0;
				ledr16 <= 1'b0;
				ledr17 <= 1'b0;
				morninglight <= 1'b0;
				noonlight <= 1'b1;
				scenario <= 3'b010;
				end

				
		default: begin ledr0 <= 1'b1;
				ledr1 <= 1'b1;
				ledr2 <= 1'b1;
				ledr3 <= 1'b1;
				ledr4 <= 1'b1;
				ledr5 <= 1'b1;
				ledr6 <= 1'b1;
				ledr7 <= 1'b1;
				ledr8 <= 1'b1;
				ledr9 <= 1'b1;
				ledr10 <= 1'b1;
				ledr11 <= 1'b1;
				ledr12 <= 1'b1;
				ledr13 <= 1'b1;
				ledr14 <= 1'b1;
				ledr15 <= 1'b1;
				ledr16 <= 1'b1;
				ledr17 <= 1'b1;
				morninglight <= 1'b1;
				noonlight <= 1'b1;
				scenario <= 3'b001;
				end
endcase
end				
end			
endmodule





//===========================================//
//====================VGA====================//
//===========================================//
/*


VGA MODULE: Augmented by Brandt Groene and Haley Olson to display our project.

VGA MODULE: Modified by Parth Patel, Ian Baker, and Yi Zhan

Most of all the code here is modified to basic VGA Displaying capabilities,

VGA MODULE adopted from BEN SHAFFER...
Utilized Ben's VGA module that he borrowed from OAKLEY KATTERHEINRICH.
Parameters were set by Ben.

*/
//===========================================//
//====================VGA====================//
//===========================================//
module tester2(clk, VGA_R, VGA_B, VGA_G, VGA_BLANK_N, VGA_SYNC_N , VGA_HS, VGA_VS, rst, VGA_CLK, height, place, life, rainy, cold);
input life;
input rainy;
input cold;
//outputs the colors, determined from the color module.
output [7:0] VGA_R, VGA_B, VGA_G;
input wire [31:0]height;
input wire [31:0]place;
//Makes sure the screen is synced right.
output VGA_HS, VGA_VS, VGA_BLANK_N, VGA_CLK, VGA_SYNC_N;

input clk, rst; //clk is taken from the onboard clock 50MHz. rst is taken from a switch, SW[17].

wire CLK108; //Clock for the VGA

/*
Coordinates of the pixel being assigned. Moves top to bottom, left to right.
*/
wire [30:0]X, Y;

//Not sure what these are, probably have to do with the display output system.
wire [7:0]countRef;
wire [31:0]countSample;

/*COORDINATES, (X,Y) Starting at the top left hand corner of the monitor. True for all coordinates
in this code block.*/
//"object1"
reg [31:0] object1X = 31'd0, object1Y = 31'd0;

//"object2"
reg [31:0] object2X = 31'd100, object2Y = 31'd150;

reg [31:0] object3X = 31'd0, object3Y = 31'd0;

reg [31:0] object4X = 31'd0, object4Y = 31'd0;

reg [31:0] object5X = 31'd0, object5Y = 31'd0;

/* T = Top,  B = Bottom, L = Left, R = Right,  all with respect to the coordinate of where 
your "object" is placed.
T and L params are set to the object's upper lefthand.  
Best if you leave the Left hand side parameters to 0, i.e: Object1_L = 31'd0;
This will determine the available usable display space you have left.
*/
reg[8:0]day = 8'b00000000;


//======== Ground =======// //GROUND
//object1_localParams
parameter Object1_L = 31'd0; 
parameter Object1_R = Object1_L + 31'd1280;
parameter Object1_T = 31'd950;
parameter Object1_B = Object1_T + 31'd100;

///////////////////// Plant //////////////////////////////////////
//object2_localParams
parameter Object2_L = 31'd450;                   // how far over
parameter Object2_R = Object2_L + 31'd200;        //how wide
parameter Object2_T = 31'd800;                    //how far down 
parameter Object2_B = Object2_T + 31'd200;   //height            


/////////The sky /////////////


parameter Object3_L = 31'd0;                   // how far over
parameter Object3_R = Object3_L + 31'd1280;        //how wide
parameter Object3_T = 31'd0;                    //how far down 
parameter Object3_B = Object3_T + 31'd300;   //height 


// CORN//
parameter Object4_L = 31'd600;                   // how far over
parameter Object4_R = Object4_L + 31'd100;        //how wide
parameter Object4_T = 31'd400;                    //how far down 
parameter Object4_B = Object4_T + 31'd50;

//DEER BITE//


parameter Object5_L = 31'd100;                   // how far over
parameter Object5_R = Object5_L + 31'd500;        //how wide
parameter Object5_T = 31'd900;                    //how far down 
parameter Object5_B = Object5_T + 31'd100;


assign Object5 =((X >= Object5_L + object5X)&&(X <= Object5_R + object5X)&&(Y >= Object5_T+ object5Y)&&(Y <= Object5_B+ object5Y));
assign Object4 =((X >= Object4_L + object4X)&&(X <= Object4_R + object4X)&&(Y >= Object4_T+ object4Y)&&(Y <= Object4_B+ object4Y));
assign Object3 =((X >= Object3_L + object3X)&&(X <= Object3_R + object3X)&&(Y >= Object3_T+ object3Y)&&(Y <= Object3_B+ object3Y));
assign Object2 =((X >= Object2_L + object2X)&&(X <= Object2_R + object2X)&&(Y >= Object2_T+ object2Y + place)&&(Y <= Object2_B + object2Y + height));
assign Object1 =((X >= Object1_L + object1X)&&(X <= Object1_R + object1X)&&(Y >= Object1_T+ object1Y)&&(Y <= Object1_B+ object1Y));











//======Borrowed Code======//
//==========DO NOT EDIT BELOW==========//
countingRefresh(X, Y, clk, countRef );
clock108(rst, clk, CLK_108, locked);

wire hblank, vblank, clkLine, blank;

//Sync the display
H_SYNC(CLK_108, VGA_HS, hblank, clkLine, X);
V_SYNC(clkLine, VGA_VS, vblank, Y);
//==========DO NOT EDIT ABOVE==========//


//======DISPLAY CODE IN ORDER OF LAYER IMPORTANCE======//
/*This block sets the priority of what to display in order, best to list in order of importance.
The lowercase variables translate the object-to-be-displayed decision to the color module.
*/
reg box1, box2, box3, box4, box5;

//drawing shapes	
always@(*)
begin
	if(Object1) begin
		box1 = 1'b1;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		end
	else if(Object4 && height > 750) begin
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b1;
		box5 = 1'b0;
		end
	else if(Object5 && cold == 1'b1) begin
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b1;
		end
	else if(Object2) begin
		box1 = 1'b0;
		box2 = 1'b1;
		box3 = 1'b0;
	   box4 = 1'b0;
		box5 = 1'b0;
		end
	else if(Object3 && rainy == 1'b1) begin
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b1;
		box4 = 1'b0;
		box5 = 1'b0;
		end

	else begin  //fixed error with background crashing --Brandt
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		end
	end 


//======Modified Borrowed Code======//
//Determines the color output based on the decision from the priority block
color(clk, VGA_R, VGA_B, VGA_G, life, box1, box2, box3, box4);

//======Borrowed code======//
//======DO NOT EDIT========//
assign VGA_CLK = CLK_108;
assign VGA_BLANK_N = VGA_VS&VGA_HS;
assign VGA_SYNC_N = 1'b0;
endmodule


//Controls the counter
module countingRefresh(X, Y, clk, count);
input [31:0]X, Y;
input clk;
output [7:0]count;
reg[7:0]count;
always@(posedge clk)
begin
	if(X==0 &&Y==0)
		count<=count+1;
	else if(count==7'd11)
		count<=0;
	else
		count<=count;
end

endmodule



//======Formatted like Borrowed code, adjust you own parameters======//
//============================//
//========== COLOR ===========//
//============================//
module color(clk, red, blue, green, life, box1, box2, box3, box4, box5);
input life;
input clk, box1, box2, box3, box4, box5;

output [7:0] red, blue, green;
reg[7:0] red, green, blue;

always@(*)
begin
	if(box1) begin
		red = 8'd204;
		blue = 8'd034;
		green = 8'd119;
		end
	else if(box2) begin
		if(life == 1'b1) begin
		red = 8'd000;
		blue = 8'd000;
		green = 8'd128;
		end else begin
		red = 8'd128;
		blue = 8'd000;
		green = 8'd000;
		end
		end
		else if(box3) begin
		red = 8'd128;
		blue = 8'd128;
		green = 8'd128;
		end
		else if(box4) begin
		red = 8'd253;
		blue = 8'd35;
		green = 8'd208;
		end
		else if(box5) begin
		red = 8'd128;
		blue = 8'd200;
		green = 8'd100;
		
//BACKGROUND COLOR ****************
	end else begin
		red = 8'd240;
		blue = 8'd255;
		green = 8'd248;
		end
	end
	
endmodule





//====================================//
//========DO NOT EDIT PAST HERE=======//
//====================================//
/* --VGA CONTROLLER MODULES--
 * Controls vga output syncs and clk
 */
module H_SYNC(clk, hout, bout, newLine, Xcount);

input clk;
output hout, bout, newLine;
output [31:0] Xcount;
	
reg [31:0] count = 32'd0;
reg hsync, blank, new1;

always @(posedge clk) 
begin
	if (count <  1688)
		count <= Xcount + 1;
	else 
      count <= 0;
   end 

always @(*) 
begin
	if (count == 0)
		new1 = 1;
	else
		new1 = 0;
   end 

always @(*) 
begin
	if (count > 1279) 
		blank = 1;
   else 
		blank = 0;
   end

always @(*) 
begin
	if (count < 1328)
		hsync = 1;
   else if (count > 1327 && count < 1440)
		hsync = 0;
   else    
		hsync = 1;
	end

assign Xcount=count;
assign hout = hsync;
assign bout = blank;
assign newLine = new1;

endmodule


module V_SYNC(clk, vout, bout, Ycount);

input clk;
output vout, bout;
output [31:0]Ycount; 
	  
reg [31:0] count = 32'd0;
reg vsync, blank;

always @(posedge clk) 
begin
	if (count <  1066)
		count <= Ycount + 1;
   else 
            count <= 0;
   end 

always @(*) 
begin
	if (count < 1024) 
		blank = 1;
   else 
		blank = 0;
   end

always @(*) 
begin
	if (count < 1025)
		vsync = 1;
	else if (count > 1024 && count < 1028)
		vsync = 0;
	else    
		vsync = 1;
	end

assign Ycount=count;
assign vout = vsync;
assign bout = blank;

endmodule

//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module clock108 (areset, inclk0, c0, locked);

input     areset;
input     inclk0;
output    c0;
output    locked;

`ifndef ALTERA_RESERVED_QIS
 //synopsys translate_off
`endif

tri0      areset;

`ifndef ALTERA_RESERVED_QIS
 //synopsys translate_on
`endif

wire [0:0] sub_wire2 = 1'h0;
wire [4:0] sub_wire3;
wire  sub_wire5;
wire  sub_wire0 = inclk0;
wire [1:0] sub_wire1 = {sub_wire2, sub_wire0};
wire [0:0] sub_wire4 = sub_wire3[0:0];
wire  c0 = sub_wire4;
wire  locked = sub_wire5;
	 
altpll  altpll_component (
            .areset (areset),
            .inclk (sub_wire1),
            .clk (sub_wire3),
            .locked (sub_wire5),
            .activeclock (),
            .clkbad (),
            .clkena ({6{1'b1}}),
            .clkloss (),
            .clkswitch (1'b0),
            .configupdate (1'b0),
            .enable0 (),
            .enable1 (),
            .extclk (),
            .extclkena ({4{1'b1}}),
            .fbin (1'b1),
            .fbmimicbidir (),
            .fbout (),
            .fref (),
            .icdrclk (),
            .pfdena (1'b1),
            .phasecounterselect ({4{1'b1}}),
            .phasedone (),
            .phasestep (1'b1),
            .phaseupdown (1'b1),
            .pllena (1'b1),
            .scanaclr (1'b0),
            .scanclk (1'b0),
            .scanclkena (1'b1),
            .scandata (1'b0),
            .scandataout (),
            .scandone (),
            .scanread (1'b0),
            .scanwrite (1'b0),
            .sclkout0 (),
            .sclkout1 (),
            .vcooverrange (),
            .vcounderrange ());
defparam
    altpll_component.bandwidth_type = "AUTO",
    altpll_component.clk0_divide_by = 25,
    altpll_component.clk0_duty_cycle = 50,
    altpll_component.clk0_multiply_by = 54,
    altpll_component.clk0_phase_shift = "0",
    altpll_component.compensate_clock = "CLK0",
    altpll_component.inclk0_input_frequency = 20000,
    altpll_component.intended_device_family = "Cyclone IV E",
    altpll_component.lpm_hint = "CBX_MODULE_PREFIX=clock108",
    altpll_component.lpm_type = "altpll",
    altpll_component.operation_mode = "NORMAL",
    altpll_component.pll_type = "AUTO",
    altpll_component.port_activeclock = "PORT_UNUSED",
    altpll_component.port_areset = "PORT_USED",
    altpll_component.port_clkbad0 = "PORT_UNUSED",
    altpll_component.port_clkbad1 = "PORT_UNUSED",
    altpll_component.port_clkloss = "PORT_UNUSED",
    altpll_component.port_clkswitch = "PORT_UNUSED",
    altpll_component.port_configupdate = "PORT_UNUSED",
    altpll_component.port_fbin = "PORT_UNUSED",
    altpll_component.port_inclk0 = "PORT_USED",
    altpll_component.port_inclk1 = "PORT_UNUSED",
    altpll_component.port_locked = "PORT_USED",
    altpll_component.port_pfdena = "PORT_UNUSED",
    altpll_component.port_phasecounterselect = "PORT_UNUSED",
    altpll_component.port_phasedone = "PORT_UNUSED",
    altpll_component.port_phasestep = "PORT_UNUSED",
    altpll_component.port_phaseupdown = "PORT_UNUSED",
    altpll_component.port_pllena = "PORT_UNUSED",
    altpll_component.port_scanaclr = "PORT_UNUSED",
    altpll_component.port_scanclk = "PORT_UNUSED",
    altpll_component.port_scanclkena = "PORT_UNUSED",
    altpll_component.port_scandata = "PORT_UNUSED",
    altpll_component.port_scandataout = "PORT_UNUSED",
    altpll_component.port_scandone = "PORT_UNUSED",
    altpll_component.port_scanread = "PORT_UNUSED",
    altpll_component.port_scanwrite = "PORT_UNUSED",
    altpll_component.port_clk0 = "PORT_USED",
    altpll_component.port_clk1 = "PORT_UNUSED",
    altpll_component.port_clk2 = "PORT_UNUSED",
    altpll_component.port_clk3 = "PORT_UNUSED",
    altpll_component.port_clk4 = "PORT_UNUSED",
    altpll_component.port_clk5 = "PORT_UNUSED",
    altpll_component.port_clkena0 = "PORT_UNUSED",
    altpll_component.port_clkena1 = "PORT_UNUSED",
    altpll_component.port_clkena2 = "PORT_UNUSED",
    altpll_component.port_clkena3 = "PORT_UNUSED",
    altpll_component.port_clkena4 = "PORT_UNUSED",
    altpll_component.port_clkena5 = "PORT_UNUSED",
    altpll_component.port_extclk0 = "PORT_UNUSED",
    altpll_component.port_extclk1 = "PORT_UNUSED",
    altpll_component.port_extclk2 = "PORT_UNUSED",
    altpll_component.port_extclk3 = "PORT_UNUSED",
    altpll_component.self_reset_on_loss_lock = "OFF",
    altpll_component.width_clock = 5;

endmodule

module sevenseg(a,b,c,d, O);   //Adapted from our lab
	input a,b,c,d;
	output reg [6:0]O; //The O values match those given within the DE2-115 user manual, so it transfers 1-to-1.
always @ (*)
begin
	O[0]=!((c&!d)|(!a&c)|(b&c)|(!a&b&d)|(a&!c&!d)|(a&!b&!c)|(!b&!d));
	O[1]=!((!a&!b)|(!a&!c&!d)|(!a&c&d)|(a&!c&d)|(a&!b&!d));
	O[2]=!((!a&!c)|(!a&d)|(!a&b)|(!c&d)|(a&!b));
	O[3]=!((!b&!c&!d)|(a&b&!c)|(b&!c&d)|(!b&c&d)|(!a&!b&c)|(b&c&!d));
	O[4]=!((!a&!b&!d)|(a&b)|(a&!c&!d)|(a&c)|(c&!d));
	O[5]=!((!c&!d)|(!a&b&!c)|(a&!b)|(a&c)|(b&!d));
	O[6]=!((!a&!b&c)|(!a&b&!c)|(a&!b)|(c&!d)|(a&d));
	end
endmodule 