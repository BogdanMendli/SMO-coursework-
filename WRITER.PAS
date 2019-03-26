{Implementation for writer}
Unit Writer;
Interface

	uses Statist;

	type 
		p_Writer = ^WriterObj;
		WriterObj = object
			private
			
				{name for file text}
				output: text;
				{path to our file}
				path : string;
			public
			
				{initialization the field}
				constructor Init;
				{closing file}
				destructor Done;
				{send message}
				procedure writeMSG (msg: string);
				{send message about preitertion}
				procedure preIterationMSG (stat : p_Statistic; iteration: longint; lambda: real; kmin : longint);
				{send message about iteration}
				procedure IterationMSG (stat : p_Statistic; iteration: longint);
				{send message about average quantity of request in Buffer}
				procedure averageQuantityOfRequestInBufferMSG(stat : p_Statistic);
				{reset file}
				procedure resetFile;
				
		end;
		
Implementation

	constructor WriterObj.Init;
	begin
		path := 'output.txt';
		assign(output, path);
		rewrite(output);
	end;
	
	destructor WriterObj.Done;
	begin
		close(output);
	end;

	procedure WriterObj.writeMSG;
	begin
		writeln(output, msg);
	end;

	procedure WriterObj.preIterationMSG;
	var
		help : string;
	begin
		writeMSG(' ');
		str(iteration, help);
		writeMSG(concat('Beginning iteration ', help));
		str((round (lambda * 10)) / 10:0:2, help);
		writeMSG(concat('lambda = ', help));
		str(kmin, help);
		writeMSG(concat('kmin = ', help));
		writeMSG(' ');
		writeMSG('*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-');
	end;

	procedure WriterObj.IterationMSG;
	var
		help : string;
	begin
		writeMSG('#################################################################################');
		writeMSG(' ');
		str(stat^.getKol(1, iteration), help);
		writeMSG(concat('kol for first source = ', help));
		str(stat^.getKobr(1, iteration), help);
		writeMSG(concat('kobr for first source = ', help));
		str(stat^.getKotk(1, iteration), help);
		writeMSG(concat('kotk for first source = ', help));

		str(stat^.getKol(2, iteration), help);
		writeMSG(concat('kol for second source = ', help));
		str(stat^.getKobr(2, iteration), help);
		writeMSG(concat('kobr for second source = ', help));
		str(stat^.getKotk(2, iteration), help);
		writeMSG(concat('kotk for second source = ', help));

		stat^.calculateProbabilityOfReject(iteration);

		str(stat^.getProbabilityOfReject(1, iteration):0:2, help);
		writeMSG(concat('P for first source = ', help));
		str(stat^.getProbabilityOfReject(2, iteration):0:2, help);
		writeMSG(concat('P for second source = ', help));

		str(stat^.getAverageExpectionTime(1, iteration):4:3, help);
		writeMSG(concat('M for first source = ', help));
		str(stat^.getAverageExpectionTime(2, iteration):4:3, help);
		writeMSG(concat('M for second source = ', help));
		str(stat^.getCommonAvExpTime(iteration):4:3, help);
		writeMSG(concat('Common M = ', help));
		
		str(stat^.getQuantityRequestInBuffer(1, iteration), help);
		writeMSG(concat('Quantity of request in buffer for first source = ', help));
		str(stat^.getQuantityRequestInBuffer(2, iteration), help);
		writeMSG(concat('Quantity of request in buffer for second source = ', help));
		
		writeMSG(' ');
		writeMSG('#################################################################################');
	end;
	
	procedure WriterObj.averageQuantityOfRequestInBufferMSG;
        var
                help : string;
	begin
		writeMSG(' ');
		str(stat^.getAverageQuantityRequestInBuffer(1), help);
		writeMSG(concat('Average quantity of request in Buffer for first source = ', help));
		str(stat^.getAverageQuantityRequestInBuffer(2), help);
		writeMSG(concat('Average quantity of request in Buffer for second source = ', help));
	end;
	
	procedure WriterObj.resetFile;
	begin
		rewrite(output);
	end;

BEGIN
END.