module tb
();
	reg clk, reset;
	
	RISC_V_Processor cycle(.clk(clk),.reset(reset));

	initial begin
		clk = 0;
		reset = 1;
		#6
		reset = 0;
	end

	always begin
		#5
		clk = ~clk;
		end

endmodule