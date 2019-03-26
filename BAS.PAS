{Implementation the units of analysis of the status}
Unit Bas;
Interface

	uses Buffer, Device;
	
	type
		p_Bas = ^BasObj;
		BasObj = object
			private
			
				{instance of class Device}
				dev : p_Device;
				{instance of class Buffer}
				buff : p_Buffer;
				
			public	
			
				{initialization the field}
				constructor Init(newDevice : p_Device; newBuffer : p_Buffer);
				{method which create new request with his the index
					if return 1  -  buffer is busy and request is denied
					if return 2   -  request is going in buffer
					if return 3   -  request is going instantly to device }
				function createNewRequest(numberOfSource : longint; timeOfSource : real;
											iteration : longint) : longint;
		end;
		
Implementation
	
	constructor BasObj.Init;
	begin
		dev := newDevice;
		buff := newBuffer;
	end;
	
	function BasObj.createNewRequest;
	begin
		if dev^.getWorking = false then
		begin
			dev^.startWorking(numberOfSource, timeOfSource);
			createNewRequest := 3;
		end
		else if buff^.Full = false then
		begin
			buff^.setRequest(numberOfSource, timeOfSource);
			createNewRequest := 2;
		end
		else
			createNewRequest := 1;
	end;
	
BEGIN
END.