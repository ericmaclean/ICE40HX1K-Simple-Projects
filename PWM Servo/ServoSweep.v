	module ServoSweep
	(input i_Clk, 
	output o_LED_1, 		//PMOD4 is the topleft data pin on the PMOD
	output io_PMOD_4);		//This MicroServo operates on 20ms PWM cycles 
							//1/25Mhz = 40ns --> 20,000,000ns(20ms)/40ns = 500,000 cycles
	reg [19:0] Counter = 0; //2^19 = 524288 minimum for counting to 500,000
	reg Servo_reg = 0;

	reg [15:0] Control = 0; //need Control Counter to span at least 25,000
	reg Toggle = 1'b1;		//Low Position is 25,000 (1ms) and High position is 50,000 (2ms)

	always @(posedge i_Clk)
	begin 

		Counter <= Counter + 1;
		if(Counter == 'd499999) //Counter is counting up to 20ms by cycling through 0-499,999
			Counter <= 0;
		if(Counter < ('d17000 + Control)) //low position is set by this (1ms = 25,000 @25Mhz)
			Servo_reg <= 1'b1;			  
		else 
			Servo_reg <= 1'b0;
			
		if(Control == 'd45000) //Control is the width of the angle of position 
			Toggle <=0;		   //When set at 25,000 it spans between 1ms-2ms (25-50K)
		if(Control ==0)
			Toggle<=1;
			
		if(Counter == 0)
			begin 
				if(Toggle == 0)
					Control <= Control - 1000; //This controls the rate of the movement, increase to increase the speed.... 
				if(Toggle == 1) 
					Control <= Control + 1000;
			end 




	end 

	assign o_LED_1 = Toggle; 
	assign io_PMOD_4 = Servo_reg;


	endmodule 
