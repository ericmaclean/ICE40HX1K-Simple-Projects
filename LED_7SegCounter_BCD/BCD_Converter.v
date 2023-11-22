module BCD_Converter
(input i_Clk,
input [3:0] i_Binary_Num, 
output [3:0] o_BCD1,
output [3:0] o_BCD2);


localparam CLEAR	= 3'b000;
localparam SHIFT3	= 3'b001;
localparam ADD3		= 3'b010;
localparam SHIFT1	= 3'b011;
localparam LOAD		= 3'b100;
reg [3:0] r_SM_Main = 0;
reg [11:0] Z = 0;
reg [7:0]  P = 0;
reg	r_enable;



always @(posedge i_Clk)
begin 
	case (r_SM_Main)
	CLEAR: 
	begin 
		r_enable <= 1'b0;
		r_SM_Main <= SHIFT3;
	end 
	SHIFT3: 
	begin 
		Z[6:3] <= i_Binary_Num[3:0];
		r_SM_Main <= ADD3;
	end 
	ADD3: 
	begin 
		if (Z[6:4] > 4'b0100)
		begin 
			Z[7:4] <= Z[7:4] + 4'b0011;
			r_SM_Main <= SHIFT1;
		end 
		else 
			r_SM_Main <= SHIFT1;
	end 
	SHIFT1: 
	begin 
		Z[8:4] <= Z[7:3];
		r_enable <= 1'b1;
		r_SM_Main <= LOAD;
	end 
	LOAD:
	begin 
		if(r_enable == 1'b1)
		begin 
			P[7:0] <= Z[11:4];
		end
		if (i_Binary_Num == 4'b1000)
			P[7:4] <= 4'b0000;
		if (i_Binary_Num == 4'b1001)
			P[7:4] <= 4'b0000;
		r_SM_Main <= CLEAR;
	end 
	endcase
end 


assign o_BCD1 = P[3:0];
assign o_BCD2 = P[7:4];
endmodule 

