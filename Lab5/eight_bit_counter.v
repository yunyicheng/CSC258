//8-bit counter
module eight_bit_counter(KEY, SW, HEX0, HEX1, LEDR);
   input [0:0] KEY; // clock
	input [1:0] SW; // SW1 = Enable, SW0 = clear_b
	output [6:0] HEX0; //Displaying the least-significant 4 bit value of counter using hexadecimal
	output [6:0] HEX1; //Displaying the most-significant 4 bit value of counter using hexadecimal
	output [7:0] LEDR; // temporary output for "and" logic connection
	wire [1:7] Connection; // wires connecting T-fliflops
	
	// Using LEDR and Connection wires to create and gates
	assign Connection[1] = SW[1] & LEDR[0];
	assign Connection[2] = Connection[1] & LEDR[1];
	assign Connection[3] = Connection[2] & LEDR[2];
	assign Connection[4] = Connection[3] & LEDR[3];
	assign Connection[5] = Connection[4] & LEDR[4];
	assign Connection[6] = Connection[5] & LEDR[5];
	assign Connection[7] = Connection[6] & LEDR[6];
	
	my_tff C0(.t(SW[1]), 
				 .clock(KEY[0]), 
				 .clear_b(SW[0]),
				 .q(LEDR[0]));
				 
	my_tff C1(.t(Connection[1]), 
				 .clock(KEY[0]), 
				 .clear_b(SW[0]),
				 .q(LEDR[1]));
				 
	my_tff C2(.t(Connection[2]), 
				 .clock(KEY[0]), 
				 .clear_b(SW[0]),
				 .q(LEDR[2]));
				 
	my_tff C3(.t(Connection[3]), 
				 .clock(KEY[0]), 
				 .clear_b(SW[0]),
				 .q(LEDR[3]));
				 
	my_tff C4(.t(Connection[4]), 
				 .clock(KEY[0]), 
				 .clear_b(SW[0]),
				 .q(LEDR[4]));
				 
	my_tff C5(.t(Connection[5]), 
				 .clock(KEY[0]), 
				 .clear_b(SW[0]),
				 .q(LEDR[5]));
				 
	my_tff C6(.t(Connection[6]), 
				 .clock(KEY[0]), 
				 .clear_b(SW[0]),
				 .q(LEDR[6]));
				 
	my_tff C7(.t(Connection[7]), 
				 .clock(KEY[0]), 
				 .clear_b(SW[0]),
				 .q(LEDR[7]));
				 
	
	//Displaying value of counter in hexadecimal
	hex_display H0(.value(LEDR[3:0]),
						.hex(HEX0[6:0]));
						
	hex_display H1(.value(LEDR[7:4]),
						.hex(HEX1[6:0]));
endmodule

//T flip flop
module my_tff(t, clock, clear_b, q);
	input t;
	input clock;
   input clear_b; 
	output reg q;
	
	always @(posedge clock, negedge clear_b)
	begin
		if (clear_b == 1'b0)
			q <= 0;
		else if (t == 1'b1)
			q <= ~q;
	end
endmodule

//Hex decoder
module hex_display(value, hex);
	input[3:0] value;
	output[6:0] hex;
	
	assign hex[0] = (~value[3] & ~value[2] & ~value[1] & value[0]) | (~value[3] & value[2] & ~value[1] & ~value[0]) | (value[3] & value[2] & ~value[1] & value[0]) | (value[3] & ~value[2] & value[1] &value[0]);
	assign hex[1] = (value[3] & value[1] & value[0]) | (value[2] & value[1] & ~value[0]) | (~value[3] & value[2] & ~value[1] & value[0]) | (value[3] & value[2] & ~value[1] & ~value[0]);
	assign hex[2] = (value[3] & value[2] & value[1]) | (~value[3] & ~value[2] & value[1] & ~value[0]) | (value[3] & value[2] & ~value[1] & ~value[0]);
	assign hex[3] = (value[2] & value[1] & value[0]) | (~value[2] & ~value[1] & value[0]) | (~value[3] & value[1] & value[0]);
	assign hex[5] = (value[3] & value[2] & ~value[1] & value[0]) | (~value[3] & value[1] & value[0]) | (~value[3] & ~value[2] & value[1]) | (~value[3] & ~value[2] & value[0]);
	assign hex[6] = (~value[3] & ~value[2] & ~value[1]) | (value[3] & value[2] & ~value[1] & ~value[0]) | (~value[3] & value[2] & value[1] & value[0]);
		
endmodule