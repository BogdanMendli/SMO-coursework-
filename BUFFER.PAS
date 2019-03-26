{Implementation of Buffer with capacity = 2 and without priority}
Unit Buffer;
Interface

	type
		p_Buffer = ^BufferObj;
		BufferObj = object
			private

				{capacity of Buffer}
				capacity : longint;
				{length Of Buffer}
				indBuf : longint;
				{massive number and time of Source in Buffer according}
				masBufN : array[1..2] of longint;
				masBufT : array[1..2] of real;

			public

				{initialization the field}
				constructor Init(capacity_ : longint);
				{return quantity elemnts in Buffer}
				function getQuantity : longint;
				{check for emptiness and fullness of the buffer according}
				function Empty : boolean;
				function Full : boolean;
				{setter and getter of Request for Buffer according}
				procedure setRequest(bufN : longint; bufT : real);
				procedure getRequest(var bufN : longint; var bufT : real);
				{clear all buffer}
				procedure clearBuffer;
		end;

Implementation

	constructor BufferObj.Init;
	begin
		capacity := capacity_;
		indBuf := 0;
	end;

	function BufferObj.Empty;
	begin
		Empty := (indBuf = 0);
	end;

	function BufferObj.Full;
	begin
		Full := (indBuf = CAPACITY);
	end;

	procedure BufferObj.setRequest;
	begin
		inc(indBuf);
		masBufN[indBuf] := bufN;
		masBufT[indBuf] := bufT;
	end;

	procedure BufferObj.getRequest ;
	begin
		dec(indBuf);
		bufN := masBufN[1];
		bufT := masBufT[1];
		masBufN[1] := masBufN[2];
		masBufT[1] := masBufT[2];
	end;

	procedure BufferObj.clearBuffer;
	var
		i : longint;
	begin
		for i := 1 to capacity do
		begin
			masBufN[i] := 0;
			masBufT[i] := 0;
		end;
		indBuf := 0;
	end;

        function BufferObj.getQuantity;
        begin
                getQuantity := indBuf;
        end;

BEGIN
END.