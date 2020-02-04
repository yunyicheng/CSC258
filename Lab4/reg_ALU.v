module reg_ALU(SW, KEY, LEDR, HEX0, HEX4, HEX5);

	input [9:0] SW; // SW[3:0] Data(A) input;SW[9] reset_n input;SW[7:5] ALU_function input
	input [2:0] KEY; // KEY[0] clock input
	output [7:0]LEDR; //ALUout
	output [6:0]HEX0; //Displays value of Data(A)
	
	output [6:0]HEX4; // least-significant four bits of Register in hexadeciaml
	output [6:0]HEX5; //most-significant four bits of Register in hexadecimal
	reg [7:0] out; //Temporary output variables, 4 bits each, will combine to make 8 bit output
	wire [4:0] case0, case1; // Includes carry digit
	
	always @(posedge KEY[0])
			begin
				if (SW[9] == 1'b0)
					out <= 0;
				else
					case (SW[7:5])
						3'b000: begin //Case 0
							out <= {3'b000, case0[4:0]};
						end						
						3'b001: begin //Case 1
							out <= {3'b000, case1[4:0]};
						end					
						3'b010: begin //Case 2
							out <= {4'b0000, SW[3:0] + out[3:0]};
						end					
						3'b011: begin //Case 3
							out <= {SW[3:0] | out[3:0], SW[3:0] ^ out[3:0]};
						end						
						3'b100: begin //Case 4
							out <= {7'b0000000,|(SW[3:0] | out[3:0])};
						end						
						3'b101: begin //Case 5
							out <= out[3:0] << SW[3:0];
						end	
						3'b110: begin //Case 6
							out <= out[3:0] >> SW[3:0];
						end
						3'b111: begin //Case 7
							out <= out[3:0] * SW[3:0];
						end		
						default: begin // Default case
							out <= {8'b00000000};
						end
					endcase
			end
			
	assign LEDR[7:0] = out;
	
	//Case 0
	four_full_adder case_0(
		//Adds 1 to Data(A)
			.a(SW[3:0]),
			.b(4'b0001),
			.s(case0)
		);
		
	//Case 1
	four_full_adder case_1(
		//Adds A to B
		.a(SW[3:0]),
		.b(out),
		.s(case1)
	);
			
	//DISPLAYING Data(A)
	seven_seg_decoder H0(
		.bits(SW[3:0]),
		.hex(HEX0[6:0])
	);
	
	//HEX4 AND HEX5
	seven_seg_decoder H4(
		.bits(out[3:0]),
		.hex(HEX4[6:0])
	);
	
	seven_seg_decoder H5(
		.bits(out[7:4]),
		.hex(HEX5[6:0])
	);	
 endmodule

//Full adder module
module four_full_adder(s, a, b);
	input [3:0] a;
	input [3:0] b;
	output [4:0] s;
	wire connection1; //Declare a wire for connection
	wire connection2; //Declare another wire for connection
	wire connection3;
	
	//Block 1
	full_adder block1(
		.A(a[0]),
		.B(b[0]),
		.cin(1'b0), 
		.S(s[0]),
		.cout(connection1)
	);
	
	//Block 2
	full_adder block2(
		.A(a[1]),
		.B(b[1]),
		.cin(connection1), 
		.S(s[1]),
		.cout(connection2)
	);
	
	//Block 3
	full_adder block3(
		.A(a[2]),
		.B(b[2]),
		.cin(connection2), 
		.S(s[2]),
		.cout(connection3)
	);
	
	//Block 4
	full_adder block4(
		.A(a[3]),
		.B(b[3]),
		.cin(connection3), 
		.S(s[3]),
		.cout(s[4])
	);
endmodule


//Full adder sub circuit
module full_adder(S, cout, A, B, cin);
	input A, B, cin;
	output S, cout;
	
	assign S = A^B^cin;
	assign cout = (A&B) | (cin & (A^B));
endmodule


// Verilog adder for case 2
module verilog_adder(s, a, b);
	input [3:0] a;
	input [3:0] b;
	output [4:0] s;
	
	assign s[4:0] = a + b;

endmodule

//Seven augment decoder for inputs from 0-F (Hexadecimal)
module seven_seg_decoder(bits, hex);
	input [3:0]bits; //4 inputs, represents bits
	output [6:0]hex; //hex display decoder
	
	assign hex[0] = (~bits[3] & ~bits[2] & ~bits[1] & bits[0]) | (~bits[3] & bits[2] & ~bits[1] & ~bits[0]) | (bits[3] & bits[2] & ~bits[1] & bits[0]) | (bits[3] & ~bits[2] & bits[1] & bits[0]);
	assign hex[1] = (bits[3] & bits[1] & bits[0]) | (bits[2] & bits[1] & ~bits[0]) | (~bits[3] & bits[2] & ~bits[1] & bits[0]) | (bits[3] & bits[2] & ~bits[1] & ~bits[0]);
	assign hex[2] = (bits[3] & bits[2] & bits[1]) | (~bits[3] & ~bits[2] & bits[1] & ~bits[0]) | (bits[3] & bits[2] & ~bits[1] & ~bits[0]);
	assign hex[3] = (bits[2] & bits[1] & bits[0]) | (~bits[2] & ~bits[1] & bits[0]) | (~bits[3] & bits[2] & ~bits[1] & ~bits[0]) | (bits[3] & ~bits[2] & bits[1] & ~bits[0]);
	assign hex[4] = (~bits[3] & bits[2] & ~bits[1]) | (~bits[2] & ~bits[1] & bits[0]) | (~bits[3] & bits[1] & bits[0]);
	assign hex[5] = (bits[3] & bits[2] & ~bits[1] & bits[0]) | (~bits[3] & bits[1] & bits[0]) | (~bits[3] & ~bits[2] & bits[1]) | (~bits[3] & ~bits[2] & bits[0]);
	assign hex[6] = (~bits[3] & ~bits[2] & ~bits[1]) | (bits[3] & bits[2] & ~bits[1] & ~bits[0]) | (~bits[3] & bits[2] & bits[1] & bits[0]);
	
endmodule
