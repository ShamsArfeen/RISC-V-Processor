module alu_64bit_mul
( input [63:0] a, [63:0] b, [3:0] aluop, output [63:0] res, output zero);
	wire  andr,orr,addr,subr,norr;
	assign andrr = ~aluop[3]&&~aluop[2]&&~aluop[1]&&~aluop[0];
	assign orr = ~aluop[3]&&~aluop[2]&&~aluop[1]&&aluop[0];
	assign addr = ~aluop[3]&&~aluop[2]&&aluop[1]&&~aluop[0];
	assign subr = ~aluop[3]&&aluop[2]&&aluop[1]&&~aluop[0];
	assign norr = aluop[3]&&aluop[2]&&~aluop[1]&&~aluop[0];
	
	wire [63:0] res1;
	wire [63:0] res2;
	wire [63:0] res3;
	wire [63:0] res4;
	assign res1 = {63{andrr}} & (a & b);
	assign res2 = res1 | {63{orr}} & (a | b);
	assign res3 = res2 | {63{addr}} & (a + b);
	assign res4 = res3 | {63{subr}} & (a - b);
	assign res = res4 | {63{norr}} & ~(a | b);
	assign zero = ~(|res);
endmodule