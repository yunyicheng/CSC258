//8-bit shift register
module full_shifter(KEY, SW, LEDR);
	input [9:0] SW;
	input [3:0] KEY;
	output [9:0] LEDR;
	
	sub_shifter S0(.LoadVal(SW[7:0]),
						.clk(KEY[0]),
					   .Load_n(KEY[1]), 
					   .ShiftRight(KEY[2]), 
					   .ASR(KEY[3]),
					   .reset_n(SW[9]), 
					   .Q(LEDR[7:0]));
endmodule

//eight bit shifter sub module
module sub_shifter(LoadVal, Load_n, ShiftRight, ASR, clk, reset_n, Q);
	input [7:0] LoadVal;
	input Load_n;
   input ShiftRight;
   input ASR;
   input clk;
   input reset_n;
	output [7:0] Q;
	
	wire [7:0] sh_out;
	wire extension;
	
	sign_extension s(.asr(ASR), 
					    .in(LoadVal[7]), 
					    .out(extension));
	
	single_bit_shifter sh7(.load_val(LoadVal[7]), 
						   .load_n(Load_n), 
							.clk(clk), 
							.in(extension), 
							.shift(ShiftRight), 
							.reset_n(reset_n), 
							.out(sh_out[7]));
							
	single_bit_shifter sh6(.load_val(LoadVal[6]), 
						   .load_n(Load_n), 
							.clk(clk), 
							.in(sh_out[7]), 
							.shift(ShiftRight), 
							.reset_n(reset_n), 
							.out(sh_out[6]));

	single_bit_shifter sh5(.load_val(LoadVal[5]), 
						   .load_n(Load_n), 
							.clk(clk), 
							.in(sh_out[6]), 
							.shift(ShiftRight), 
							.reset_n(reset_n), 
							.out(sh_out[5]));
							
	single_bit_shifter sh4(.load_val(LoadVal[4]), 
						   .load_n(Load_n), 
							.clk(clk), 
							.in(sh_out[5]), 
							.shift(ShiftRight), 
							.reset_n(reset_n), 
							.out(sh_out[4]));
							
	single_bit_shifter sh3(.load_val(LoadVal[3]), 
						   .load_n(Load_n), 
							.clk(clk), 
							.in(sh_out[4]), 
							.shift(ShiftRight), 
							.reset_n(reset_n), 
							.out(sh_out[3]));
							
	single_bit_shifter sh2(.load_val(LoadVal[2]), 
						   .load_n(Load_n), 
							.clk(clk), 
							.in(sh_out[3]), 
							.shift(ShiftRight), 
							.reset_n(reset_n), 
							.out(sh_out[2]));
	
	single_bit_shifter sh1(.load_val(LoadVal[1]), 
						   .load_n(Load_n), 
							.clk(clk), 
							.in(sh_out[2]), 
							.shift(ShiftRight), 
							.reset_n(reset_n), 
							.out(sh_out[1]));
							
	single_bit_shifter sh0(.load_val(LoadVal[0]), 
						   .load_n(Load_n), 
							.clk(clk), 
							.in(sh_out[1]), 
							.shift(ShiftRight), 
							.reset_n(reset_n), 
							.out(sh_out[0]));
							
	assign Q = sh_out;
endmodule

//circuit to perform sign extension
module sign_extension(asr, in, out);
	input asr, in;
	output reg out;
	
	always @(*)
	begin
		if (asr == 1'b1)
			out <= in;
		else
			out <= 1'b0;
	end
endmodule

//1-bit shifter
module single_bit_shifter(load_val, load_n, clk, in, shift, reset_n, out);
   input load_n;
	input load_val;
   input clk;
   input in;
   input shift; 
   input reset_n;
	output out;
	
	wire M1M2;
	wire M2dff;
	wire dffout;
	
	mux2to1 M1(.x(dffout), 
					 .y(in), 
					 .s(shift), 
					 .m(M1M2));
					 
	mux2to1 M2(.x(load_val), 
					 .y(M1M2), 
					 .s(load_n), 
					 .m(M2dff));
					 
	flipflop ff(.clock(clk), 
					.reset_n(reset_n), 
					.d(M2dff), 
					.q(dffout));
	
	assign out = dffout;
endmodule

//2 to 1 multiplexer
module mux2to1(x, y, s, m);
    input x; //selected when s is 0
    input y; //selected when s is 1
    input s; //select signal
    output m; //output
  
    assign m = s & y | ~s & x;
endmodule

//D flip flop
module flipflop(clock, reset_n, d, q);
	input clock;
   input reset_n; 
   input d;
	output reg q;
	
	always @(posedge clock)
	begin
		if (reset_n == 1'b0)
			q <= 0;
		else 
			q <= d;
	end
endmodule