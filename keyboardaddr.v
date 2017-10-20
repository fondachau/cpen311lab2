module keyboardaddr (currentaddr,clk, state, D, E, B, F, R,nextaddr);
	input logic [31:0]  currentaddr;
	input logic D, E, B, F, R;
	output logic [1:0] state;
	input logic clk;
	output logic [31:0] nextaddr;
	//output logic [1:0] nextstate;
	
	parameter idleFW = 2'b00;
	parameter idleBW = 2'b01;
	parameter FW = 2'b10;
	parameter BW = 2'b11;
	
	vDFF addrVDFF(clk,nextaddr,currentaddr);
	always_ff @ (posedge clk)
		begin
			case(state)
			default: state<= idleFW;
			idleFW:	//making it so you can only change FW/BW 
					if(R) begin
						state<=idleFW;
						nextaddr<=1'b0;
						end
					else if(E) begin
						state<=FW;
						nextaddr<=currentaddr+1'b1;
						end
					else begin
						state<=idleFW;
						nextaddr<=currentaddr;
						end
			idleBW:
					if(R) begin
						state<=idleBW;
						nextaddr<=1'b0;
						end
					else if(E) begin
						state<=BW;
						nextaddr<=currentaddr+1'b1;
						end
					else begin
						state<=idleBW;
						nextaddr<=currentaddr;
						end

			FW:			if(R) begin
							state<=FW;
							nextaddr<=1'b0;
						end
						else if(D) begin
							state<=idleFW;
							nextaddr<=currentaddr;
						end
						else begin
							state<=FW;
							nextaddr<=currentaddr+1'b1;						
						end
			BW:
					if(R) begin
						state<=BW;
						nextaddr<=1'b0;
						end
					else if(D) begin
						state<=idleBW;
						nextaddr<=currentaddr;
						end
					else begin
						state<=BW;
						nextaddr<=currentaddr-1'b1;
						end
		endcase
	end
endmodule

module vDFF(clk, in, out);
	input logic clk;
	input logic [31:0] in;

	output logic [31:0] out;

	always_ff @(posedge clk)
		out<=in;
endmodule
