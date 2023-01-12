//////transimtter
module Transmitter(
input CLOCK_50, 
input [3:0]SW, 
input [1:0]KEY, 
output TX
);



logic pre1; //for key press like enter values
logic pre2; //for key press like start Transmition
logic [7:0] data = 0; //output
logic [7:0] a = 0,b = 0; //input nums
logic [10:0] txp = 0; //0 - start bit (0), 1:8 - data bits, 9 - parity bit (even), 10 - end bit (1)
logic tx = 1;
logic step = 0; //00 01 10 11


//for inputing numbers
always @(posedge CLOCK_50) begin
	pre1 <= KEY[0];// for previous key
	
	if (pre1 == 1 && KEY[0] == 0) begin
		if(step == 0) a[7:4] <= SW;
		if(step == 1) a[3:0] <= SW;
		step <= step + 1;
	end
end


typedef enum logic {D,O} state; //D - reciving from switches, O - output
state myState = D;
logic [3:0]counter = 0; //counts 8 bits
logic baud; //when 5208 passes becomes 1
logic rst = 0;
baudCounter inst11845(CLOCK_50, rst, baud);

//FSM
always @(posedge CLOCK_50) begin

					
					
	case(myState)
		D: //reciving state
		begin
			b <= a;
			data <= a;
			pre2 <= KEY[1];
			if (pre2 == 1 && KEY[1] == 0) begin
				myState <= O;
				rst <= 1;
			end
			txp[0] <= 0;
			txp[8:1] <= data;
			txp[9] <= ~^data; //11 -> 0 -> 1 when even -> even parity
			txp[10] <= 1;
			tx <= 1;
		end
		O: //output state
		begin
			tx <= txp[counter];
			if(counter == 11) begin //data output is complete
				myState <= D;
				counter <= 0;
				rst <= 0;
			end
			//c0 ml
			else begin
				if(baud == 1) begin
					counter <= counter + 1;
				end
			end
		end
	endcase
	
end

assign TX = tx;

endmodule