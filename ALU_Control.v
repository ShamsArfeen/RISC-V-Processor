module ALU_Control
(
	input [3:0] Funct,
	input [1:0] ALUOp,
	output reg [3:0] Operation
);

	always @ (*)
	begin
		if (ALUOp == 2'b01)
			Operation= 4'b0110;
		else if (ALUOp == 2'b00)
			Operation = 4'b0010;
		else if (ALUOp == 2'b10 && Funct == 4'b0110)
			Operation = 4'b0001;
		else if (ALUOp == 2'b10 && Funct == 4'b0000)
			Operation = 4'b0010;
		else if (ALUOp == 2'b10 && Funct == 4'b0111)
			Operation = 4'b0000;
		else if (ALUOp == 2'b10 && Funct == 4'b1000)
			Operation = 4'b0110;
	end
endmodule