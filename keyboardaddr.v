

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
	
	//D = idle
	//E = play
	//B = backward
	//F = forward
	//R = reset
	vDFF addrVDFF(clk,nextaddr,currentaddr);
	always_ff @ (posedge clk)
	begin
					case(state)
					default: state<= idleFW;
					idleFW:	//making it so you can only change FW/BW 
							if(R) begin		//reset
								state<=idleFW;
								nextaddr<=1'b0;
								end
							else if(B) begin //backward
								state<=idleBW;
								nextaddr<=currentaddr;	
								end
							else if(E) begin	//start
								state<=FW;
								nextaddr<=currentaddr+1'b1;
								end
							else begin		//keep idle
								state<=idleFW;
								nextaddr<=currentaddr;
								end
					idleBW:
							if(R) begin		//reset
								state<=idleBW;
								nextaddr<=1'b0;
								end
							else if(F) begin		//forward
								state<=idleFW;
								nextaddr<=currentaddr;	
								end
							else if(B) begin		//start backward
								state<=BW;
								nextaddr<=currentaddr+1'b1;
								end
							else begin		//keep idle
								state<=idleBW;
								nextaddr<=currentaddr;
								end

					FW:			
					
							if(currentaddr==32'h7ffff) begin
						nextaddr<=32'b0;
							end
							else if(R) begin		//reset
									state<=FW;
									nextaddr<=32'b0;
								end
								else if(B) begin		//backward
									state<=BW;
									nextaddr<=currentaddr-1'b1;	
								end
								else if(D) begin		//idle
									state<=idleFW;
									nextaddr<=currentaddr;
								end
								else begin		//keep forward
									state<=FW;
									nextaddr<=currentaddr+1'b1;						
								end
					BW:
			if(currentaddr==32'b0) begin
				nextaddr<=32'h7ffff;
				end
							else if(R) begin//reset
								state<=BW;
								nextaddr<=32'h7ffff;
								end
							else if(F) begin		//forward
								state<=FW;
								nextaddr<=currentaddr+1'b1;	
								end
							else if(D) begin		//idle
								state<=idleBW;
								nextaddr<=currentaddr;
								end
							else begin		//keep backward
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
