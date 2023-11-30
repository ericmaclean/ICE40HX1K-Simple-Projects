	module Servo_Open_Close
	(input i_Clk, 
	input i_Switch_1,
	input i_Switch_2,
	input i_Switch_3,
	input i_Switch_4,
	output o_LED_1, 		
	output o_LED_2,
	output o_LED_3,
	output o_LED_4,			
	output io_PMOD_10);		//This MicroServo operates on 20ms PWM cycles 
							//1/25Mhz = 40ns --> 20,000,000ns(20ms)/40ns = 500,000 cycles
	reg [19:0] Counter = 0; //2^19 = 524288 minimum for counting to 500,000
	reg Servo_reg = 0;

	
	wire w_Switch_1;
	wire w_Switch_2;
	wire w_Switch_3;
	wire w_Switch_4;
	reg r_Switch_1;
	reg r_Switch_2;
	reg r_Switch_3;
	reg r_Switch_4;
	reg r_LED_1;
	reg r_LED_2;
	reg r_LED_3;
	reg r_LED_4;
	
	localparam IDLE = 2'b00;
	localparam UP 	= 2'b01;
	localparam DOWN = 2'b10;
	
	reg [2:0] r_SM_Main = 2'b00;
	
	Debounce_Switch Switch_1
	(.i_Clk(i_Clk),
	.i_Switch(i_Switch_1),
	.o_Switch(w_Switch_1));
	
	Debounce_Switch Switch_2
	(.i_Clk(i_Clk),
	.i_Switch(i_Switch_2),
	.o_Switch(w_Switch_2));
	
	Debounce_Switch Switch_3
	(.i_Clk(i_Clk),
	.i_Switch(i_Switch_3),
	.o_Switch(w_Switch_3));
	
	Debounce_Switch Switch_4
	(.i_Clk(i_Clk),
	.i_Switch(i_Switch_4),
	.o_Switch(w_Switch_4));

	always @(posedge i_Clk)
	begin 
		r_Switch_1 <= w_Switch_1;
		r_Switch_2 <= w_Switch_2;
		r_Switch_3 <= w_Switch_3;
		r_Switch_4 <= w_Switch_4;
		
		case (r_SM_Main)
			IDLE: 
			begin 
				r_LED_1 <= 1'b0;
				r_LED_2 <= 1'b0;
				r_LED_3 <= 1'b0;
				r_LED_4 <= 1'b0;
				
				Counter <= Counter + 1;
				if(Counter == 'd499999) //Counter is counting up to 20ms by cycling through 0-499,999
					Counter <= 0;
				if(Counter < 'd39500) //mid position is set by this (1.58ms = 39,500 @25Mhz)
					Servo_reg <= 1'b1;			  
				else 
					Servo_reg <= 1'b0;
					
				if (w_Switch_1 == 1'b1 && r_Switch_1 == 1'b0)
					r_SM_Main <= UP;
				else if (w_Switch_2 == 1'b1 && r_Switch_2 == 1'b0)
					r_SM_Main <= DOWN;
				else 
					r_SM_Main <= IDLE;
			end
			UP: 
			begin 
				r_LED_1 <= 1'b1;
				r_LED_2 <= 1'b0;
				r_LED_3 <= 1'b0;
				r_LED_4 <= 1'b0;
				
				Counter <= Counter + 1;
				if(Counter == 'd499999) //Counter is counting up to 20ms by cycling through 0-499,999
					Counter <= 0;
				if(Counter < 'd62000) //high position is set by this (2.48ms = 62,000 @25Mhz)
					Servo_reg <= 1'b1;			  
				else 
					Servo_reg <= 1'b0;
				
				if (w_Switch_2 == 1'b1 && r_Switch_2 == 1'b0)
					r_SM_Main <= DOWN;
				else if (w_Switch_3 == 1'b1 && r_Switch_3 == 1'b0)
					r_SM_Main <= IDLE;
				else if (w_Switch_4 == 1'b1 && r_Switch_4 == 1'b0)
					r_SM_Main <= IDLE;
				else 
					r_SM_Main <= UP;	
			end
			DOWN: 
			begin 
				r_LED_1 <= 1'b0;
				r_LED_2 <= 1'b1;
				r_LED_3 <= 1'b0;
				r_LED_4 <= 1'b0;
				
				Counter <= Counter + 1;
				if(Counter == 'd499999) //Counter is counting up to 20ms by cycling through 0-499,999
					Counter <= 0;
				if(Counter < 'd17000) //low position is set by this (.68ms = 17,000 @25Mhz)
					Servo_reg <= 1'b1;			  
				else 
					Servo_reg <= 1'b0;
					
				if (w_Switch_1 == 1'b1 && r_Switch_1 == 1'b0)
					r_SM_Main <= UP;
				else if (w_Switch_3 == 1'b1 && r_Switch_3 == 1'b0)
					r_SM_Main <= IDLE;
				else if (w_Switch_4 == 1'b1 && r_Switch_4 == 1'b0)
					r_SM_Main <= IDLE;
				else 
					r_SM_Main <= DOWN;	
			end
		endcase  
	end 

	assign o_LED_1 = r_LED_1;
	assign o_LED_2 = r_LED_2;
	assign o_LED_3 = r_LED_3;
	assign o_LED_4 = r_LED_4;
	assign io_PMOD_10 = Servo_reg;


	endmodule 