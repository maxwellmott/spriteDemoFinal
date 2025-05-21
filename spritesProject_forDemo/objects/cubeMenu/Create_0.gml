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
surfaceHeight = 112;

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
wavephoneButtonX		= centerX - 32;
wavephoneButtonY		= centerY - 8;
						
talismanButtonX			= centerX - 28;
talismanButtonY			= centerY - 36;
						
inventoryButtonX		= centerX;
inventoryButtonY		= centerY - 32;
						
wardrobeButtonX			= centerX + 32;
wardrobeButtonY			= centerY - 40;
						
spellbookButtonX		= centerX + 32;
spellbookButtonY		= centerY - 12;

// initialize all draw positions for all buttons
wavephoneButtonDrawX	= wavephoneButtonX;
wavephoneButtonDrawY	= wavephoneButtonY;

talismanButtonDrawX		= talismanButtonX;
talismanButtonDrawY		= talismanButtonY;
						  
inventoryButtonDrawX	= inventoryButtonX;
inventoryButtonDrawY	= inventoryButtonY;
						  
wardrobeButtonDrawX		= wardrobeButtonX;
wardrobeButtonDrawY		= wardrobeButtonY;
						  
spellbookButtonDrawX	= spellbookButtonX;
spellbookButtonDrawY	= spellbookButtonY;

cubeX = centerX;
cubeY = surfaceHeight - 18;

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

var talismansLeft		= talismanButtonX + xDiff - (talismanWidth / 2);
var talismansRight		= talismanButtonX + xDiff + (talismanWidth / 2);
var talismansTop		= talismanButtonY + yDiff - (talismanHeight / 2);
var talismansBottom		= talismanButtonY + yDiff + (talismanHeight / 2);

var wavephoneLeft		= wavephoneButtonX + xDiff - (wavephoneWidth / 2);
var wavephoneRight		= wavephoneButtonX + xDiff + (wavephoneWidth / 2);
var wavephoneTop		= wavephoneButtonY + yDiff - (wavephoneHeight / 2);
var wavephoneBottom		= wavephoneButtonY + yDiff + (wavephoneHeight / 2);

var inventoryLeft		= inventoryButtonX + xDiff - (inventoryWidth / 2);
var inventoryRight		= inventoryButtonX + xDiff + (inventoryWidth / 2);
var inventoryTop		= inventoryButtonY + yDiff - (inventoryHeight / 2);
var inventoryBottom		= inventoryButtonY + yDiff + (inventoryHeight / 2);

var wardrobeLeft		= wardrobeButtonX + xDiff - (wardrobeWidth / 2);
var wardrobeRight		= wardrobeButtonX + xDiff + (wardrobeWidth / 2);
var wardrobeTop			= wardrobeButtonY + yDiff - (wardrobeHeight / 2);
var wardrobeBottom		= wardrobeButtonY + yDiff + (wardrobeHeight / 2);

var spellbookLeft		= spellbookButtonX + xDiff - (spellbookWidth / 2);
var spellbookRight		= spellbookButtonX + xDiff + (spellbookWidth / 2);
var spellbookTop		= spellbookButtonY + yDiff - (spellbookHeight / 2);
var spellbookBottom		= spellbookButtonY + yDiff + (spellbookHeight / 2);

// initialize frame variables for all buttons
talismanButtonFrame		= 0;
wavephoneButtonFrame	= 0;
inventoryButtonFrame	= 0;
wardrobeButtonFrame		= 0;
spellbookButtonFrame	= 0;

// initialize index
index = 0;

// initialize buttonFunctions list
buttonFunctions = ds_list_create();

// add all functions to button functions
buttonFunctions[| CUBE_MENU_BUTTONS.TALISMANS]	= open_teambuilder;
buttonFunctions[| CUBE_MENU_BUTTONS.WAVEPHONE]	= open_wavephone_player;
buttonFunctions[| CUBE_MENU_BUTTONS.INVENTORY]	= open_inventory;
buttonFunctions[| CUBE_MENU_BUTTONS.WARDROBE]	= open_appearance_editor; 
buttonFunctions[| CUBE_MENU_BUTTONS.SPELLBOOK]	= open_spellbook_builder;

selectedFunction = -1;

// create rectangleSurface
cubeMenuSurface = surface_create(surfaceWidth, surfaceHeight);

topOpen = false;