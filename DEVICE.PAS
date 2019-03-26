{Implementation of working our device}
Unit Device;
Interface
	
	uses Buffer;
	
	type
		p_Device = ^DeviceObj;
		DeviceObj = object
			private
		
				{time of start service in the device}
				tho : real;
				{common time of service}
				tayob : real;
				{time when device becomes a free}
				tosv : real;
				{numver of source in device}
				numberOfSource : longint;
				{check the device is working or not}
				working : boolean;
				{const lambda of processing}
				lambdaObr : real;
			
				{instance of class Buffer}
				buff : p_Buffer;
			
			public
			
				{initialization the field}
				constructor Init(newBuff : p_Buffer; lambdaObr_ : real);
				{getter for field working}
				function getWorking : boolean;
				{getter for field tho}
				function getTho : real;
				{getter and maker for field tayob}
				function getTayob : real;
				{make tayob}
				procedure makeTayob;
				{getter for field tosv}
				function getTosv : real;
				{start working}
				procedure startWorking(newNumberOfSource : longint; newTho : real);
				{finish working}
				procedure finishWorking(var finishNumberOfSource : longint;
										var finishTime : real; 
										var newTimeOfNewRequest : real);
				{clear the device}
				procedure clearDevice;
		end;
		
Implementation

	constructor DeviceObj.Init;
	begin
		buff := newBuff;
		tho := 0;
		tayob := 0;
		tosv := 0;
		numberOfSource := 0;
		lambdaObr := lambdaObr_ {2};
		working := false;
	end;
	
	function DeviceObj.getWorking;
	begin
		getWorking := working;
	end;
	
	function DeviceObj.getTho;
	begin
		getTho := tho;
	end;
	
	function DeviceObj.getTayob;
	begin
		getTayob := tayob;
	end;
	
	procedure DeviceObj.makeTayob;
	begin
		tayob := -(ln(random) / lambdaObr );
	end;
	
	function DeviceObj.getTosv;
	begin
		getTosv := tosv;
	end;
	
	procedure DeviceObj.startWorking;
	begin
		numberOfSource := newNumberOfSource;
		tho := newTho;
		working := true;
		makeTayob;
		if tosv > newTho then
			tosv := tosv + tayob
		else 
			tosv := newTho + tayob;
	end;
	
	procedure DeviceObj.finishWorking;
	var
		startNewNumberOfSource : longint;
		startNewTime : real;
	begin
		finishNumberOfSource := numberOfSource;
		finishTime := tho;
		working := false;
		
		if buff^.Empty = true then
			newTimeOfNewRequest := -1
		else begin
			buff^.getRequest(startNewNumberOfSource, startNewTime);
			newTimeOfNewRequest := startNewTime;
			startWorking(startNewNumberOfSource, startNewTime);
		end;
	end;
	
	procedure DeviceObj.clearDevice;
	begin
		tho := 0;
		numberOfSource := 0;
		working := false;
		tosv := 0;
		buff^.clearBuffer;
	end;
	
BEGIN
END.