module MG995(


	input CLOCK_50,
	input	[1:0]	KEY, //key0 - increase angle, key1 - decrease angle
	output [35:0]GPIO_0 //for PWM signal
);
	//for 50mghz
	//full cycle 1000000
	//0 angle - 25000
	//90 angle - 75000
	//180 angle - 125000
	
	//9 angle - 50 000 clks
	
	
	logic pre1; //for key press like enter values
	logic pre2; //for key press like start Transmition
	
	logic sec;
	sec_counter #(1000000) inst1(CLOCK_50, 1, sec); //1000000
	
	logic [17:0] angle = 25000; //18 bits //25000
	logic pwm = 1;
	

	logic [17:0] counter = 25000; //25000
	
	
	always @(posedge CLOCK_50) begin

		pre1 <= KEY[0];// for previous key
		
		if (pre1 == 1 && KEY[0] == 0) begin
			//increase duty cycle
			if (angle < 125000) //125000
				angle <= angle + 5000; //5000
		end
		
		
		pre2 <= KEY[1];// for previous key
		
		if (pre2 == 1 && KEY[1] == 0) begin
			//decrease duty cycle
			if (angle > 25000)
				angle <= angle - 5000; //5000
		end
		
		
		counter <= counter + 1;
		if (sec == 1) begin
			counter <= 0;
			pwm <= 1;
		end
		
		if (counter == angle) begin
			pwm <= 0;
		end
	
	end
	
	assign GPIO_0[0] = pwm;
	
endmodule

