`define MANU 2'b00
`define AUTO 2'b01
`define BRAKE 2'b10
module cruise(
	speedset,
	cruisecontrol,
	speed,
	clk,
	reset,
	throttle,
	set,
	accel,
	coast,
	cancel,
	resume,
	brake
    );
input clk, reset,throttle,set,accel,coast,cancel,resume,brake;
output reg cruisecontrol;
output reg [7:0] speed,speedset;
reg [1:0] state, nextstate;
reg [7:0] cruisespeed;
always@(posedge clk)
begin
	if(reset==1'b1)
		begin
			nextstate<=`MANU;
			speed<=0;
		end
	else
		state<=nextstate;
end
always@(posedge clk)
begin
	case(state)
		`MANU:
			begin
				cruisecontrol<=1'b0;
				if(throttle==1)
					speed<=speed+1;
				else
					speed<=speed-1;
				if(set==1 && speed>45)
					begin
						speedset<=speed;
						nextstate<=`AUTO;
					end
				else if(resume==1 && speed>0)
					begin
						speedset<=cruisespeed;
						nextstate<=`AUTO;
					end
				else if(brake==1)
					begin
						speed<=speed-2;
						nextstate<=`BRAKE;
					end
			end
		`AUTO:
			begin
				cruisecontrol<=1'b1;
				if(throttle==1)
					begin
						speed<=speed+1;						
					end
				else if(speed>speedset)
					begin
						speed<=speed-1;
					end
				else if(speed<speedset)
					begin
						speed<=speed+1;
					end
				if(cancel==1)
					begin
						nextstate<=`MANU;
						cruisespeed<=speedset;
					end
				if(brake==1)
					begin
						nextstate<=`BRAKE;
						cruisespeed<=speedset;
					end
				if(accel==1)
						speedset<=speedset+1;
				else if( coast==1)
						speedset<=speedset-1;
			end
		`BRAKE:
			begin
				cruisecontrol<=1'b0;
				speed<=speed-2;
				if(set==1 && speed>45)
					begin
						nextstate<=`AUTO;
						speedset<=speed;
					end
				else if(resume==1 && speed>0)
					begin
						nextstate<=`AUTO;
						speedset<=cruisespeed;
					end
				if(throttle==1)
					begin
						nextstate<=`MANU;
						speed<=speed+1;
					end
			end
	endcase
end
endmodule
