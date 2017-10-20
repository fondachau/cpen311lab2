module keyintegration(clk,freq,variable,newfreq,keys);
	input logic clk;
	input logic [31:0] freq;
	input logic [2:0] keys;
	
	logic [31:0] variable;
	
	output logic [31:0] newfreq;

	always_ff @(posedge clk)
		//if( less than 50MHz)
		if(keys[2]) begin
			variable<=0;
		end
		else if(keys[1]) begin
			variable<=variable+32'd500
		end
		else if(keys[0]) begin
			variable<=variable-32'd500;
		end
		else begin
			variable<=variable;
			
		end
	end
assign newfreq = freq + variable;
endmodule