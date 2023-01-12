module testbench();
	
	
	logic clk = 0;
	logic	[1:0]	key;
	logic	[3:0]	sw;
	logic [7:0] led;

	gcd inst(clk, key, sw, led);

	always begin
		#1 clk = 1;
		#1 clk = 0;
	end
	
	
	initial begin
	//inputting -34
		sw = 13; //1101
		#100;
		key[0] = 1;
		#100;	
		key[0] = 0;
		#100;
		
		sw = 14; //1110
		#100;
		key[0] = 1;
		#100;	
		key[0] = 0;
		#100;
		
	//inputing 17
		sw = 1; //0001
		#100;
		key[0] = 1;
		#100;	
		key[0] = 0;
		#100;
		
		sw = 1; //0001
		#100;
		key[0] = 1;
		#100;	
		key[0] = 0;
		#100;
		
	//reset
		key[1] = 1;
		#100;
		key[1] = 0;
		
		
	//inputting 15
		sw = 0; //0000
		#100;
		key[0] = 1;
		#100;	
		key[0] = 0;
		#100;
		
		sw = 15; //1111
		#100;
		key[0] = 1;
		#100;	
		key[0] = 0;
		#100;
		
	//inputing 25
		sw = 1; //0001
		#100;
		key[0] = 1;
		#100;	
		key[0] = 0;
		#100;
		
		sw = 9; //1001
		#100;
		key[0] = 1;
		#100;	
		key[0] = 0;
		#100;
		
	end

endmodule
