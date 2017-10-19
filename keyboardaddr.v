module keyboardaddr (currentaddr, state, nextstate, D, E, B, F, R,nextaddr);
	input logic [31:0]  currentaddr;
	input logic D, E, B, F, R;
	input logic [1:0] state;
	output logic [31:0] nextaddr;
	output logic [1:0] nextstate;
	
	parameter idleFW = 2'b00;
	parameter idleBW = 2'b01;
	parameter FW = 2'b10;
	parameter BW = 2'b11;
	
	always_ff @ (currentaddr) //going to check which buttons are pressed after mem is accessed and played note?
		begin
			case(state)
			default: nextstate<= FW;
			idleFW:	//making it so you can only change FW/BW 
					if(R) begin
						nextstate<=idleFW;
						nextaddr<=1'b0;
					else if(E) begin
						nextstate<=FW;
						nextaddr<=currentaddr+1'b1;
						end
					else begin
						nextstate<=idleFW;
						nextaddr<=currentaddr;
						end
			idleBW:
					if(R) begin
						nextstate<=idleBW;
						nextaddr<=1'b0;
					else if(E) begin
						nextstate<=BW;
						nextaddr<=currentaddr+1'b1;
						end
					else begin
						nextstate<=idleBW;
						nextaddr<=currentaddr;
						end
			FW:
					if(R) begin
						nextstate<=FW;
						nextaddr<=1'b0;
					else if(D) begin
						nextstate<=idleFW;
						nextaddr<=currentaddr;
						end
					else begin
						nextstate<=FW;
						nextaddr<=currentaddr+1'b1;						
						end
			BW:
					if(R) begin
						nextstate<=BW;
						nextaddr<=1'b0;
					else if(D) begin
						nextstate<=idleBW;
						nextaddr<=currentaddr;
						end
					else begin
						nextstate<=BW;
						nextaddr<=currentaddr+1'b1;
						end
		endcase
	end
endmodule
