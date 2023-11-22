module MUX4way_Top
	(input i_Clk,
	input  i_Switch_1,
	input 	i_Switch_2,
	input	i_Switch_3,
	input 	i_Switch_4,
	output 	o_LED_1,
	output 	o_LED_2,
	output 	o_LED_3,
	output 	o_LED_4
	);
	parameter N = 4'b1111; // this paramter takes precedence over the N in the MUX4Way2_1 module 

	wire w_Switch_1;
	wire w_Switch_2;
	wire w_Switch_3;
	wire w_Switch_4;
	
	
	
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

	MUX4Way2_1
	#(.N(N))
	(.i_Clk(i_Clk),
	.w_Switch1(w_Switch_1),
	.w_Switch2(w_Switch_2),
	.w_Switch3(w_Switch_3),
	.w_Switch4(w_Switch_4),
	.o_LED_1(o_LED_1),
	.o_LED_2(o_LED_2),
	.o_LED_3(o_LED_3),
	.o_LED_4(o_LED_4));
	
	
endmodule //2_To_1_MUX