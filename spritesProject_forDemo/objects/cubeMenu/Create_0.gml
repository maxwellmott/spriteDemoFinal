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

// initialize openingFinalFrame
openingFinalFrame = 12;

// initialize closingFinalFrame
closingFinalFrame = 10;

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
rectangleY = 40;
rectTargetY = rectangleY - rectangleHeight;

// initialize frontLightCount
frontLightCount = 0;

// initialize glowBarFrameCount
glowBarFrameCount = 20;

// initialize frontLightFrameCount
frontLightFrameCount = 8;

// initialize frontLightCycle
frontLightCycle = 8;

// initialize glowBarFrame
glowBarFrame = 0;

// initialize all bbox lists


// set all bbox values 


// initialize index
index = -1;

// create rectangleSurface
cubeMenuSurface = surface_create(surfaceWidth, surfaceHeight);

topOpen = false;