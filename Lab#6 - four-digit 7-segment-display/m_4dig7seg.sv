module m_4dig7seg(


	input CLOCK_50,
	input	[1:0]	KEY,
	output [35:0]GPIO_0
);


logic [13:0] counter =0, counter_prev = 0;
logic start1 = 0, start2 = 1;  
logic [15:0] decOut = 0; //1010 -> 0001 0000
logic done = 0;
logic dig1 = 0, dig2 = 0, dig3 = 0, dig4 = 0;

logic pre1; //for key press like enter values
logic pre2; //for key press like start Transmition
logic [1:0] STEP = 0; //00 01 10 11
logic [6:0] segments [9:0];
//assign segments[0] = 7'b0111111;
//assign segments[1] = 7'b0110000;
//assign segments[2] = 7'b1101101;
//assign segments[3] = 7'b1111001;
//assign segments[4] = 7'b0110011;
//assign segments[5] = 7'b1011011;
//assign segments[6] = 7'b1011111;
//assign segments[7] = 7'b1110000;
//assign segments[8] = 7'b1111111;
//assign segments[9] = 7'b1111011;
assign segments[0] = 7'b0111111;
assign segments[1] = 7'b0000110;
assign segments[2] = 7'b1011011;
assign segments[3] = 7'b1001111;
assign segments[4] = 7'b1100110;
assign segments[5] = 7'b1101101;
assign segments[6] = 7'b1111101;
assign segments[7] = 7'b0000111;
assign segments[8] = 7'b1111111;
assign segments[9] = 7'b1101111;


assign GPIO_0[7] = dig1;
assign GPIO_0[8] = dig2;
assign GPIO_0[9] = dig3;
assign GPIO_0[10] = dig4;

logic [6:0] DIGSEGM;

logic sec;

sec_counter #(50000000) inst1(CLOCK_50, start2, sec); //50000000  #(one_second = 500)

logic sec1;
sec_counter #(200000) inst2 (CLOCK_50, 1, sec1); //200000   #(one_second = 2)


//Binary_to_BCD inst(CLOCK_50, counter, start1, decOut, done);

Binary_To_BCD1 inst(counter, decOut);

always @(posedge CLOCK_50) begin

//	
//	//start1 <= 0;
//	counter_prev <= counter;
//	
//	if (counter != counter_prev)
//		begin
//			start1 <= 1;
//		end	



	pre1 <= KEY[0];// for previous key
	
	if (pre1 == 1 && KEY[0] == 0) begin
		counter <= 0;
	end
	
	pre2 <= KEY[1];// for previous key
	
	if (pre2 == 1 && KEY[1] == 0) begin
		start2 <= ~start2;
	end
	
	else if (sec == 1) begin
		counter <= counter + 1;
	end
	
	if (counter == 9999) begin
		counter <= 0;
	end
	//     gpio    sevseg
	//A -- 0     	11
	//B -- 1 		7
	//C -- 2     	4
	//D -- 3  		2  
	//E -- 4   		1
	//F -- 5  		10
	//G -- 6  		5
	//dig1 7 		12   	//step 00
	//dig2 8  		9		//step 01 
	//dig3 9   		8 		//step 10
	//dig4 10   	6		//step 11
	if (sec1 == 1) STEP <= STEP + 1;
	
		if (STEP == 0) begin //00
		 dig1 <= 0;
		 dig2 <= 0;
		 dig3 <= 0;
		 dig4 <= 1;
		 DIGSEGM <= ~segments[decOut[3:0]];
		end
		
		if (STEP == 1) begin //01
		 dig1 <= 0;
		 dig2 <= 0;
		 dig3 <= 1;
		 dig4 <= 0;
		 DIGSEGM <= ~segments[decOut[7:4]];
		end
		
		if (STEP == 2) begin //10
		 dig1 <= 0;
		 dig2 <=  1;
		 dig3 <= 0;
		 dig4 <= 0;
		 DIGSEGM <= ~segments[decOut[11:8]];
		end
		
		if (STEP == 3) begin //11
		 dig1 <= 1;
		 dig2 <= 0;
		 dig3 <= 0;
		 dig4 <= 0;
		 DIGSEGM <= ~segments[decOut[15:12]];
//		 STEP <= 0;
		end


end

assign GPIO_0[6:0] = DIGSEGM;


endmodule