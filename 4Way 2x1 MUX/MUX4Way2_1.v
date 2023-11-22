	//if A (first switch)is clicked it displays 4 bits that show in the 4 LEDS 
	// if B (second Switch) is cicked it displays its values as well 
	// When S (third switch) is clicked it displayed A or B depending if its in a 0 or 1 state. 0 for A, 1 for B.
	
	
	module MUX4Way2_1
	#(parameter N = 4'b1000)
	(input i_Clk,
	input w_Switch1,
	input w_Switch2,
	input w_Switch3,
	input w_Switch4,
	output o_LED_1,
	output o_LED_2,
	output o_LED_3,
	output o_LED_4);
	
	
	reg r_LED_1    = 1'b0;
	reg r_Switch_1 = 1'b0;
	reg r_LED_2    = 1'b0;
	reg r_Switch_2 = 1'b0;
	reg r_LED_3    = 1'b0;
	reg r_Switch_3 = 1'b0;
	reg r_LED_4    = 1'b0;
	reg r_Switch_4 = 1'b0;
	reg [3:0] A	   = N;
	reg [3:0] B    = 4'b0001;
	
		
	always @(posedge i_Clk)
	begin
	
		r_Switch_1 <= w_Switch1;
		r_Switch_2 <= w_Switch2;
		r_Switch_3 <= w_Switch3;
		r_Switch_4 <= w_Switch4;
	
		if (w_Switch1 == 1'b1 && r_Switch_1 == 1'b0)
		begin
			r_LED_1 <= A[0];
			r_LED_2 <= A[1];
			r_LED_3 <= A[2];
			r_LED_4 <= A[3];
		end 
		if (w_Switch2 == 1'b1 && r_Switch_2 == 1'b0)
		begin
			r_LED_1 <= B[0];
			r_LED_2 <= B[1];
			r_LED_3 <= B[2];
			r_LED_4 <= B[3];
		end 
		if (w_Switch3 == 1'b1 && r_Switch_3 == 1'b0)
		begin
			r_LED_3 <= ~r_LED_3;
			if(r_LED_3 == 1'b0)
			begin
			r_LED_1 <= A[0];
			r_LED_2 <= A[1];
			r_LED_3 <= A[2];
			r_LED_4 <= A[3];
			end 
			else 
			begin
			r_LED_1 <= B[0];
			r_LED_2 <= B[1];
			r_LED_3 <= B[2];
			r_LED_4 <= B[3];
			end
		end 
	
	
	end 
	
	assign o_LED_1 = r_LED_1;
	assign o_LED_2 = r_LED_2;
	assign o_LED_3 = r_LED_3;
	assign o_LED_4 = r_LED_4;
	
	endmodule 