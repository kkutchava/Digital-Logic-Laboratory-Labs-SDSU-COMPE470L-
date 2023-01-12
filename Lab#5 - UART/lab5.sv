module lab5(
	input CLOCK_50,
	input	[3:0]SW,
	input	[1:0]KEY,
	output [7:0]LED,
	inout [35:0]GPIO_0 //1 - transmitter (yellow), 0 - reciver (orange)

);

Transmitter inst(CLOCK_50, SW, KEY, GPIO_0[0]);
Receiver inst1(CLOCK_50, GPIO_0[1], LED);  


endmodule