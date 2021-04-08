module registerFile
(
	input [4:0] rs1, rs2, rd,
	input [63:0] WriteData,
	output reg [63:0] ReadData1, ReadData2,
	input clk, reset, RegWrite
);

	reg [5:0] i;
	reg [63:0] Registers [31:0];
	initial
	begin
		for(i=0; i<32; i=i+1)
			Registers[i] = 0;
		Registers[1] = 1;
		Registers[2] = 2;
		Registers[3] = 5;
		Registers[10] = 7;
	end
	
	always @ (posedge clk, reset)
		begin

		ReadData1 = Registers[rs1];
		ReadData2 = Registers[rs2];
			if (RegWrite)
				begin
					Registers[rd] = WriteData;
				end
			if (reset)
				begin
					ReadData1 = 0;
					ReadData2 = 0;
				end
		end
endmodule