module testbench ();
   logic clk;
	logic [35:0] gpio;
	
	
	
	always begin
		#10 clk = 0;
		#10 clk = 1;
	end
	
	
	VGA inst(clk, gpio);


endmodule