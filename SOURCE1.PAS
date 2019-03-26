{Imlementation of Source1}
Unit Source1;
Interface

	type 
		p_Source1 = ^Source1Obj;
		Source1Obj = object
			private
			
				{data for 1 source}
				lambda : real;
				deltaLambda : real;
				finallyLambda : real;
				
			public
			
				{initialization the field}
				constructor Init;
				{random value of tay}
				function tay(tpost : real) : real;
				{getter for lambda}
				function getLambda : real;
				{getter for delta lambda}
				function getDeltaLambda : real;
				{getter for finally Lambda}
				function getFinallyLambda : real;
				{change lambda}
				procedure updateLambda;
				{setters for field}
				procedure setLambda(lambda_ : real);
				procedure setDeltaLambda(deltaLambda_ : real);
				procedure setFinallyLambda(finallyLambda_ : real);
		end;
		
Implementation

	constructor Source1Obj.Init;
	begin
		lambda := 0.5;
		deltaLambda := 0.1;
		finallyLambda := 1.5;
	end;

	function Source1Obj.tay;
	begin
		tay := tpost - (ln(random) / lambda );
	end;
	
	function Source1Obj.getLambda;
	begin
		getLambda := lambda;
	end;
	
	function Source1Obj.getDeltaLambda;
	begin
		getDeltaLambda := deltaLambda;
	end;
	
	function Source1Obj.getFinallyLambda;
	begin
		getFinallyLambda := finallyLambda;
	end;
	
	procedure Source1Obj.updateLambda;
	begin
		lambda := lambda + deltaLambda;
	end;
	
	procedure Source1Obj.setLambda;
	begin
		lambda := lambda_;
	end;
	
	procedure Source1Obj.setDeltaLambda;
	begin
		deltaLambda := deltaLambda_;
	end;
	
	procedure Source1Obj.setFinallyLambda;
	begin
		finallyLambda := finallyLambda_;
	end;
	
BEGIN
END.