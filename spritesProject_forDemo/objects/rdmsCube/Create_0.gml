// create the mouse
create_once(guiWidth / 2, guiHeight / 2, LAYER.mouse, mouse);

// declare an enumerator containing all phases
enum CUBE_MENU_PHASES {
	OPENING,
	DISPLAY,
	CLOSING,
	HEIGHT,
}

surfaceWidth = 112;
surfaceHeight = 100;

centerX = surfaceWidth / 2;
centerY = surfaceHeight / 2;

// initialize rectangleWidth and rectangleHeight
rectangleWidth = 112;
rectangleHeight = 80;

// initialize the phase variable
phase = CUBE_MENU_PHASES.OPENING;

// initialize topOpenFrame and openingFinalFrame
topOpenFrame = 10;
openingFinalFrame = 12;

// initialize closingFinalFrame
closingFinalFrame = 10;

// initialize surfaceY
surfaceY = player.y + 26 - (surfaceWidth / 2);

// determine surfaceX based on whether the player is further to the left or the right
// check if player is further to the right
if (player.x > (overworld.locationWidth / 2)) {
	surfaceX = player.x - 60 - (surfaceWidth / 2);
}
// if the player is further to the left
else {
	surfaceX = player.x + 60 + (surfaceWidth / 2);	
}

// initialize all button positions
wavephoneButtonX	= (surfaceWidth / 2) - 25;
wavephoneButtonY	= (surfaceHeight / 2) - 58;

talismanButtonX		= (surfaceWidth / 2) - 27;
talismanButtonY		= (surfaceHeight / 2) - 102;

inventoryButtonX	= surfaceWidth / 2;
inventoryButtonY	= (surfaceHeight / 2) - 88;

wardrobeButtonX		= (surfaceWidth / 2) + 31;
wardrobeButtonY		= (surfaceHeight / 2) - 102;

spellbookButtonX	= (surfaceWidth / 2) + 24;
spellbookButtonY	= (surfaceHeight / 2) - 71;

cubeX = centerX;
cubeY = surfaceHeight - 9;

// initialize rectangleY and rectTargetY
rectangleY = centerY - ((surfaceHeight - rectangleHeight) / 2);
rectTargetY = rectangleY - rectangleHeight;

// initialize all bbox lists

// set all bbox values 

// initialize index
index = -1;

// create rectangleSurface
cubeMenuSurface = surface_create(surfaceWidth, surfaceHeight);

topOpen = false;