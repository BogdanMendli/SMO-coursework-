{Draw submenu for button modeling}
Unit MenuRes;
Interface

	uses graph, crt, Statist, Source1, Boos;
	
	type
		p_MenuRes = ^MenuResObj;
		MenuResObj = object
			private
			
				{instance for class Source1 and Statistic}
				stat : p_Statistic;
				firstSource : p_Source1;
				booisIn : p_Boos;
			
			public
			
				{initialization the field}
				constructor Init(stat_ : p_Statistic; firstSource_ : p_Source1; booisIn_ : p_Boos);
				{draw lines P}
				procedure drawLinesP(color, source : longint);
				{draw lines M}
				procedure drawLinesM(color, source : longint);
				{draw black background}
				procedure drawBackground;
				{draw table of results}
				procedure drawTableOfResults;
				{draw graphics P*}
				procedure drawGraphicsP;
				{draw graphics M}
				procedure drawGraphicsM;
				{draw button table of result}
				procedure drawButtonTableOfResults(color, fraim : longint);
				{draw button P(lambda)}
				procedure drawButtonP(color, fraim : longint);
				{draw button M(lambda)}
				procedure drawButtonM(color, fraim : longint);
				{draw warning}
				procedure drawWarning;
				{write a tips}
				procedure drawHelp;
				{draw button of setting params}
				procedure drawButtonOfSettingParams(color, fraim : longint);
				{draw button of modeling}
				procedure drawButtonOfModeling(color, fraim : longint);
				{draw button of results}
				procedure drawButtonOfResults(color, fraim : longint);
				{launch submenu of result}
				procedure launchSubmenuRes;
		end;
		
Implementation
	
	{initialization the field}
	constructor MenuResObj.Init;
	begin
		stat := stat_;
		firstSource := firstSource_;
		booisIn := booisIn_;
	end;
	
	procedure MenuResObj.drawBackground;
	begin
		setcolor(black);
		setfillstyle(1, black);
		Bar(0, 0, 640, 480);
	end;
	
	procedure MenuResObj.drawWarning;
	var
		button : char;
	begin
		setcolor(12);
		SetTextStyle(DefaultFont, HorizDir, 2);
		OutTextXY(50, 300, 'You dont launch the modeling');
		OutTextXY(50, 350, 'Prease press END to continue');
		
		repeat
			button := readkey;
		until button = #79;

		setfillstyle(1, black);
		Bar(45, 290, 400, 400);
	end;
	
	procedure MenuResObj.drawTableOfResults;
	var
		button : char;
		iteration : longint;
		help : string;
	begin
		if stat^.getKol(1, 1) = 0 then
		begin
			drawWarning;   
			exit;
		end;

		drawBackground;
		setcolor(12);
		SetTextStyle(DefaultFont, HorizDir, 2);
		OutTextXY(220, 20, 'Table of results');
		OutTextXY(210, 450, 'Press END to exit');
		setcolor(9);
		Rectangle(20, 50, 622, 434);
		
		for iteration:= 1 to 11 do
		begin
			line(20, 50 + iteration * 32, 622, 50 + iteration * 32);
		end;
		
		for iteration:= 1 to 6 do
		begin
			line(20 + iteration * 86, 50, 20 + iteration * 86, 435);
		end;
		
		SetTextStyle(DefaultFont, HorizDir, 1);
		setcolor(15);
		OutTextXY(38, 63, 'Lambda');
		OutTextXY(140, 63, 'P* 1');
		OutTextXY(223, 63, 'P* 2');
		OutTextXY(312, 63, 'M 1');
		OutTextXY(397, 63, 'M 2');
		OutTextXY(455, 60, '<N> requst');
		OutTextXY(462, 70, 'in 1 buf');
		OutTextXY(560, 63, 'Kmin');
		
		for iteration := 1 to 11 do
		begin
			str((firstSource^.getLambda + (iteration - 1) * 
			firstSource^.getDeltaLambda):3:2, help);
			OutTextXY(50, 63 + iteration * 32, help);
			
			str((stat^.getProbabilityOfReject(1, iteration)):4:3, help);
			OutTextXY(133, 63 + iteration * 32, help);
			
			str((stat^.getProbabilityOfReject(2, iteration)):4:3, help);
			OutTextXY(218, 63 + iteration * 32, help);
			
			str(stat^.getAverageExpectionTime(1, iteration):4:3, help);
			OutTextXY(303, 63 + iteration * 32, help);
			
			str(stat^.getAverageExpectionTime(2, iteration):4:3, help);
			OutTextXY(387, 63 + iteration * 32, help);
			
			str(((stat^.getQuantityRequestInBuffer(1, iteration)/
			(stat^.getKobr(1, iteration) + stat^.getKobr(2, iteration) -
			stat^.getRequestGoingInstantlyToDevice(1, iteration) - 
			stat^.getRequestGoingInstantlyToDevice(2, iteration)))*2):3:2, help);
			OutTextXY(477, 63 + iteration * 32, help);
			
			str(booisIn^.getNewKmin(iteration), help);
			OutTextXY(565, 63 + iteration * 32, help);
			
		end;
		
		repeat
			button := readkey;
		until button = #79;
	end;
	
	procedure MenuResObj.drawLinesP;
	var
		i : longint;
	begin
		setcolor(color);
		for i := 1 to 10 do
		begin
			line(40 + 50 * i, 420 - round(stat^.getProbabilityOfReject(source, i) * 360),
			40 + 50 * (i + 1), 420 -  round(stat^.getProbabilityOfReject(source, (i + 1)) * 360));
			FillEllipse(40 + 50 * i, 420 - round(stat^.getProbabilityOfReject(source, i) * 360), 3, 3);
			FillEllipse(40 + 50 * (i + 1), 420 -  round(stat^.getProbabilityOfReject(source, (i + 1)) * 360), 3, 3);
		end;
	end;
	
	procedure MenuResObj.drawGraphicsP;
	var
		button : char;
		iteration, i : longint;
		help : string;
	begin
		if stat^.getKol(1, 1) = 0 then
		begin
			drawWarning;   
			exit;
		end;
	
		drawBackground;
		setcolor(12);
		SetTextStyle(DefaultFont, HorizDir, 2);
		OutTextXY(230, 10, 'P*(lambda)');
		OutTextXY(195, 460, 'Press END to exit');
		setfillstyle(1, white);
		Bar(40, 60, 41, 420);
		Bar(40, 419, 590, 420);
		setcolor(15);
		SetTextStyle(DefaultFont, HorizDir, 2);
		OutTextXY(35, 40, 'P*');
		OutTextXY(605, 413, 'L');
		SetTextStyle(DefaultFont, HorizDir, 1);
		
		for i := 1 to 10 do
		begin
			Bar(36, 60 + (i - 1) * 36, 45, 61 + (i - 1) * 36);
			str((0.1 * i):2:1, help);
			OutTextXY(10, 57 + (10 - i) * 36, help);
		end;
		
		for iteration := 1 to 11 do
		begin
			Bar(40 + 50 * iteration, 415, 41 + 50 * iteration, 424);
			str((firstSource^.getLambda + firstSource^.getDeltaLambda * 
			(iteration - 1)):2:1, help);
			OutTextXY(28 + 50 * iteration, 435, help);
		end;
		
		SetTextStyle(DefaultFont, HorizDir, 1);
		setcolor(10);
		line(480, 35, 580, 35);
		OutTextXY(500, 20, 'Source 1');
		setcolor(14);
		line(480, 65, 580, 65);
		OutTextXY(500, 50, 'Source 2');
		
		drawLinesP(10, 1);
		drawLinesP(14, 2);
		
		repeat
			button := readkey;
		until button = #79;
	end;
	
	procedure MenuResObj.drawLinesM;
	var
		i : longint;
	begin
		setcolor(color);
		for i := 1 to 10 do
		begin
			line(40 + 50 * i, 420 - round((stat^.getAverageExpectionTime(source, i) / 4) * 360),
			40 + 50 * (i + 1), 420 -  round((stat^.getAverageExpectionTime(source, (i + 1)) / 4) * 360));
			FillEllipse(40 + 50 * i, 420 - round((stat^.getAverageExpectionTime(source, i) / 4) * 360), 3, 3);
			FillEllipse(40 + 50 * (i + 1), 420 -  round((stat^.getAverageExpectionTime(source, (i + 1)) / 4) * 360), 3, 3);
		end;
	end;
	
	procedure MenuResObj.drawGraphicsM;
	var
		button : char;
		iteration, i : longint;
		help : string;
	begin
		if stat^.getKol(1, 1) = 0 then
		begin
			drawWarning;   
			exit;
		end;
	
		drawBackground;
		setcolor(12);
		SetTextStyle(DefaultFont, HorizDir, 2);
		OutTextXY(230, 10, 'M(lambda)');
		OutTextXY(195, 460, 'Press END to exit');
		setfillstyle(1, white);
		Bar(40, 60, 41, 420);
		Bar(40, 419, 590, 420);
		setcolor(15);
		SetTextStyle(DefaultFont, HorizDir, 2);
		OutTextXY(38, 40, 'M');
		OutTextXY(605, 413, 'L');
		SetTextStyle(DefaultFont, HorizDir, 1);
		
		for i := 1 to 10 do
		begin
			Bar(36, 60 + (i - 1) * 36, 45, 61 + (i - 1) * 36);
			str((0.4 * i):2:1, help);
			OutTextXY(10, 57 + (10 - i) * 36, help);
		end;
		
		for iteration := 1 to 11 do
		begin
			Bar(40 + 50 * iteration, 415, 41 + 50 * iteration, 424);
			str((firstSource^.getLambda + firstSource^.getDeltaLambda * 
			(iteration - 1)):2:1, help);
			OutTextXY(28 + 50 * iteration, 435, help);
		end;
		
		SetTextStyle(DefaultFont, HorizDir, 1);
		setcolor(10);
		line(480, 35, 580, 35);
		OutTextXY(500, 20, 'Source 1');
		setcolor(14);
		line(480, 65, 580, 65);
		OutTextXY(500, 50, 'Source 2');
		
		drawLinesM(10, 1);
		drawLinesM(14, 2);
		
		repeat
			button := readkey;
		until button = #79;
	end;
	
	procedure MenuResObj.drawButtonTableOfResults;
	begin
		setcolor(color);
		setfillstyle(1, color);
		Bar(430, 100, 580, 150);
		setcolor(fraim);
		Rectangle(430, 100, 580, 150);
		setcolor(black);
		SetTextStyle(DefaultFont, HorizDir, 1);
		OutTextXY(440, 120, 'Table of results');
		setcolor(fraim);
		line(505, 100, 505, 91);
	end;
	
	procedure MenuResObj.drawButtonP;
	begin
		setcolor(color);
		setfillstyle(1, color);
		Bar(430, 160, 580, 210);
		setcolor(fraim);
		Rectangle(430, 160, 580, 210);
		setcolor(black);
		SetTextStyle(DefaultFont, HorizDir, 1);
		OutTextXY(470, 180, 'P(lambda)');
		setcolor(fraim);
		line(505, 160, 505, 150);
	end;
	
	procedure MenuResObj.drawButtonM;
	begin
		setcolor(color);
		setfillstyle(1, color);
		Bar(430, 220, 580, 270);
		setcolor(fraim);
		Rectangle(430, 220, 580, 270);
		setcolor(black);
		SetTextStyle(DefaultFont, HorizDir, 1);
		OutTextXY(470, 240, 'M(lambda)');
		setcolor(fraim);
		line(505, 220, 505, 210);
	end;
		
	procedure MenuResObj.drawHelp;
	begin
		setcolor(blue);
		SetTextStyle(DefaultFont, HorizDir, 1);
		OutTextXY(20, 420, 'Press right, left, up or down arrow to switch between the button.');
		OutTextXY(20, 440, 'Press ENTER if you want choose this button. Press END if you want exit.');
		OutTextXY(20, 460, 'SMO done by Maschenko Bogdan, group 13534/4, 2019 year');
	end;

	procedure MenuResObj.drawButtonOfSettingParams;
	begin
		setcolor(color);
		setfillstyle(1, color);
		Bar(30, 40, 180, 90);
		setcolor(fraim);
		Rectangle(30, 40, 180, 90);
		setcolor(black);
		SetTextStyle(DefaultFont, HorizDir, 1);
		OutTextXY(38, 60, 'Set up parameters');
	end;
	
	procedure MenuResObj.drawButtonOfModeling;
	begin
		setcolor(color);
		setfillstyle(1, color);
		Bar(230, 40, 380, 90);
		setcolor(fraim);
		Rectangle(230, 40, 380, 90);
		setcolor(black);
		SetTextStyle(DefaultFont, HorizDir, 1);
		OutTextXY(275, 60, 'Modeling');
	end;

	procedure MenuResObj.drawButtonOfResults;
	begin
		setcolor(color);
		setfillstyle(1, color);
		Bar(430, 40, 580, 90);
		setcolor(fraim);
		Rectangle(430, 40, 580, 90);
		setcolor(black);
		SetTextStyle(DefaultFont, HorizDir, 1);
		OutTextXY(480, 60, 'Results');
	end;
	
	procedure MenuResObj.launchSubmenuRes;
	var
		buttonRes : char;
		indRes : longint;
	begin
		drawButtonTableOfResults(10, 15);
		drawButtonP(4, 15);
		drawButtonM(4, 15);

		indRes := 1;
		buttonRes := readkey;
		
		repeat
		
			if ((buttonRes = #80) and (indRes < 3)) then
				inc(indRes)
			else if ((buttonRes = #72) and (indRes > 1)) then
				dec(indRes);
				
			case indRes of
				1:
				begin
					drawButtonTableOfResults(10, 15);
					drawButtonP(4, 15);
					drawButtonM(4, 15);
					buttonRes := readkey;
					
					if buttonRes = #13 then
					begin
						drawTableOfResults;
						
						drawBackground;
						drawButtonOfSettingParams(4, 15);
						drawButtonOfModeling(4,15);
						drawButtonOfResults(7, 15);
						drawHelp;
						drawButtonTableOfResults(10, 15);
						drawButtonP(4, 15);
						drawButtonM(4, 15);
						buttonRes := readkey;
					end;
				end;
				
				2:
				begin
					drawButtonTableOfResults(4, 15);
					drawButtonP(10, 15);
					drawButtonM(4, 15);
					buttonRes := readkey;
					
					if buttonRes = #13 then
					begin
						drawGraphicsP;
						
						drawBackground;
						drawButtonOfSettingParams(4, 15);
						drawButtonOfModeling(4,15);
						drawButtonOfResults(7, 15);
						drawHelp;
						drawButtonTableOfResults(4, 15);
						drawButtonP(10, 15);
						drawButtonM(4, 15);
						buttonRes := readkey;
					end;
				end;
				
				3:
				begin
					drawButtonTableOfResults(4, 15);
					drawButtonP(4, 15);
					drawButtonM(10, 15);
					buttonRes := readkey;
					
					if buttonRes = #13 then
					begin
						drawGraphicsM;
						
						drawBackground;
						drawButtonOfSettingParams(4, 15);
						drawButtonOfModeling(4,15);
						drawButtonOfResults(7, 15);
						drawHelp;
						drawButtonTableOfResults(4, 15);
						drawButtonP(4, 15);
						drawButtonM(10, 15);
						buttonRes := readkey;
					end;
				end;
			end;
			
			if buttonRes = #79 then
			begin
				drawButtonTableOfResults(0, 0);
				drawButtonP(0, 0);
				drawButtonM(0, 0);
			end;
		
		until buttonRes = #79;
	end;

BEGIN
END.