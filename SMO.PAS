{Main file of project}
program SMO;

	uses Menu;

	var
		MainMenu : p_MainMenu;	

BEGIN
	randomize;
	
	new(MainMenu, Init);
	
	MainMenu^.launchMainMenu;
END.