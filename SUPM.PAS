{Draw submenu of buttonSup Set up parametres}
Unit SupM;
Interface

        uses graph, crt, BOOS, SOURCE1, SOURCE2;

	type 
		p_SMSUP = ^SupObj;
		SupObj = object
			private
			
				{instance SOURCE1}
				firstSource : p_Source1;
				{instance SOURCE2}
				secondSource : p_Source2;
				{instance Boos}
				boosIn : p_Boos;
				{new kmin}
				kmin_ : longint;
				{new lambda, delta lambda, finally lambda}
				lambda_, deltaLambda_, finallyLambda_ : real;
				{new tay1 and tay2}
				tay1_, tay2_ : real;
				{longint and real --> string}
				field : string;
				
			public
				
				{initialization the field}
				Constructor Init(boosIn_ : p_Boos);
				{draw buttonSup for start lambda}
				procedure drawButtonForStartLambda(color, fraim : longint);
				{draw buttonSup for end lambda}
				procedure drawButtonForEndLambda(color, fraim : longint);
				{draw buttonSup for delta lambda}
				procedure drawButtonForDeltaLambda(color, fraim : longint);
				{draw buttonSup for kmin}
				procedure drawButtonForKmin(color, fraim : longint);
				{draw buttonSup for start tay2}
				procedure drawButtonForStartTay(color, fraim : longint);
				{draw buttonSup for end tay2}
				procedure drawButtonForEndTay(color, fraim : longint);
				{launch submenu of sup}
				procedure launchSubmenuOfSUP;


		end;

Implementation

	constructor SupObj.Init;
	begin
		new(firstSource, Init);
		new(secondSource, Init);
		boosIn := boosIn_;
    end;

	procedure SupObj.drawButtonForStartLambda;
	begin
		setcolor(color);
		setfillstyle(1, color);
		Bar(30, 100, 180, 140);
		setcolor(fraim);
		Rectangle(30, 100, 180, 140);
		setcolor(black);
		SetTextStyle(DefaultFont, HorizDir, 1);
		str(firstSource^.getLambda:2:1, field);
		OutTextXY(34, 118, concat('Start lambda = ', field));
		setcolor(fraim);
		line(105, 100, 105, 91);
	end;

	procedure SupObj.drawButtonForEndLambda;
	begin
		setcolor(color);
		setfillstyle(1, color);
		Bar(30, 150, 180, 190);
		setcolor(fraim);
		Rectangle(30, 150, 180, 190);
		setcolor(black);
		SetTextStyle(DefaultFont, HorizDir, 1);
		str(firstSource^.getFinallyLambda:2:1, field);
		OutTextXY(41, 168, concat('End lambda = ', field));
		setcolor(fraim);
		line(105, 150, 105, 140);
	end;

	procedure SupObj.drawButtonForDeltaLambda;
	begin
		setcolor(color);
		setfillstyle(1, color);
		Bar(30, 200, 180, 240);
		setcolor(fraim);
		Rectangle(30, 200, 180, 240);
		setcolor(black);
		SetTextStyle(DefaultFont, HorizDir, 1);
		str(firstSource^.getDeltaLambda:2:1, field);
		OutTextXY(34, 218, concat('Delta lambda = ', field));
		setcolor(fraim);
		line(105, 200, 105, 190);
	end;

	procedure SupObj.drawButtonForKmin;
	begin
		setcolor(color);
		setfillstyle(1, color);
		Bar(30, 250, 180, 290);
		setcolor(fraim);
		Rectangle(30, 250, 180, 290);
		setcolor(black);
		SetTextStyle(DefaultFont, HorizDir, 1);
		str(boosIn^.getKmin, field);
		OutTextXY(60, 268, concat('Kmin = ', field));
		setcolor(fraim);
		line(105, 250, 105, 240);
	end;

	procedure SupObj.drawButtonForStartTay;
	begin
		setcolor(color);
		setfillstyle(1, color);
		Bar(30, 300, 180, 340);
		setcolor(fraim);
		Rectangle(30, 300, 180, 340);
		setcolor(black);
		SetTextStyle(DefaultFont, HorizDir, 1);
		str(secondSource^.getTay1:2:1, field);
		OutTextXY(42, 318, concat('Start tay2 = ', field));
		setcolor(fraim);
		line(105, 300, 105, 290);
	end;

	procedure SupObj.drawButtonForEndTay;
	begin
		setcolor(color);
		setfillstyle(1, color);
		Bar(30, 350, 180, 390);
		setcolor(fraim);
		Rectangle(30, 350, 180, 390);
		setcolor(black);
		SetTextStyle(DefaultFont, HorizDir, 1);
		str(secondSource^.getTay2:2:1, field);
		OutTextXY(47, 368, concat('End tay2 = ', field));
		setcolor(fraim);
		line(105, 350, 105, 340);
	end;
	
	procedure SupObj.launchSubmenuOfSUP;
	var
		buttonSup : char;
		indSup : longint;
	begin
		drawButtonForStartLambda(10, 15);
		drawButtonForEndLambda(4, 15);
		drawButtonForDeltaLambda(4, 15);
		drawButtonForKmin(4, 15);
		drawButtonForStartTay(4, 15);
		drawButtonForEndTay(4, 15);
		
		indSup := 1;
		buttonSup := readkey;
	
		repeat
			
			if ((buttonSup = #80) and (indSup < 6)) then
				inc(indSup)
			else if ((buttonSup = #72) and (indSup > 1)) then
				dec(indSup);
			
			case indSup of
				1:
				begin
					drawButtonForStartLambda(10, 15);
					drawButtonForEndLambda(4, 15);
					drawButtonForDeltaLambda(4, 15);
					drawButtonForKmin(4, 15);
					drawButtonForStartTay(4, 15);
					drawButtonForEndTay(4, 15);
					buttonSup := readkey;
					
					if buttonSup = #13 then
					begin
						read(lambda_);
						setfillstyle(1, black);
						Bar(0, 0, 640, 15);
						firstSource^.setLambda(lambda_);
						drawButtonForStartLambda(10, 15);
						buttonSup := readkey;
					end;
				end;
				
				2:
				begin
					drawButtonForStartLambda(4, 15);
					drawButtonForEndLambda(10, 15);
					drawButtonForDeltaLambda(4, 15);
					drawButtonForKmin(4, 15);
					drawButtonForStartTay(4, 15);
					drawButtonForEndTay(4, 15);
					buttonSup := readkey;
					
					if buttonSup = #13 then
					begin
						read(finallyLambda_);
						setfillstyle(1, black);
						Bar(0, 0, 640, 15);
						firstSource^.setFinallyLambda(finallyLambda_);
						drawButtonForEndLambda(10, 15);
						buttonSup := readkey;
					end;
				end;
				
				3:
				begin
					drawButtonForStartLambda(4, 15);
					drawButtonForEndLambda(4, 15);
					drawButtonForDeltaLambda(10, 15);
					drawButtonForKmin(4,15);
					drawButtonForStartTay(4, 15);
					drawButtonForEndTay(4, 15);
					buttonSup := readkey;
						
					if buttonSup = #13 then
					begin
						read(deltaLambda_);
						setfillstyle(1, black);
						Bar(0, 0, 640, 15);
						firstSource^.setDeltaLambda(deltaLambda_);
						drawButtonForDeltaLambda(10, 15);
						buttonSup := readkey;
					end;
				end;
				
				4:
				begin
					drawButtonForStartLambda(4, 15);
					drawButtonForEndLambda(4, 15);
					drawButtonForDeltaLambda(4, 15);
					drawButtonForKmin(10, 15);
					drawButtonForStartTay(4, 15);
					drawButtonForEndTay(4, 15);
					buttonSup := readkey;
					
					if buttonSup = #13 then
					begin
						read(kmin_);
						setfillstyle(1, black);
						Bar(0, 0, 640, 15);
						boosIn^.setKmin(kmin_);
						drawButtonForKmin(10, 15);
						buttonSup := readkey;
					end;
				end;
				
				5:
				begin
					drawButtonForStartLambda(4, 15);
					drawButtonForEndLambda(4, 15);
					drawButtonForDeltaLambda(4, 15);
					drawButtonForKmin(4, 15);
					drawButtonForStartTay(10, 15);
					drawButtonForEndTay(4, 15);
					buttonSup := readkey;
						
					if buttonSup = #13 then
					begin
						read(tay1_);
						setfillstyle(1, black);
						Bar(0, 0, 640, 15);
						secondSource^.setTay1(tay1_);
						drawButtonForStartTay(10, 15);
						buttonSup := readkey;
					end;
				end;
				
				6:
				begin
					drawButtonForStartLambda(4, 15);
					drawButtonForEndLambda(4, 15);
					drawButtonForDeltaLambda(4, 15);
					drawButtonForKmin(4, 15);
					drawButtonForStartTay(4, 15);
					drawButtonForEndTay(10, 15);
					buttonSup := readkey;
						
					if buttonSup = #13 then
					begin
						read(tay2_);
						setfillstyle(1, black);
						Bar(0, 0, 640, 15);
						secondSource^.setTay2(tay2_);
						drawButtonForEndTay(10, 15);
						buttonSup := readkey;
					end;
				end;
			end;
			
			if buttonSup = #79 then
			begin
				drawButtonForStartLambda(0, 0);
					drawButtonForEndLambda(0, 0);
					drawButtonForDeltaLambda(0, 0);
					drawButtonForKmin(0, 0);
					drawButtonForStartTay(0, 0);
					drawButtonForEndTay(0, 0);
			end;
			
		until buttonSup = #79;
	end;
	
BEGIN
END.