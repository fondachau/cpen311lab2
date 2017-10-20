module fsm_tb;
	logic CLK_50M;
	logic [31:0] flash_mem_readdata;
	logic flash_mem_readdatavalid;
	logic reset;
	logic newclock1;
	logic direction;
	logic idle;
	
	wire flash_mem_read;
	wire flash_mem_byteenable;
	wire [15:0] audiodata;
	wire [6:0] state;

fsm dut(
CLK_50M,
audiodata,
flash_mem_readdata,
flash_mem_readdatavalid,
reset,
direction,
state,
newclock1,
flash_mem_read,
idle,
out,
flash_mem_byteenable
);
	
	initial begin
		CLK_50M = 0; #5;
		forever begin
			CLK_50M=1; #5;
			CLK_50M=0; #5;
		end
	end
	
	initial begin
		newclock1 = 0; #5;
		forever begin
			newclock1=1; #10;
			newclock1=0; #10;
		end
	end
	
	initial begin
		direction=1; //going backward
		reset=0;
		idle=1;
		flash_mem_readdatavalid=1;
		#20;
	end
endmodule