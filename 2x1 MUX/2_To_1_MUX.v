module MUX_2_To_1
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
	
	reg r_LED_1    = 1'b0;
	reg r_Switch_1 = 1'b0;
	reg r_LED_2    = 1'b0;
	reg r_Switch_2 = 1'b0;
	reg r_LED_3    = 1'b0;
	reg r_Switch_3 = 1'b0;
	reg r_LED_4    = 1'b0;
	reg r_Switch_4 = 1'b0;
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

	
	always @(posedge i_Clk)
	begin
	
		r_Switch_1 <= w_Switch_1;
		r_Switch_2 <= w_Switch_2;
		r_Switch_3 <= w_Switch_3;
		r_Switch_4 <= w_Switch_4;
	
		if (w_Switch_1 == 1'b1 && r_Switch_1 == 1'b0)
		begin
			r_LED_1 <= ~r_LED_1;
		end 
		if (w_Switch_2 == 1'b1 && r_Switch_2 == 1'b0)
		begin
			r_LED_2 <= ~r_LED_2;
		end 
		if (w_Switch_3 == 1'b1 && r_Switch_3 == 1'b0)
		begin
			r_LED_3 <= ~r_LED_3;
		end 
	
	
	end 
	
assign o_LED_1 = r_LED_1;
assign o_LED_2 = r_LED_2;
assign o_LED_3 = r_LED_3;
assign o_LED_4 = r_LED_3 ? r_LED_2 : r_LED_1;
	
endmodule //2_To_1_MUX