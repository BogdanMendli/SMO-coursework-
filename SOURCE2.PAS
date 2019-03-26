{Implementation for Source2}
Unit Source2;
Interface

	type
	
		p_Source2 = ^Source2Obj;
		Source2Obj = object
			private
			
				{constants for source2}
				tay1, tay2 : real;
				
			public 
			
				{initialization the field}
				constructor Init;
				{getters for tay1 and tay2}
				function getTay1 : real;
				function getTay2 : real;
				{random value of tay}
				function tay(tpost : real) : real;
				{setters for field}
				procedure setTay1(tay1_ : real);
				procedure setTay2(tay2_ : real);
		end;
		
Implementation
	
	constructor Source2Obj.Init;
	begin
		tay1 := 0.1;
		tay2 := 0.5;
	end;
	
	function Source2Obj.getTay1;
	begin
		getTay1 := tay1;
	end;
	
	function Source2Obj.getTay2;
	begin
		getTay2 := tay2;
	end;
	
	function Source2Obj.tay;
	begin
		tay := tpost + tay1 + (tay2 - tay1) * random;
	end;
	
	procedure Source2Obj.setTay1;
	begin
		tay1 := tay1_;
	end;
	
	procedure Source2Obj.setTay2;
	begin
		tay2 := tay2_;
	end;

BEGIN
END.