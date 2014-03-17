/*****************************************************************
 Design Name 	: dff_tb
 File Name 	: dff_tb.v
 Function	: Testbench code for D-Flip-flop module 
******************************************************************/

module dff_tb();

// Input signal declaration
reg clk, reset, d;

// Code starts here
initial begin
	clk = 1;
	reset = 0;
	d = 0;

	// Invoking reset signal
	#5 reset = 1;
	#15 reset = 0;

	// Providing input signals to D-FF
	#7 d = 1;
	#17 d = 0;
end

// Clock generation
always begin
	#5 clk =~clk;
end

// Instance
dff dff_1(clk, reset, d, q);

endmodule // End of dff_tb

