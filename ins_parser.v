module parser
(input [31:0] ins, output [6:0] opcode,
 [4:0] rd,
 [2:0] funct3,
 [4:0] rs1,
 [4:0] rs2,
 [6:0] funct7);
	assign opcode = ins[6:0];
	assign rd = ins[11:7];
	assign funct3 = ins[14:12];
	assign rs1 = ins[19:15];
	assign rs2 = ins[24:20];
	assign funct7 = ins[31:25];
endmodule