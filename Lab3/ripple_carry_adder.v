module ripple_carry_adder(LEDR,SW);
	input [9:0] SW;
	output [9:0] LEDR;
	wire c1;
	wire c2;
	wire c3;
	
	full_adder b0(
		.sum(LEDR[0]),
		.cout(c1),
		.a(SW[4]),
		.b(SW[0]),
		.cin(SW[8])
	);
	
	full_adder b1(
		.sum(LEDR[1]),
		.cout(c2),
		.a(SW[5]),
		.b(SW[1]),
		.cin(c1)
	);
	
	full_adder b2(
		.sum(LEDR[2]),
		.cout(c3),
		.a(SW[6]),
		.b(SW[2]),
		.cin(c2)
	);
	
	full_adder b3(
		.sum(LEDR[3]),
		.cout(LEDR[4]),
		.a(SW[7]),
		.b(SW[3]),
		.cin(c3)
	);
	
endmodule

module full_adder(sum,cout,a,b,cin);
	output sum, cout;
	input a, b, cin;
	
	assign sum = a^b^cin;
	assign cout = (a&b)|(cin&(a^b));

endmodule