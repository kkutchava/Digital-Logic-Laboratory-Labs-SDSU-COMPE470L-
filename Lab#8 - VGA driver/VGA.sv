module VGA(
	input CLOCK_50,
	output [35:0]GPIO_0 //3.18v ==> 4.54
);

//logic counter_Hz = 833;

logic red = 0, green = 0, blue = 0, HS = 1, VS = 1; //for gpio 0, 1, 2, 3, 4,
logic [12:0] counterH = 0, counterV = 0; //H - 1688, V - 1066
// H - 1280 + 48 + 112 +248
// V - 1024 + 1 + 3 + 38


logic clk_108;

	powergirlspll_0002 powergirlspll_inst (
		.refclk   (CLOCK_50),   //  refclk.clk
		.rst      (0),      //   reset.reset
		.outclk_0 (clk_108), // outclk0.clk
		.locked   ()          // (terminated)
	);
	
	
always @(posedge clk_108) begin

	if (counterH < 1687) begin
		counterH <= counterH + 1;
	end
	
	else begin
		counterH <= 0;
	end
	
	if (counterH == 1687) begin
		counterV <= counterV + 1;
		
		if (counterV < 1065) counterV <= counterV + 1;
		else counterV <= 0;
		
	end
	
	
	//For horizontal sync signal
   if (counterH >= 1327 && counterH < 1439) HS <= 0;
	else HS <= 1;
	
	
	//For verticle sync signal
	if (counterV >= 1024 && counterV < 1027) VS <= 0;
	else VS <= 1;
	
	
	// now show 14
	
	if ((counterH >= 400 && counterH < 600 && counterV >=200 && counterV <300) 
	|| (counterH >= 700 && counterH < 900 && counterV >=200 && counterV <300)
	|| (counterH >= 300 && counterH < 1000 && counterV >=300 && counterV <600) 
	|| (counterH >= 400 && counterH < 900 && counterV >=600 && counterV <700)
	|| (counterH >= 500 && counterH < 800 && counterV >=700 && counterV <800)
	|| (counterH >= 600 && counterH < 700 && counterV >=800 && counterV <900))
	begin
		red <= 1;
		green <= 1;
		blue <= 1;
	end
	

	
	
	else begin
		red <= 0;
		green <= 0;
		blue <= 0;
	end
	
end


assign GPIO_0[0] = HS;
assign GPIO_0[1] = VS;
assign GPIO_0[2] = red;
assign GPIO_0[3] = green;
assign GPIO_0[4] = blue;


endmodule