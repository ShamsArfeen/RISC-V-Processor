module Data_Memory
(
	input [63:0] Mem_Addr, Write_Data,
	input MemWrite, MemRead, clk,
	output reg [63:0] Read_Data
);

	reg [7:0] memory [63:0];
	
	integer r;
	
	initial
		begin
			for (r = 0; r < 64; r = r + 1) 
				memory[r] = 13;
		end

	always @ (posedge clk)
	begin
		if (MemWrite)
		begin
			memory[Mem_Addr] = Write_Data[7:0];
			memory[Mem_Addr+1] = Write_Data[15:8];
			memory[Mem_Addr+2] = Write_Data[23:16];
			memory[Mem_Addr+3] = Write_Data[31:24];
			memory[Mem_Addr+4] = Write_Data[39:32];
			memory[Mem_Addr+5] = Write_Data[47:40];
			memory[Mem_Addr+6] = Write_Data[55:48];
			memory[Mem_Addr+7] = Write_Data[63:56];
			//$display("writting Mem complete! mem_addr = ", Mem_Addr, " data = ", memory[Mem_Addr]);
		end
		if (MemRead)
		begin
			Read_Data = {memory[Mem_Addr+7], memory[Mem_Addr+6], memory[Mem_Addr+5], memory[Mem_Addr+4], memory[Mem_Addr+3], memory[Mem_Addr+2], memory[Mem_Addr+1], memory[Mem_Addr]};
			//$display("reading Mem complete! mem_addr = ", Mem_Addr, " data = ", Read_Data);
		end
	end
endmodule
