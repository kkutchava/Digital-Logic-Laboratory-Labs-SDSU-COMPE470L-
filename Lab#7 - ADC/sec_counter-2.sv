// Second Counter
module sec_counter #(parameter one_second = 96)( //50000000

	input CLOCK_50,
	input start,
	output C //becomes 1 when 50 000 000 cycles are reached
);

int count = 0;
logic c; // for C

always @(posedge CLOCK_50) begin
	if (start == 1) begin
		count <= count + 1;
		if (count == one_second - 1) begin
			count  <= 0;
			c <= 1;
		end else
			c <= 0;
	end
	else begin 
		c <= 0;
		count <= 0;
	end
end

assign C = c;

endmodule