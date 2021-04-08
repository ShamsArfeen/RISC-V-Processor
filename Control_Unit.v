module control_unit
(
	input [6:0] Opcode,
	output reg [1:0] ALUOp,
	output reg Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite
);

	always @ (*)
	begin
		case(Opcode)
			7'b0000011 : begin
							//$display("MemRead Opcode = %b", Opcode);
							Branch = 0;
							MemRead = 1;
							MemtoReg = 1;
							ALUOp = 00;
							MemWrite = 0;
							ALUSrc = 1;
							RegWrite = 1;
			end
			7'b0110011 : begin
							//$display("RegWrite Opcode = %b", Opcode);
							Branch = 0;
							MemRead = 0;
							MemtoReg = 0;
							ALUOp = 10;
							MemWrite = 0;
							ALUSrc = 0;
							RegWrite = 1;
			end
			7'b1100011 : begin
							//$display("Branch Opcode = %b", Opcode);
							Branch = 1;
							MemRead = 0;
							ALUOp = 01;
							MemWrite = 0;
							ALUSrc = 0;
							RegWrite = 0;
			end
			7'b0100011 : begin
							//$display("MemWrite Opcode = %b", Opcode);
							Branch = 0;
							MemRead = 0;
							ALUOp = 00;
							MemWrite = 1;
							ALUSrc = 1;
							RegWrite = 0;
			end
		endcase
	end
			
endmodule