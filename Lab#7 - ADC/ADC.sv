
module ADC(



	output ADC_CONVST, //keep high for 40ns
	output ADC_SCLK, //clock 25 MHz 
	output ADC_SDI, //output 6 bit - S/D O/S S1 S0 UNI (GND) SLP (set to 0, so no sleep!)
	input ADC_SDO, //12 bit input
	
	input CLOCK_50,
	output [7:0]LED, //temp
	output [35:0]GPIO_0 //for 4dig7seg
);



logic [11:0] adc_sdo = 0, adc_data_full =0, rev_bits = 0; //for inputs in parallel
logic adc_convst = 0, adc_sclk = 0, adc_sdi= 0;
logic [7:0] led = 0; //for testing
logic clk25MHz, start = 0;
sec_counter #(2)inst(CLOCK_50, start, clk25MHz);
sec_counter #(108)inst1(CLOCK_50, 1, adc_convst);
logic [35:0]gpio_0;

//one cycle 1.92 micros = == 2 micro Sec

//strat CONVST for 40ns, mean wait 2 clk before going down
//then wait min 70 clk
//start sending to ADC_SCLK signal.. 25 MHz (use caouner)
//in parellel start sending to ADC_SDI 6 bits
//in parellel start receving ADC_SDO input 12 bit
//for testing output first 8 bits on the led


logic [7:0] step = 0; //to count 96 - every cycle
//100000
logic[5:0] confVal= 6'b000001; //confuguration value ==> 0 channel !!! reads from right to left <--

logic [3:0]countto12 = 0;
//logic [3:0]countto12neg = 0;

//logic [13:0] toDisplay = 0; //to give to the m digit 4 7 segment

//assign toDisplay[11:0] = adc_sdo;
m_4dig7seg inst45436({2'b00, adc_data_full},CLOCK_50,gpio_0);


always @(posedge CLOCK_50) begin
	
	step <= step + 1;
	if (adc_convst == 1) begin //whe
		step <= 1;
		start <= 0;
		adc_sdo <= 0;
	end
	
	
	
	if (step == 70) begin
		start <= 1;
		
	end
	
	if (step == 72) begin
		
		countto12 <= countto12 + 1;
	end
	if (step == 95) begin
		start <= 0;
	end
	if (step == 96) begin
		adc_data_full <= adc_sdo;
	end
	
	
	
	
	if (clk25MHz == 0 && step > 73 && step < 96) countto12 <= countto12 + 1;
//	if (step > 70 && step < 84) countto12neg <= countto12neg + 2;
//	if (countto12neg == 12) countto12neg <= 0;
	if (countto12 == 12) countto12 <= 0;
	
	if (countto12 < 6 && step > 67 && step < 84) begin
		adc_sdi <= confVal[countto12];
	end
	
	
	
	if (clk25MHz == 1 && countto12 - 1 < 12) begin
		adc_sdo[13-countto12] <= ADC_SDO;
	end
		
	
end

always @(negedge CLOCK_50) begin
	
	
//  11-10-9-8-7-6-5-4-3-2-1-0- 
//   0  0 0 0 0 0 0 0 0 0 0 0 
//   0  1                   0
end
//assign rev_bits[11:0] = adc_data_full[0:11];
assign ADC_CONVST = adc_convst;
//assign ADC_SCLK = adc_sc lk;
assign ADC_SCLK = clk25MHz;
assign ADC_SDI = adc_sdi;
assign LED = adc_data_full[7:0];
assign GPIO_0 = gpio_0;

endmodule