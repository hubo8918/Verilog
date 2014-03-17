module cruise_tb();

reg clk,reset,throttle,set,accel,coast,cancel,resume,brake;
wire [7:0] speed, speedset;
wire cruisecontrol;

initial begin
	clk=1;
	reset=0;
	throttle=0;
	set=0;
	accel=0;
	coast=0;
	cancel=0;
	resume=0;
	brake=0;
	#5 reset=1;
	#10 reset=0;
	#10 throttle=1;
	#300 set=1;
	#10 set=0;
	#10 throttle=0;
	#120 throttle=1;
	#300 set=1;
	#10 set=0;
	#90 throttle=0;
	#150 brake=1;
	#10 brake=0;
	#90 resume=1;
	#10 resume=0;
	#240 accel=1;
	#50 accel=0;
	#10 coast=1;
	#50 coast=0;
	#10 cancel=1;
	#520 
	$finish;
end

always begin
	#5 clk=~clk;
end

cruise cruise01(speedset, cruisecontrol, speed, clk, reset, throttle, set, accel, coast, cancel, resume, brake);


endmodule
