module gcd(

	input CLOCK_50,
	input	[1:0]	KEY, //like enter
	input	[3:0]	SW, //for a and b
	output[7:0] LED //output

);

logic pre1; //for key press like enter
logic pre2; //for key press like reset
logic [7:0] led = 0; //output
logic [7:0] a = 0,b = 0; //inputs
logic [1:0] step = 0; //00 01 10 11

always @(posedge CLOCK_50) begin
	pre1 <= KEY[0];// for previous key
	pre2 <= KEY[1];
	
	
	if (pre2 == 1 && KEY[1] == 0) begin
		a = 0;
		b = 0;
		led = 0;
		step = 0;
	end
	
	
	
	//input values for a and b
	if (pre1 == 1 && KEY[0] == 0) begin
		if(step == 2'b00) a[7:4] = SW;
		if(step == 2'b01) a[3:0] = SW;
		if(step == 2'b10) b[7:4] = SW;
		if(step == 2'b11) b[3:0] = SW;
		step = step + 1;
	end
	
	//15 - 0000 1111    25 - 0001 1001
	// a = 15 b = 25
	//15 10
	//5 10
	//5 5
	//5 0
	if(step == 0) begin
	
		
		
		//in case they are negative, i will make them positive ;d
		if(b[7] == 1) begin
			b = ~b + 1;
		end
		if(a[7] == 1) begin
			a = ~a + 1;
		end
		
		
		
		if(b == 0) begin
			  led <= a;
		end
		else if(a>b) begin
			a <= a-b;
		end
		else begin
			b <= b-a;
		end
	end
	
	
end

assign LED = led;

endmodule