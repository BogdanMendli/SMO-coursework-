{Draw menu}
Unit Menu;
Interface
{program Graphic;}	
	
	uses graph, crt, SUPM, Bas, Buffer, Device, Boos, Statist, 
	Writer, Source1, Source2, MenuMod, MenuRes;
	
	type
		p_MainMenu = ^MainMenuObj;
		MainMenuObj = object
			private

				{variable for Initgraph}
			    gh, gm : integer;
				{instance of classes}
				boosIn : p_Boos;
				buff: p_Buffer;
				writerIn : p_Writer;
				firstSource : p_Source1;
				secondSource : p_Source2;
				dev : p_Device;
				basIn : p_Bas;
				stat : p_Statistic;
				SubMenuSup : p_SMSUP;
				SubMenuMod : p_MenuMod;
				SubMenuRes : p_MenuRes;

			public

				{initialization our the massive for menu}
				constructor Init;
				{write a tips}
				procedure drawHelp;
				{draw button of setting params}
				procedure drawButtonOfSettingParams(color, fraim : longint);
				{draw button of modeling}
				procedure drawButtonOfModeling(color, fraim : longint);
				{draw button of results}
				procedure drawButtonOfResults(color, fraim : longint);
				{launch main menu}
				procedure launchMainMenu;
		end;

Implementation

	constructor MainMenuObj.Init;
	begin
		gm := 0;
		gh := 0;
		new (firstSource, Init);
		new (secondSource, Init);
		new (stat, Init(0.9));
		new (buff, Init(2));
		new (dev, Init(buff, 1));
		new (basIn, Init(dev, buff));
		new (writerIn, Init);
		new (boosIn, Init(firstSource, secondSource, dev, basIn, stat, writerIn, 2.71, 0.1));
		new(SubMenuSup, Init(boosIn));
		new(SubMenuMod, Init(boosIn, stat));
		new(SubMenuRes, Init(stat, firstSource, boosIn));
	end;
	
	procedure MainMenuObj.drawHelp;
	begin
		setcolor(blue);
		SetTextStyle(DefaultFont, HorizDir, 1);
		OutTextXY(20, 420, 'Press right, left, up or down arrow to switch between the button.');
		OutTextXY(20, 440, 'Press ENTER if you want choose this button. Press END if you want exit.');
		OutTextXY(20, 460, 'SMO done by Maschenko Bogdan, group 13534/4, 2019 year');
	end;

	procedure MainMenuObj.drawButtonOfSettingParams;
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
	
	procedure MainMenuObj.drawButtonOfModeling;
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

	procedure MainMenuObj.drawButtonOfResults;
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
	
	procedure MainMenuObj.launchMainMenu;
	var
		button : char;
		ind : longint;
	begin
		
		Initgraph(gm, gh, '');
		
		drawButtonOfSettingParams(7, 15);
		drawButtonOfModeling(4, 15);
		drawButtonOfResults(4, 15);
		drawHelp;
		
		ind := 1;
		button := readkey;
	
		repeat
			
			if ((button = #77) and (ind < 3)) then
				inc(ind)
			else if ((button = #75) and (ind > 1)) then
				dec(ind);
			
			case ind of
				1:
				begin
					drawButtonOfSettingParams(7, 15);
					drawButtonOfModeling(4, 15);
					drawButtonOfResults(4, 15);
					drawHelp;
					button := readkey;
					
					if button = #13 then
					begin
						SubMenuSup^.launchSubmenuOfSUP;
						button := readkey;
					end;
				end;
				
				2:
				begin
					drawButtonOfSettingParams(4, 15);
					drawButtonOfModeling(7,15);
					drawButtonOfResults(4, 15);
					drawHelp;
					button := readkey;
					
					if button = #13 then
					begin
						SubMenuMod^.launchSubmenuMod;
						button := readkey;
					end;
				end;
				
				3:
				begin
					drawButtonOfSettingParams(4, 15);
					drawButtonOfModeling(4, 15);
					drawButtonOfResults(7, 15);
					drawHelp;
					button := readkey;
					
					if button = #13 then
					begin
						SubMenuRes^.launchSubmenuRes;
						button := readkey;
					end;
				end;
			end;
			
		until button = #79;
		
		writerIn^.averageQuantityOfRequestInBufferMSG(stat);
	
		writerIn^.Done;
		
		CloseGraph;
	end;

BEGIN
END.