// get talismans list
var talismanString = player.talismans;
talismanList = ds_list_create();
decode_list(talismanString, talismanList);

// initialize visible row count
visibleRowCount = 3;

// set spriteslot positions
spriteSlotOneX		= 32;
spriteSlotTwoX		= 96;
spriteSlotThreeX	= 160;
spriteSlotFourX		= 224;

spriteSlotY			= 192;

// set nameslot positions
nameSlotColumnOne	= 48;
nameSlotColumnTwo	= 128;
nameSlotColumnThree	= 208;

nameSlotRowOne		= 16;
nameSlotRowTwo		= 48;
nameSlotRowThree	= 80;
nameSlotRowFour		= 112;
nameSlotRowFive		= 144;

// set bbox dimensions for spriteslots
var w = sprite_get_width(spr_teambuilderSpriteSlot);
var h = sprite_get_height(spr_teambuilderSpriteSlot);

spriteSlot_bboxTop			= spriteSlotY - (h / 2);
spriteSlot_bboxBottom		= spriteSlotY + (h / 2);
							
spriteSlotOne_bboxLeft		= spriteSlotOneX - (w / 2);
spriteSlotOne_bboxRight		= spriteSlotOneX + (w / 2);
							
spriteSlotTwo_bboxLeft		= spriteSlotTwoX - (w / 2);
spriteSlotTwo_bboxRight		= spriteSlotTwoX + (w / 2);

spriteSlotThree_bboxLeft	= spriteSlotThreeX - (w / 2);
spriteSlotThree_bboxRight	= spriteSlotThreeX + (w / 2);

spriteSlotFour_bboxLeft		= spriteSlotFourX - (w / 2);
spriteSlotFour_bboxRight	= spriteSlotFourX + (w / 2);

// set selectedSpriteSlot
selectedSpriteSlot = 0;

// set selectedNameSlot
selectedNameSlot = 0;

// set rowWidth
rowWidth = 3;

// get rosterHeight
rosterHeight = ds_list_size(talismanList);

// get columnHeight
columnHeight = (rosterHeight div rowWidth) + 1;

// get currentRow and currentColumn
currentRow = selectedNameSlot div rowWidth;
currentColumn = (rowWidth - 1) - ((selectedNameSlot + 1) mod rowWidth);

// set bottomRowNum and topRowNum (these will be used to 
// determine if there are names above or below the 3 rows 
// being displayed fully)
bottomRowNum	= selectedNameSlot div rowWidth;
topRowNum		= bottomRowNum + 4;

// get current team
teamList = player.team;

// initialize row frames
rowOneFrame			= 0;
rowTwoFrame			= 0;
rowThreeFrame		= 0;
rowFourFrame		= 0;
rowFiveFrame		= 0;

// initialize "last" variables
lastBottomRowNum	= bottomRowNum;
lastTopRowNum		= topRowNum;
lastSelectedName	= selectedNameSlot;

// initialize optionsChangingUp
optionsChangingUp = false;

// intialize optionsChangingDown
optionsChangingDown = false;

// build the sprite grid and keep it open
spriteGrid = ds_grid_create(SPRITE_PARAMS.HEIGHT, SPRITES.HEIGHT);
decode_grid(global.allSprites, spriteGrid);

// initialize selectorIndex---
// find the first index
var start = (bottomRowNum * rowWidth) - 1;

selectorIndex = selectedNameSlot - start;

// intialize selectorX and selectorY
switch (selectorIndex) {
	case 0:		selectorX = nameSlotColumnOne;		 selectorY = nameSlotRowOne;	break;
	case 1:		selectorX = nameSlotColumnTwo;		 selectorY = nameSlotRowOne;	break;
	case 2:		selectorX = nameSlotColumnThree;	 selectorY = nameSlotRowOne;	break;
	
	case 3:		selectorX = nameSlotColumnOne;		 selectorY = nameSlotRowTwo;	break;
	case 4:		selectorX = nameSlotColumnTwo;		 selectorY = nameSlotRowTwo;	break;
	case 5:		selectorX = nameSlotColumnThree;	 selectorY = nameSlotRowTwo;	break;
	
	case 6:		selectorX = nameSlotColumnOne;		 selectorY = nameSlotRowThree;	break;
	case 7:		selectorX = nameSlotColumnTwo;		 selectorY = nameSlotRowThree;	break;
	case 8:		selectorX = nameSlotColumnThree;	 selectorY = nameSlotRowThree;	break;
}

selectorFrame = 0;