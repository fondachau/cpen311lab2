module keyboardaddr_tb;
	logic [31:0]  currentaddr;
	logic D, E, B, F, R;
	wire [1:0] state;
	logic clk;
	
	wire idle;
	wire [31:0] nextaddr;
	wire [1:0] nextstate;

	keyboardaddr dut(currentaddr, D, E, B, F, R, state, clk, idle, nextaddr);

	parameter idleFW = 2'b00;
	parameter idleBW = 2'b01;
	parameter FW = 2'b10;
	parameter BW = 2'b11;

	initial begin
		clk = 0; #5;
		forever begin
			clk=1; #5;
			clk=0; #5;
		end
	end

	initial begin
		D=0;E=0;B=0;F=0;R=0;
		currentaddr=0;
		#20;
		E=1;		//play forward (default)
		#20;
		E=0; R=1;	//reset
		#20;
		R=0; D=1;	//idle
		#20;
		D=0; E=1; B=1; //play backward
		#20;
		E=0; B=0; D=0; //idle bw state
	end
endmodule