module RISC_V_Processor
(
input clk, reset
);
	wire [63:0] PC_In;
	wire [63:0] PC_Out;
	wire [63:0] PC_Out_buffer;

	wire [31:0] Ins;
	wire [31:0] Ins_buffer;
	
	wire [63:0] adj_ins;
	wire [63:0] branch_address;
	wire [6:0] opcode;
	wire [4:0] rd;
 	wire [2:0] funct3;
 	wire [4:0] rs1;
 	wire [4:0] rs2;
 	wire [6:0] funct7;
	wire [63:0] writedata;
	wire [63:0] readdata1;
    wire [63:0] readdata2;
	wire [63:0] readdata;
	wire [1:0] aluop;
	wire branch, memread, memtoreg, memwrite, alusrc, regwrite;
	wire [63:0] val_a;
	wire [63:0] val_b;
	wire [63:0] result;
	wire zero;
	wire [3:0] operation;
	wire [63:0] imm_shift;
	wire is_branch;
	wire [63:0] imm64;
	
	assign is_branch = zero && branch;
	assign val_a = readdata1;

	Program_Counter pc
	(
		.clk(clk), 
		.reset(reset), 
		.PC_In(PC_In), 
		.PC_Out(PC_Out)
	);

	Instruction_Memory im
	(
		.Inst_Address(PC_Out),
		.Instruction(Ins)
	);

	IFID buffer1
	(
		.clk(clk),
		.pc_buffer_in(PC_Out),
		.instruction_buffer_in(Ins),
		.instruction_buffer_out(Ins_buffer),
		.pc_buffer_out(PC_Out_buffer)
	);

	adder64 add1
	(
		.a(PC_Out_buffer),
		.b(64'd4),
		.sum(adj_ins)
	);

	adder64 add2
	(
		.a(PC_Out_buffer),
		.b(imm64),
		.sum(branch_address)
	);

	parser ins_parser
	(	
		.ins(Ins_buffer),
		.opcode(opcode),
		.rd(rd),
		.funct3(funct3),
		.rs1(rs1),
		.rs2(rs2),
		.funct7(funct7)
	);

	registerFile reg_file
	(
		.rs1(rs1),
		.rs2(rs2),
		.rd(rd),
		.WriteData(writedata),
		.ReadData1(readdata1),
		.ReadData2(readdata2),
		.clk(clk),
		.reset(reset),
		.RegWrite(regwrite)
	);

	control_unit cu
	(
		.Opcode(opcode),
		.ALUOp(aluop),
		.Branch(branch),
		.MemRead(memread),
		.MemtoReg(memtoreg),
		.MemWrite(memwrite),
		.ALUSrc(alusrc),
		.RegWrite(regwrite)
	);

	imm_gen Imm_Gen
	(
		.ins(Ins_buffer),
		.imm_data(imm64)
	);

	ALU_Control alu_con
	(
		.Funct( {Ins_buffer[30], Ins_buffer[14], Ins_buffer[13], Ins_buffer[12]} ),
		.ALUOp(aluop),
		.Operation(operation)
	);

	mul2x1 mux1
	(
		.sel(alusrc),
		.a(readdata2),
		.b(imm64),
		.data_out(val_b)
	);
	
	mul2x1 mux3
	(
		.sel(memtoreg),
		.a(result),
		.b(readdata),
		.data_out(writedata)
	);

	alu_64bit_mul ALU
	(
		.a(val_a),
		.b(val_b),
		.aluop(operation),
		.res(result),
		.zero(zero)
	);

	mul2x1 mux2
	(
		.sel(is_branch),
		.a(adj_ins),
		.b(branch_address),
		.data_out(PC_In)
	);

	Data_Memory data_mem
	(
		.Mem_Addr(result),
		.Write_Data(readdata2),
		.MemWrite(memwrite),
		.MemRead(memread),
		.clk(clk),
		.Read_Data(readdata)
	);
		
	always @(posedge clk) 
		begin
			$monitor("PC_In = ", PC_In, ", PC_Out = ", PC_Out, ", Instruction = %b", Ins_buffer,
			", Opcode = %b", opcode, ", Funct3 = %b", funct3, ", rs1 = %d", rs1, ", rs2 = %d",
			rs2, ", rd = %d", rd);/*, ", funct7 = %b", funct7, ", ALUOp = %b", aluop, 
			", imm_value = ", imm64, ", Operation = %b", operation, ", val_a = ", 
			val_a, ", val_b = ", val_b, ", result = ", result, ", alusrc = %b", alusrc,
			" RegWrite = ", regwrite, " MemtoReg = ", memtoreg, " MemRead = ", 
			memread, " readdata = ", readdata, " is_branch = ", is_branch, " zero = ", zero,
			" ReadData1 = ", readdata1, " ReadData2 = ", readdata2);*/
		end
endmodule	