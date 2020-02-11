module morse_code(SW, KEY, CLOCK_50, LEDR);

// LEDR 0: display the Morse code.
// SW[2:0]: Choose which code to display
// KEY 1: display the Morse code for a letter specified by SW 2−0
//        (using 0.5-second pulses to represent dots, and 1.5-second pulses to represent dashes. 
//        The time between pulses is 0.5 seconds)
//KEY 0: asynchronous reset

	input [2:0] SW;
	input [1:0] KEY;
	input CLOCK_50;
	output [0:0] LEDR;
	reg [13:0] code;
	wire connection;
	
	always @(*)
	begin
		case(SW[2:0]) //initialize the code pattern based on the selected letter
			3'b000: code[13:0] = 14'b10101000000000;
			3'b001: code[13:0] = 14'b11100000000000;
			3'b010: code[13:0] = 14'b10101110000000;
			3'b011: code[13:0] = 14'b10101011100000;
			3'b100: code[13:0] = 14'b10111011100000;
			3'b101: code[13:0] = 14'b11101010111000;
			3'b110: code[13:0] = 14'b11101011101110;
			3'b111: code[13:0] = 14'b11101110101000;
			default: code[13:0] = 14'b00000000000000;
		endcase
	end
	
	rate_divider r0(
		.enable(connection), 
		.load(KEY[1]), 
		.clock(CLOCK_50)
	);

	shift_register s0(
		.LEDR(LEDR[0]),
		.enable(connection),
		.clock(CLOCK_50),
		.reset_n(KEY[0]),
		.load_val(KEY[1]),
		.code(code)
	);
endmodule

module rate_divider(enable, load, clock);
	input load;
	input clock;
	output enable;
	reg [24:0] count_down;
	
	always @(posedge clock)
	begin
		if (load == 1'b0)
			count_down <= 25'd24_999_999;
		else
			begin
				if (count_down == 9'd0)
					count_down <= 25'd24_999_999;
				else
					count_down <= count_down - 25'd1;
			end
	end
	assign enable = (count_down == 25'd0) ? 1 : 0;
endmodule

module shift_register(LEDR, enable, clock, reset_n, load_val, code);
	input enable, clock, reset_n, load_val;
	input [13:0] code;
	output reg LEDR;
	reg [13:0] pattern;
	
	always @(posedge clock, negedge reset_n)
	begin
		if (reset_n == 1'b0) // reset the register
			begin
				LEDR <= 1'b0;
				pattern <= 14'b0;
			end
		else if (enable == 1) // flash the morse code of the letter
			begin
				LEDR <= pattern[13];
				pattern <= (pattern >> 1'b1);
			end
		else if (load_val == 1'b0)
			begin
				LEDR <= 1'b0;
				pattern <= code;
			end
	end
endmodule