//1-bit shifter
module single_shifter(load_val, load_n, clk, in, shift, reset_n, out);
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