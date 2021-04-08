module Program_Counter
(input clk, reset,
input [63:0] PC_In,
output reg [63:0] PC_Out);

	initial
	PC_Out = 0;
	
	always @(posedge clk)
		begin
			PC_Out = PC_In;
			if (reset == 1)
				PC_Out = 0;
		end
endmodule