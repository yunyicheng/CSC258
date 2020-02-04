//SW[2:0] data inputs
//SW[9] select signal

//LEDR[0] output display

module mux(LEDR, SW);
    input [3:0] SW;
    output [6:0] HEX0;

    H0 u0(
        .x0(SW[0]),
        .x1(SW[1]),
        .x2(SW[2]),
		  .x3(SW[3]),
        .h0(HEX0[0])
        );
		  
	 H1 u1(
        .x0(SW[0]),
        .x1(SW[1]),
        .x2(SW[2]),
		  .x3(SW[3]),
        .h1(HEX0[1])
        );
		  
	 H2 u2(
        .x0(SW[0]),
        .x1(SW[1]),
        .x2(SW[2]),
		  .x3(SW[3]),
        .h2(HEX0[2])
        );
		  
	 H3 u3(
        .x0(SW[0]),
        .x1(SW[1]),
        .x2(SW[2]),
		  .x3(SW[3]),
        .h3(HEX0[3])
        );
	
    H4 u4(
        .x0(SW[0]),
        .x1(SW[1]),
        .x2(SW[2]),
		  .x3(SW[3]),
        .h4(HEX0[4])
        );
		 
	 H5 u5(
        .x0(SW[0]),
        .x1(SW[1]),
        .x2(SW[2]),
		  .x3(SW[3]),
        .h5(HEX0[5])
        ); 
		  
	 H6 u6(
        .x0(SW[0]),
        .x1(SW[1]),
        .x2(SW[2]),
		  .x3(SW[3]),
        .h6(HEX0[6])
        );  
endmodule

module H0(x3, x2, x1, x0, h0);
    input x3;
	 input x2; 
	 input x1;
	 input x0;
	 output h0;
  
    assign h0 = (~x3 & ~x2 & ~x1 & x0) | (~x3 & x2 & ~x1 & ~x0) | (x3 & x2 & ~x1 & x0) | (x3 & ~x2 & x1 & x0);

endmodule

module H1(x3, x2, x1, x0, h1);
    input x3;
	 input x2; 
	 input x1;
	 input x0;
	 output h1;
  
    assign h1 = (x3 & x2 & ~x1 & ~x0) | (~x3 & x2 & ~x1 & x0) | (x3 & x1 & x0) | (x2 & x1 & ~x0);

endmodule

module H2(x3, x2, x1, x0, h2);
    input x3;
	 input x2; 
	 input x1;
	 input x0;
	 output h2;
  
    assign h2 = (~x3 & ~x2 & x1 & ~x0) | (x3 & x2 & ~x0) | (x3 & x2 & x1);

endmodule

module H3(x3, x2, x1, x0, h3);
    input x3;
	 input x2; 
	 input x1;
	 input x0;
	 output h3;
  
    assign h3 = (~x3 & ~x2 & ~x1 & x0) | (~x3 & x2 & ~x1 & ~x0) | (x2 & x1 & x0) | (x3 & ~x2 & x1 & ~x0);

endmodule

module H4(x3, x2, x1, x0, h4);
    input x3;
	 input x2; 
	 input x1;
	 input x0;
	 output h4;
  
    assign h4 = (~x3 & x0) | (~x3 & x2 & ~x1) | (~x2 & ~x1 & x0);

endmodule

module H5(x3, x2, x1, x0, h5);
    input x3;
	 input x2; 
	 input x1;
	 input x0;
	 output h5;
  
    assign h5 = (~x3 & ~x2 & x0) | (~x3 & ~x2 & x1) | (~x3 & x1 & x0) | (x3 & x2 & ~x1 & x0);

endmodule

module H6(x3, x2, x1, x0, h6);
    input x3;
	 input x2; 
	 input x1;
	 input x0;
	 output h6;
  
    assign h6 = (~x3 & ~x2 & ~x1) | (~x3 & x2 & x1 & x0) | (x3 & x2 & ~x1 & ~x0);

endmodule