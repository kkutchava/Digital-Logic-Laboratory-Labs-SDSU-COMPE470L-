//testbench
module testbench();



logic clk;
logic	[1:0]	key;
logic [35:0]gpio;

m_4dig7seg inst(clk,key,gpio);


//	assign tx =gpio[0];
	always begin
		#1 clk = 1;
		#1 clk = 0;
	end
	
	
	initial begin
		
		
	end

endmodule