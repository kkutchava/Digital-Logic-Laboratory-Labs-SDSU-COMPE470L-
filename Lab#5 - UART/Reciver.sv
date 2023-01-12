 ///////////////////Reciver
module Receiver(
input CLOCK_50, 
input RX,
output [7:0]LED
);


logic baud; //when 5208 passes becomes 1 like MY clock
logic rst = 0; //starts 9600clk when key[1] is pressed
baudCounter inst11845(CLOCK_50, rst, baud);
logic [3:0]counter = 0; //counts 11 bits (0 to B)
logic [11:0]data;

always @(posedge CLOCK_50) begin

	
	if (RX == 0) begin
		rst <= 1; //start MY counting
	end
	
	
	if (baud) begin 
		counter <= counter + 1;
		data[counter] <= RX;
	end
	
	
	if (counter == 11) begin
		rst <= 0;
		counter <= 0;
	end
	//if(~^data[7:0] == data[8]) data[7:0] <= 8'b00100001;
end

assign LED = data[8:1];


endmodule