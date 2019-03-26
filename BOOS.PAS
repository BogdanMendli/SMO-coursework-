{Implementation of BOOS at the project}
Unit Boos;
Interface

	uses Source1, Source2, Writer, Statist, Bas, Device, graph, crt;
	
	type
		p_Boos = ^BoosObj;
		BoosObj = object
			private

				{instance of class Source1}
				firstSource : p_Source1;
				{instance of class Source2}
				secondSource : p_Source2;
				{instance of class Device}
				dev : p_Device;
				{instance of class Bas}
				basIn : p_Bas;
				{instance of class Statistic}
				stat : p_Statistic;
				{instance of class Writer}
				writerIn : p_Writer;
				{current iteration}
				iteration : longint;
				{time of get the request}
				tpost : array[1..2] of real;
				{long implementation}
				kmin : longint;
				{const values}
				koefStudenta : real;
				accuracyOfEstimationOfProbability : real;

			public

				{initialization the field}
				constructor Init(newFirstSource : p_Source1; newSecondSource : p_Source2;
								 newDev : p_Device; newBasIn : p_Bas;
								 newStat : p_Statistic; newWriterIn : p_Writer;
								 koefStudenta_, accuracyOfEstimationOfProbability_ : real);
				{reset field of class}
				procedure resetField;
				{launch event}
				procedure launchEvent(indGraph : boolean);
				{begin new iteration}
				procedure beginNewIteration(indGraph : boolean);
				{start simulation}
				procedure startSimulation(indGraph : boolean);
				{update kmin}
				procedure updateKmin(it : longint);
				{setter and getter for kmin}
				procedure setKmin(kmin_ : longint);
				function getKmin : longint;
				function getNewKmin(it : longint) : longint;

		end;

Implementation

	constructor BoosObj.Init;
	var
		i : longint;
	begin
		firstSource := newFirstSource;
		secondSource := newSecondSource;
		dev := newDev;
		basIn := newBasIn;
		stat := newStat;
		writerIn := newWriterIn;
		koefStudenta := koefStudenta_;
		accuracyOfEstimationOfProbability := accuracyOfEstimationOfProbability_;
		iteration := 0;
		kmin := 1000;
	end;

	procedure BoosObj.resetField;
	begin
		tpost[1] := 0;
		tpost[1] := firstSource^.tay(tpost[1]);
		tpost[2] := 0;
		tpost[2] := secondSource^.tay(tpost[2]);
		dev^.clearDevice;
	end;

	procedure BoosObj.launchEvent;
	var
		nmin : longint;
		numberOfSource : longint;
		finishedTime: real;
		time: string;
		timeR, newObjectTime: real;
		sNStr, tStr, iStr, help: string;
		prevKol, prevKotk : longint;
	begin
		if tpost[1] < tpost[2] then
			nmin := 1
		else
			nmin := 2;
		str(iteration, iStr);

		if (dev^.getWorking = true) and (dev^.getTosv < tpost[nmin]) then
		begin
			timeR := dev^.getTosv;
			str(timeR:4:3, time);
			dev^.finishWorking(numberOfSource, finishedTime, newObjectTime);

			if newObjectTime <> -1 then
				stat^.newAverageExpectionTime(numberOfSource, iteration, timeR - newObjectTime);
			stat^.incrementKobr(numberOfSource, iteration);

			str(numberOfSource, sNStr);
			str(finishedTime:4:3, tStr);
			{writerIn^.writeMSG(concat('iteration : ', iStr,' time : ', time,' device finished request ', sNStr, ' from ',  tStr));}

			exit;
		end;

		str(nmin, sNStr);
		str(tpost[nmin]:4:3, tStr);

		if ((nmin = 2) and (indGraph) and (iteration = 1)) then
		begin
			prevKol := stat^.getKol(2, iteration);
			prevKotk := stat^.getKotk(2, iteration);
		end;

		case basIn^.createNewRequest(nmin, tpost[nmin], iteration) of
			1:
				begin
					{writerIn^.writeMSG(concat('iteration : ', iStr, ' time :',  tStr,
					' : request from source : ', sNStr, ' was denied'));}
					stat^.incrementKotk(nmin, iteration);

				end;
			2:
				begin
					{str(stat^.getQuantityRequestInBuffer(nmin, iteration), help);
					writerIn^.writeMSG(concat('now quantity for source : ', sNStr, ' is ', help));}
					stat^.incrementQuantityRequestInBuffer(nmin, iteration);
					{writerIn^.writeMSG(concat('iteration : ', iStr, ' time :',
                                        tStr, ' : request from source : ', sNStr, ' was added'));}
				end;
			3:
				begin
					{writerIn^.writeMSG(concat('iteration : ', iStr, ' time : ',
                                        tStr, ' : request from source : ', sNStr,' was passed to device'));}
					stat^.newAverageExpectionTime(nmin, iteration, 0);
					stat^.incrementRequestGoingInstantlyToDevice(nmin, iteration);
				end;
		end;

		case nmin of
			1:
				tpost[1] := firstSource^.tay(tpost[1]);
			2:
				tpost[2] := secondSource^.tay(tpost[2]);
		end;

		stat^.incrementKol(nmin, iteration);

		if ((nmin = 2) and (indGraph) and (iteration = 1)) then
		begin
			setcolor(blue);
			if prevKol > 0 then
				line(42 + round((prevKol / (kmin * 7)) * 550), 418 - round((prevKotk / prevKol) * 360),
				42 + round((stat^.getKol(2, 1) / (kmin * 7)) * 550),
				418 - round((stat^.getKotk(2, 1) / stat^.getKol(2, 1)) * 360))
			else
				line(42, 418, 42 + round((stat^.getKol(2, 1) / (kmin * 7)) * 550),
				418 - round((stat^.getKotk(2, 1) / stat^.getKol(2, 1)) * 360));
		end;
	end;

	procedure BoosObj.beginNewIteration;
	var
		minKol: longint;
		kol: string;
	begin
		repeat
			launchEvent(indGraph);

			if (stat^.getKol(1, iteration) < stat^.getKol(2, iteration)) then
				minKol := stat^.getKol(1, iteration)
			else
				minKol := stat^.getKol(2, iteration);
		until (minKol >= kmin);
	end;

	procedure BoosObj.updateKmin;
	begin
		kmin := round((koefStudenta * (1 - stat^.getProbabilityOfReject(1, it))) /
				(accuracyOfEstimationOfProbability * accuracyOfEstimationOfProbability
				* stat^.getProbabilityOfReject(1, it)));
	end;

	procedure BoosObj.startSimulation;
	begin
		stat^.resetField;

		while (firstSource^.getFinallyLambda - firstSource^.getLambda > -0.005) do
		begin

			inc(iteration);

			writerIn^.preIterationMSG(stat, iteration, firstSource^.getLambda, kmin);
			
			resetField;

			beginNewIteration(indGraph);

			writerIn^.IterationMSG(stat, iteration);

			firstSource^.updateLambda;
		end;

		iteration := 0;
		firstSource^.setLambda(0.5);
		firstSource^.setFinallyLambda(1.5);
	end;

	procedure BoosObj.setKmin;
	begin
		kmin := kmin_;
	end;

	function BoosObj.getKmin;
	begin
		getKmin := kmin;
	end;

	function BoosObj.getNewKmin;
	begin
		getNewKmin := round((koefStudenta * (1 - stat^.getProbabilityOfReject(1, it))) /
				(accuracyOfEstimationOfProbability * accuracyOfEstimationOfProbability
				* stat^.getProbabilityOfReject(1, it)));;
	end;
	
BEGIN
END.