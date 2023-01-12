module testbench();
	
	
	logic clk = 0;
	logic [3:0]sw=0; 
	logic [1:0]key=3; 
	logic [7:0]led; 
	logic [35:0]gpio; 
	logic tx ; 

//	lab5 inst(clk,sw,key,led,{TX, RX});
Transmitter inst(clk, sw, key, tx);
Receiver inst1(clk, tx, led);


//	assign tx =gpio[0];
	always begin
		#1 clk = 1;
		#1 clk = 0;
	end
	
	
	initial begin
		#100 sw = 10; #100; key[0] = 0; #100; key[0] = 1;
		#100 sw = 7; #100; key[0] = 0; #100; key[0] = 1;
		#100; key[1] = 0; #100; key[1] = 1;
		
		#100 sw = 4'b0011; #100; key[0] = 0; #100; key[0] = 1;
		#100 sw = 4'b1100; #100; key[0] = 0; #100; key[0] = 1;
		#100; key[1] = 0; #100; key[1] = 1;
		
	end

endmodule
