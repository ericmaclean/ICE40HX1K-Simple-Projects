	//if A (first switch)is clicked it displays 4 bits that show in the 4 LEDS 
	// if B (second Switch) is cicked it displays its values as well 
	// When S (third switch) is clicked it displayed A or B depending if its in a 0 or 1 state. 0 for A, 1 for B.

	module BinaryLED_Counter
	(input i_Clk,
	input w_Switch1,
	input w_Switch2,
	input w_Switch3,
	input w_Switch4,
	output o_LED_1,
	output o_LED_2,
	output o_LED_3,
	output o_LED_4,
	output [3:0] o_Binary_Count1,
	output [3:0] o_Binary_Count2
	);
	
	
	reg r_LED_1    = 1'b0;
	reg r_Switch_1 = 1'b0;
	reg r_LED_2    = 1'b0;
	reg r_Switch_2 = 1'b0;
	reg r_LED_3    = 1'b0;
	reg r_Switch_3 = 1'b0;
	reg r_LED_4    = 1'b0;
	reg r_Switch_4 = 1'b0;
	reg [3:0] r_BinaryLED_Count = 4'b0000;
	reg [3:0] r_Seg_Count_1 = 4'b0000;
	reg [3:0] r_Seg_Count_2 = 4'b0000;
		
	always @(posedge i_Clk)
	begin
	
		r_Switch_1 <= w_Switch1;
		r_Switch_2 <= w_Switch2;
		r_Switch_3 <= w_Switch3;
		r_Switch_4 <= w_Switch4;
	
		if (w_Switch1 == 1'b1 && r_Switch_1 == 1'b0)
		begin
			if (r_BinaryLED_Count > 4'b1110)
			begin
				r_BinaryLED_Count <= 4'b0000;
				r_Seg_Count_1 <= 4'b0000;
				r_Seg_Count_2 <= 4'b0000;
			end
			else 
			begin
				r_BinaryLED_Count <= r_BinaryLED_Count+1;
				r_Seg_Count_1 <= r_Seg_Count_1 +1;
			end 
			
			if (r_BinaryLED_Count < 4'b1001 || r_BinaryLED_Count > 4'b1110)
			begin 
				r_Seg_Count_2 <= 4'b0000;
			end 
			else 
			begin 
				r_Seg_Count_2 <= 4'b0001;
			end 
			
			if (r_BinaryLED_Count == 4'b1001)
			begin
				r_Seg_Count_1 <= 4'b0000;
			end 
		end
		if(w_Switch3 == 1'b1 && r_Switch_3 == 1'b0)
		begin 
			r_BinaryLED_Count <= 4'b0000;
			r_Seg_Count_1 <= 4'b0000;
			r_Seg_Count_2 <= 4'b0000;
		end 
		
	end 
	assign o_Binary_Count1 = r_Seg_Count_1;
	assign o_Binary_Count2 = r_Seg_Count_2;
	assign o_LED_1 = r_BinaryLED_Count[3];
	assign o_LED_2 = r_BinaryLED_Count[2];
	assign o_LED_3 = r_BinaryLED_Count[1];
	assign o_LED_4 = r_BinaryLED_Count[0];
	
endmodule 