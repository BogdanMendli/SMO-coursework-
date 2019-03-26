{Implementation for class Statistic which write in file our statistics}
Unit Statist;
Interface

	const _NUMBER_OF_ITERATION_ = 11;

	type
		p_Statistic = ^StatisticObj;
		StatisticObj = object
		private

			{quantity request of source for everyone _NUMBER_OF_ITERATION_}
			kol : array[1..2,1.._NUMBER_OF_ITERATION_] of longint;
			{quantity requst of source have processed for everyone _NUMBER_OF_ITERATION_}
			kobr : array[1..2,1.._NUMBER_OF_ITERATION_] of longint;
			{quantity request of source have got reject for everyone _NUMBER_OF_ITERATION_}
			kotk : array[1..2,1.._NUMBER_OF_ITERATION_] of longint;
			{probability of reject}
			probabilityOfReject : array[1..2,0.._NUMBER_OF_ITERATION_] of real;
			{common probability Of Reject}
			commonProbabilityOfReject : array[0.._NUMBER_OF_ITERATION_] of real;
			{counter quantity of request sent in buffer}
			quantityOfRequestInBuffer : array[1..2,1.._NUMBER_OF_ITERATION_] of longint;
			{average processing time}
			averageQuantityRequestInBuffer : array[1..2] of longint;
			{average expection time}
			averageExpectionTime : array[1..2,1.._NUMBER_OF_ITERATION_] of real;
			{common average expection time}
			commonAverageExpectionTime : array[1.._NUMBER_OF_ITERATION_] of real;
			{request Reached Device}
			requestReachedDevice : array[1..2,1.._NUMBER_OF_ITERATION_] of longint;
			{request going in device instantly}
			requestGoingInstantlyToDevice : array[1..2,1.._NUMBER_OF_ITERATION_] of longint;

		public

			{initialization our the massive for statistics}
			constructor Init(probabilityOfReject_ : real);
			{increment quantity request of source}
			procedure incrementKol(i, numberOfIteration: longint);
			{increment quantity request of source have processed}
			procedure incrementKobr(i, numberOfIteration: longint);
			{increment quantity request of source have got reject}
			procedure incrementKotk(i, numberOfIteration: longint);
			{calculate probability of reject}
			procedure calculateProbabilityOfReject(numberOfIteration : longint);
			{change average processing time after new request in buffer}
			procedure calculateAverageQuantityRequestInBuffer(i : longint);
			{change average expection time after new request in buffer}
			procedure newAverageExpectionTime(i, iteration : longint; newTime : real);
			{calculate common average expection time}
			procedure calculateAverageExpectionTime(numberOfIteration : longint);
			{increment quantityOfRequestInBuffer}
			procedure incrementQuantityRequestInBuffer(i, iteration : longint);
			{increment quantityOfRequestInBuffer}
			procedure incrementRequestGoingInstantlyToDevice(i, iteration : longint);
			{reset all field}
			procedure resetField;
			{getters for all field of class}
			function getKol(i, numberOfIteration : longint) : longint;
			function getKobr(i, numberOfIteration : longint) : longint;
			function getKotk(i, numberOfIteration : longint) : longint;
			function getProbabilityOfReject(i, numberOfIteration : longint) : real;
			function getCommonProbabilityOfReject(numberOfIteration : longint) : real;
			function getAverageQuantityRequestInBuffer(i : longint) : longint;
			function getAverageExpectionTime(i, numberOfIteration : longint) : real;
			function getCommonAvExpTime(numberOfIteration : longint) : real;
			function getQuantityRequestInBuffer(i, numberOfIteration : longint) : longint;
			function getRequestGoingInstantlyToDevice(i, numberOfIteration : longint) : longint;
	end;

Implementation

	constructor StatisticObj.Init;
    begin
		probabilityOfReject[1,0] := probabilityOfReject_;
		probabilityOfReject[2,0] := probabilityOfReject_;
		commonProbabilityOfReject[0] := probabilityOfReject_;
	end;

	procedure StatisticObj.resetField;
	var
		i, j : longint;
	begin
		for i := 1 to 2 do
		begin
			for j := 1 to _NUMBER_OF_ITERATION_ do
			begin
				kol[i,j] := 0;
				kobr[i,j] := 0;
				kotk[i,j] := 0;
				averageQuantityRequestInBuffer[i] := 0;
				averageExpectionTime[i,j] := 0;
				quantityOfRequestInBuffer[i,j] := 0;
				probabilityOfReject[i,j] := 0;
				commonProbabilityOfReject[j] := 0;
				commonAverageExpectionTime[j] := 0;
				requestReachedDevice[i,j] := 0;
				requestGoingInstantlyToDevice[i,j] := 0;
			end;
		end;
	end;

	procedure StatisticObj.incrementKol;
	begin
		inc(kol[i, numberOfIteration]);
	end;

	procedure StatisticObj.incrementKobr;
	begin
		inc(kobr[i, numberOfIteration]);
	end;

	procedure StatisticObj.incrementKotk;
	begin
		inc(kotk[i, numberOfIteration]);
	end;

	procedure StatisticObj.calculateProbabilityOfReject;
	var
		i : longint;
	begin
		for i := 1 to 2 do
			probabilityOfReject[i, numberOfIteration] :=
			kotk[i, numberOfIteration] / kol[i, numberOfIteration];
		commonProbabilityOfReject[numberOfIteration] :=
		(probabilityOfReject[1, numberOfIteration] + probabilityOfReject[2, numberOfIteration]) / 2;
	end;

	procedure StatisticObj.calculateAverageQuantityRequestInBuffer;
	var
		temp : longint;
		j : longint;
	begin
		temp := 0;

		for j := 1 to _NUMBER_OF_ITERATION_ do
			temp :=temp + quantityOfRequestInBuffer[i, j];

		averageQuantityRequestInBuffer[i] := round(temp / _NUMBER_OF_ITERATION_);
	end;

	procedure StatisticObj.newAverageExpectionTime;
	begin
		averageExpectionTime[i, iteration] := (averageExpectionTime[i, iteration] *
				requestReachedDevice[i, iteration] + newTime) / (requestReachedDevice[i, iteration] + 1);
			inc(requestReachedDevice[i, iteration]);
	end;

	procedure StatisticObj.calculateAverageExpectionTime;
	begin
		commonAverageExpectionTime[numberOfIteration] := (averageExpectionTime[1, numberOfIteration] +
		averageExpectionTime[2, numberOfIteration]) / 2;
	end;

	procedure StatisticObj.incrementQuantityRequestInBuffer;
	begin
		inc(quantityOfRequestInBuffer[i, iteration]);
	end;
	
	procedure StatisticObj.incrementRequestGoingInstantlyToDevice;
	begin
		inc(requestGoingInstantlyToDevice[i, iteration]);
	end;

	function StatisticObj.getKol;
	begin
		getKol := kol[i, numberOfIteration];
	end;

	function StatisticObj.getKobr;
	begin
		getKobr := kobr[i, numberOfIteration];
	end;

	function StatisticObj.getKotk;
	begin
		getKotk := kotk[i, numberOfIteration];
	end;

	function StatisticObj.getProbabilityOfReject;
	begin
		getProbabilityOfReject := kotk[i, numberOfIteration] / kol[i, numberOfIteration];
	end;

	function StatisticObj.getAverageExpectionTime;
	begin
		getAverageExpectionTime := averageExpectionTime[i, numberOfIteration];
	end;

	function StatisticObj.getQuantityRequestInBuffer;
	begin
		getQuantityRequestInBuffer := quantityOfRequestInBuffer[i, numberOfIteration];
	end;

    function StatisticObj.getAverageQuantityRequestInBuffer;
    begin
		calculateAverageQuantityRequestInBuffer(i);
        getAverageQuantityRequestInBuffer := averageQuantityRequestInBuffer[i];
    end;

	function StatisticObj.getCommonAvExpTime;
	begin
		calculateAverageExpectionTime(numberOfIteration);
		getCommonAvExpTime := commonAverageExpectionTime[numberOfIteration];
	end;

	function StatisticObj.getCommonProbabilityOfReject(numberOfIteration : longint) : real;
	begin
		getCommonProbabilityOfReject := commonProbabilityOfReject[numberOfIteration];
	end;
	
	function StatisticObj.getRequestGoingInstantlyToDevice;
	begin
		getRequestGoingInstantlyToDevice := requestGoingInstantlyToDevice[i, numberOfIteration];
	end;
	
BEGIN
END.