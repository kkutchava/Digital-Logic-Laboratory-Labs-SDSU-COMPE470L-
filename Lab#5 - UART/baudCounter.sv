//////////baud counter
module baudCounter #(parameter one_second = 434)(//5208)(
	
	input CLOCK_50,
	input rst,
	output C //becomes 1 when 5208 cycles are reached
);

int count;
logic c; // for C


logic count_half, rst_prev;


//we need 9600 number of 5208 cycles to reach 50*10^6
always @(negedge CLOCK_50) begin
	rst_prev <= rst;

	if (!rst_prev & rst) 
		count_half <= 1;
	
	
	if (rst == 1) begin
		count <= count + 1;
			
		if (count == one_second - 1) begin
			count  <= 0;
			c <= 1;
		end else
			c <= 0;
		
		if (count_half && count == one_second/2 ) begin
			count  <= 0;
			count_half <= 0;
			c <= 1;
		end 
		
	end
	else count = 0;
	
	
	
end

assign C = c;

endmodule