module testbench();


	
	logic adc_CONVST;
	logic adc_SCLK; 
	logic adc_SDI; //output 6 bit - S/D O/S S1 S0 UNI (GND) SLP (set to 0, so no sleep!)
	logic adc_SDO ; //12 bit input
	
	logic clk=1;
	logic [7:0]led; //temp
	logic [11:0] adc_data=12'b110001101111;
	logic [6:1] adc_config;
	integer i=0, j=0;
	logic [35:0]gpio_0;
ADC inst(adc_CONVST,adc_SCLK,adc_SDI,adc_SDO,clk,led,gpio_0);


	always begin
		#10 clk = 0;
		#10 clk = 1;
	end
	
//	
//	initial begin
//		adc_SDO = 1;		
//	end


//	always @(posedge clk) begin
//		adc_SDO = 1;
//	end

	always @(posedge adc_CONVST) begin
		#50 i<=11;
		j <=5;
	end

	always @(negedge adc_SCLK)
	begin
		i <= i-1; 
	end 
	
	assign adc_SDO = adc_data[i];
	
	
	
	always @(posedge adc_SCLK) begin
		if (j>0) j<=j-1;
	end
		
		
	
	always @(posedge adc_SCLK)
	begin
		if(i==0) begin #150 i<=0; j<=1; adc_data = 12'b010010011110; end
	end
	
	



// 1111111111neg

	
	
endmodule
