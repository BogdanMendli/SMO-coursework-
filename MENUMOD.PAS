{Draw submenu for button modeling}
Unit MenuMod;
Interface

	uses graph, crt, Statist, Boos;
	
	type
		p_MenuMod = ^MenuModObj;
		MenuModObj = object
			private
			
				{instance of class Boos and Statist}
				stat : p_Statistic;
				boosIn : p_Boos;
			
			public
			
				{initialization the field}
				constructor Init(boosIn_ : p_Boos; stat_ : p_Statistic);
				{draw osi koordinat for graphics}
				procedure drawOsKoord;
				{draw button modeling with building graphics P(kol)}
				procedure drawButtonModelingWithGraphics(color, fraim : longint);
				{draw button modeling without building graphics P(kol)}
				procedure drawButtonModelingWithoutGraphics(color, fraim : longint);
				{write a tips}
				procedure drawHelp;
				{draw button of setting params}
				procedure drawButtonOfSettingParams(color, fraim : longint);
				{draw button of modeling}
				procedure drawButtonOfModeling(color, fraim : longint);
				{draw button of results}
				procedure drawButtonOfResults(color, fraim : longint);
				{draw black background}
				procedure drawBackground;
				{launch submenu of button modeling}
				procedure launchSubmenuMod;
		end;
		
Implementation

	constructor MenuModObj.Init;
	begin
		boosIn := boosIn_;
		stat := stat_;
	end;
	
	procedure MenuModObj.drawButtonModelingWithGraphics;
	begin
		setcolor(color);
		setfillstyle(1, color);
		Bar(230, 100, 380, 190);
		setcolor(fraim);
		Rectangle(230, 100, 380, 190);
		setcolor(black);
		SetTextStyle(DefaultFont, HorizDir, 1);
		OutTextXY(240, 120, 'Start modeling');
		OutTextXY(250, 140, 'with bulding');
		OutTextXY(240, 160, 'graphics P(kol)');
		setcolor(fraim);
		line(305, 100, 305, 91);
	end;
	
	procedure MenuModObj.drawButtonModelingWithoutGraphics;
	begin
		setcolor(color);
		setfillstyle(1, color);
		Bar(230, 200, 380, 290);
		setcolor(fraim);
		Rectangle(230, 200, 380, 290);
		setcolor(black);
		SetTextStyle(DefaultFont, HorizDir, 1);
		OutTextXY(240, 220, 'Start modeling');
		OutTextXY(245, 240, 'without bulding');
		OutTextXY(240, 260, 'graphics P(kol)');
		setcolor(fraim);
		line(305, 200, 305, 190);
	end;
	
	procedure MenuModObj.drawHelp;
	begin
		setcolor(blue);
		SetTextStyle(DefaultFont, HorizDir, 1);
		OutTextXY(20, 420, 'Press right, left, up or down arrow to switch between the button.');
		OutTextXY(20, 440, 'Press ENTER if you want choose this button. Press END if you want exit.');
		OutTextXY(20, 460, 'SMO done by Maschenko Bogdan, group 13534/4, 2019 year');
	end;

	procedure MenuModObj.drawButtonOfSettingParams;
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
	
	procedure MenuModObj.drawButtonOfModeling;
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

	procedure MenuModObj.drawButtonOfResults;
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
	
	procedure MenuModObj.drawBackground;
	begin
		setcolor(black);
		setfillstyle(1, black);
		Bar(0, 0, 640, 480);
	end;
	
	procedure MenuModObj.drawOsKoord;
	var
		button : char;
		i : longint;
		help : string[10];
	begin
		drawBackground;
		setcolor(12);
		SetTextStyle(DefaultFont, HorizDir, 2);
		OutTextXY(80, 10, 'P*(kol) for 2 Source 1 simulation');
		OutTextXY(195, 460, 'Press END to exit');
		setfillstyle(1, white);
		Bar(40, 60, 41, 420);
		Bar(40, 419, 590, 420);
		setcolor(15);
		SetTextStyle(DefaultFont, HorizDir, 2);
		OutTextXY(35, 40, 'P*');
		OutTextXY(605, 413, 'K');
		SetTextStyle(DefaultFont, HorizDir, 1);
		
		for i := 1 to 10 do
		begin
			Bar(36, 60 + (i - 1) * 36, 45, 61 + (i - 1) * 36);
			str((0.1 * i):2:1, help);
			OutTextXY(10, 57 + (10 - i) * 36, help);
		end;
		
		for i := 1 to 5 do
		begin
			Bar(40 + 110 * i, 415, 41 + 110 * i, 424);
			str(round((boosIn^.getKmin / 5)  * 7 * i), help);
			OutTextXY(22 + 110 * i, 435, help);
		end;
		
	end;
	
	procedure MenuModObj.launchSubmenuMod;
	var
		buttonMod : char;
		indMod : longint;
	begin
		drawButtonModelingWithGraphics(10, 15);
		drawButtonModelingWithoutGraphics(4, 15);
		
		indMod := 1;
		buttonMod := readkey;
		
		repeat
		
			if ((buttonMod = #80) and (indMod < 2)) then
				inc(indMod)
			else if ((buttonMod = #72) and (indMod > 1)) then
				dec(indMod);
				
			case indMod of
				1:
				begin
					drawButtonModelingWithGraphics(10, 15);
					drawButtonModelingWithoutGraphics(4, 15);
					buttonMod := readkey;
					
					if buttonMod = #13 then
					begin		
						drawOsKoord;
						boosIn^.startSimulation(true);
						
						repeat
							buttonMod := readkey;
						until buttonMod = #79;
						
						drawBackground;
						drawButtonOfSettingParams(4, 15);
						drawButtonOfModeling(7,15);
						drawButtonOfResults(4, 15);
						drawHelp;
						drawButtonModelingWithGraphics(10, 15);
						drawButtonModelingWithoutGraphics(4, 15);
						buttonMod := readkey;
					end;
				end;
				
				2:
				begin
					drawButtonModelingWithGraphics(4, 15);
					drawButtonModelingWithoutGraphics(10, 15);
					buttonMod := readkey;
					
					if buttonMod = #13 then
					begin
						drawBackground;
						setcolor(12);
						SetTextStyle(DefaultFont, HorizDir, 3);
						OutTextXY(100, 200, 'Simulation started');
						
						boosIn^.startSimulation(false);
						delay(25000);
						
						drawBackground;
						setcolor(12);
						SetTextStyle(DefaultFont, HorizDir, 3);
						OutTextXY(100, 170, 'Simulation ends');
						OutTextXY(50, 230, 'Press END to continue');
						
						repeat
							buttonMod := readkey;
						until buttonMod = #79;
						
						drawBackground;
						drawButtonOfSettingParams(4, 15);
						drawButtonOfModeling(7,15);
						drawButtonOfResults(4, 15);
						drawHelp;
						drawButtonModelingWithGraphics(4, 15);
						drawButtonModelingWithoutGraphics(10, 15);
						buttonMod := readkey;
					end;
				end;
			end;
			
			if buttonMod = #79 then
			begin
				drawButtonModelingWithGraphics(0, 0);
				drawButtonModelingWithoutGraphics(0, 0);
			end;
		
		until buttonMod = #79;
	end;

BEGIN
END.