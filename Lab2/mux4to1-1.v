//SW[2:0] data inputs
//SW[9] select signal

//LEDR[0] output display

module mux(LEDR, SW);
    input [9:0] SW;
    output [9:0] LEDR;
	 wire uv;
	 wire wx;
    mux2to1 uov(// Choose between u and v
        .in1(SW[0]),
        .in2(SW[1]),
        .s(SW[4]),
        .out(uv)
        );
	 mux2to1 wox(// Choose between w and x
        .in1(SW[2]),
        .in2(SW[3]),
        .s(SW[4]),
        .out(wx)
        ); 
	 mux2to1 final(// Choose between uv and wx
        .in1(uv),
        .in2(wx),
        .s(SW[5]),
        .out(LEDR[9])
        ); 
endmodule

module mux2to1(in1, in2, s, out);
    input in1; //selected when s is 0
    input in2; //selected when s is 1
    input s; //select signal
    output out; //output
  
    assign out = s & in2 | ~s & in1;
    // OR
    // assign m = s ? y : x;
endmodule