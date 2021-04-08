module mul2x1
(input sel, [63:0] a, [63:0] b, output [63:0] data_out);
	assign data_out = ({ 63 {~sel} } & a) | ({ 63 {sel} } & b);
endmodule