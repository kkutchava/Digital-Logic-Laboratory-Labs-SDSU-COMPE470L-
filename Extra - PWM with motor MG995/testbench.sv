//testbench
module testbench();



logic clk;
logic	[1:0]	key;
logic [35:0]gpio;

MG995 inst(clk,key,gpio);


//	assign tx =gpio[0];
	always begin
		#1 clk = 1;
		#1 clk = 0;
	end
	
	
	initial begin
		key[0] = 0;
		#20;
		key[0] = 1;
		#10;
		key[0] = 0;
		
		#200;
		key[0] = 1;
		#10;
		key[0] = 0;
		
		#20;
		key[0] = 1;
		#10;
		key[0] = 0;
		
		#200;
		key[0] = 1;
		#10;
		key[0] = 0;
		
		#2000;
		key[1] = 1;
		#10;
		key[1] = 0;
		
		#20;
		key[1] = 1;
		#10;
		key[1] = 0;
		
		#20;
		key[1] = 1;
		#10;
		key[1] = 0;
		
		#20;
		key[1] = 1;
		#10;
		key[1] = 0;
		
		#200;
		key[1] = 1;
		#10;
		key[1] = 0;
		
		#20;
		key[1] = 1;
		#10;
		key[1] = 0;
		
	end

endmodule