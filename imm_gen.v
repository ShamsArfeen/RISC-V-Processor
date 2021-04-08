module imm_gen
(input [31:0] ins, output [63:0] imm_data);
	wire [6:0] opcode;
	assign opcode = ins[6:0];
	wire [11:0] imm1, imm2, imm3;
	wire i, i2, s, b;
	assign i = &(~(opcode ^ 7'b0000011));
	assign i2 = &(~(opcode ^ 7'b0010011));
	assign s = &(~(opcode ^ 7'b0100011));
	assign b = &(~(opcode ^ 7'b1100011));
	
	assign imm1 = ( { 64{i} } & { 52'b0, ins[31:20] } );
	assign imm2 = imm1 | ({64{i2}} & {52'b0, ins[31:20]});
	assign imm3 = imm2 | ({64{s}} & {52'b0, ins[31:25], ins[11:7]});
	assign imm_data = imm3 | ({64{b}} & {51'b0, ins[31], ins[7], ins[30:25], ins[11:8], 1'b0});
	
	/*
	always @(imm_data)
		begin
			$display("imm64 = ", imm_data);
		end
	*/
endmodule
