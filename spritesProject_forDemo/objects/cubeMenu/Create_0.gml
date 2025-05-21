// create the mouse
create_once(guiWidth / 2, guiHeight / 2, LAYER.mouse, mouse);

// declare an enumerator containing all phases
enum CUBE_MENU_PHASES {
	OPENING,
	DISPLAY,
	CLOSING,
	HEIGHT,
}

// declare an enumerator containing all buttons
enum CUBE_MENU_BUTTONS {
	TALISMANS,
	WAVEPHONE,
	INVENTORY,
	WARDROBE,
	SPELLBOOK,
	HEIGHT	
}

// initialize index
index = CUBE_MENU_BUTTONS.TALISMANS;

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
wavephoneButtonX	= centerX - 32;
wavephoneButtonY	= centerY - 8;

talismanButtonX		= centerX - 28;
talismanButtonY		= centerY - 36;

inventoryButtonX	= centerX;
inventoryButtonY	= centerY - 32;

wardrobeButtonX		= centerX + 32;
wardrobeButtonY		= centerY - 40;

spellbookButtonX	= centerX + 8;
spellbookButtonY	= centerY - 24;

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
var xDiff = abs((guiWidth / 2) - centerX);
var yDiff = abs((guiHeight / 2) - centerY);

var wavephoneWidth		= sprite_get_width(spr_cubeMenu_wavephoneButton);
var wavephoneHeight		= sprite_get_height(spr_cubeMenu_wavephoneButton);

var talismanWidth		= sprite_get_width(spr_cubeMenu_talismanButton);
var talismanHeight		= sprite_get_height(spr_cubeMenu_talismanButton);

var inventoryWidth		= sprite_get_width(spr_cubeMenu_inventoryButton);
var inventoryHeight		= sprite_get_height(spr_cubeMenu_inventoryButton);

var wardrobeWidth		= sprite_get_width(spr_cubeMenu_mirrorButton);
var wardrobeHeight		= sprite_get_height(spr_cubeMenu_mirrorButton);

var spellbookWidth		= sprite_get_width(spr_cubeMenu_spellbookButton);
var spellbookHeight		= sprite_get_height(spr_cubeMenu_spellbookButton);

// set all bbox values 
bboxLefts		= ds_list_create();
bboxRights		= ds_list_create();
bboxTops		= ds_list_create();
bboxBottoms		= ds_list_create();

// initialize index
index = -1;

// create rectangleSurface
cubeMenuSurface = surface_create(surfaceWidth, surfaceHeight);

topOpen = false;