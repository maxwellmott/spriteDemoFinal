if (instance_exists(onlineEnemy)) {

	data = ds_map_create();

	client = network_create_socket(network_socket_udp);	
	network_connect_raw(client, SERVER_ADDRESS, 80);

	onlineBuffer = buffer_create(120, buffer_fixed, 120);
}

alarmTime = 4;

// get talismans list
var talismanString = player.talismanString;
talismanList = ds_list_create();
decode_list(talismanString, talismanList);

// convert all spriteIDs from strings to reals
var i = 0;	repeat (ds_list_size(talismanList)) {
	talismanList[| i] = real(talismanList[| i]);
	
	i++;
}

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

nameSlotRowOne		= 17;
nameSlotRowTwo		= 48;
nameSlotRowThree	= 80;
nameSlotRowFour		= 112;
nameSlotRowFive		= 141;

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
selectedSpriteSlot = -1;

// set selectedNameSlot
selectedNameSlot = 0;

// set rowWidth and columnHeight
rowWidth = 3;
columnHeight = 3;

// get rosterHeight
rosterHeight = ds_list_size(talismanList);

// get columnHeight
rowCount = (rosterHeight div rowWidth);

// get currentRow and currentColumn
currentRow = selectedNameSlot div rowWidth;
currentColumn = (rowWidth - 1) - ((selectedNameSlot + 1) mod rowWidth);

// initialize bottomRowNum
bottomRowNum	= 0;

// get current team
teamList = ds_list_create();

decode_list(player.teamString, teamList);

// initialize row frames
rowOneFrame			= 0;
rowTwoFrame			= 0;
rowThreeFrame		= 0;
rowFourFrame		= 0;
rowFiveFrame		= 0;

// initialize "last" variables
lastBottomRowNum	= bottomRowNum;
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
var start = (bottomRowNum * rowWidth);

selectorIndex = selectedNameSlot - start;

// intialize selectorX and selectorY
switch (selectorIndex) {
	case 0:		selectorX = nameSlotColumnOne;		 selectorY = nameSlotRowTwo;	break;
	case 1:		selectorX = nameSlotColumnTwo;		 selectorY = nameSlotRowTwo;	break;
	case 2:		selectorX = nameSlotColumnThree;	 selectorY = nameSlotRowTwo;	break;
	
	case 3:		selectorX = nameSlotColumnOne;		 selectorY = nameSlotRowThree;	break;
	case 4:		selectorX = nameSlotColumnTwo;		 selectorY = nameSlotRowThree;	break;
	case 5:		selectorX = nameSlotColumnThree;	 selectorY = nameSlotRowThree;	break;
	
	case 6:		selectorX = nameSlotColumnOne;		 selectorY = nameSlotRowFour;	break;
	case 7:		selectorX = nameSlotColumnTwo;		 selectorY = nameSlotRowFour;	break;
	case 8:		selectorX = nameSlotColumnThree;	 selectorY = nameSlotRowFour;	break;
}

selectorFrame = 0;

selectorBufferWidth = (sprite_get_width(spr_teambuilderNameSlot) / 2) + (sprite_get_width(spr_teambuilderSelector) / 2);

rowShiftNum = 0;

acceptString = "";

if (global.controllerType == controllerTypes.keyboard) {
	acceptString = "PRESS ENTER TO ACCEPT";
}

if (global.controllerType == controllerTypes.gamepad) {
	acceptString = "PRESS START TO ACCEPT";	
}

acceptStringX = guiWidth / 2;
acceptStringY = 152;

asHeight = 9;

onlineWaiting = false;