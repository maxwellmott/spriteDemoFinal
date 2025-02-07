if (instance_exists(onlineEnemy)) {

	data = ds_map_create();

	client = network_create_socket(network_socket_udp);	
	network_connect_raw(client, SERVER_ADDRESS, PORT_NUM);

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

// get current team
teamList = ds_list_create();

decode_list(player.teamString, teamList);

// initialize visible row count
visibleRowCount = 4;

// set spriteslot positions
spriteSlotOneX		= 33;
spriteSlotTwoX		= 96;
spriteSlotThreeX	= 159;
spriteSlotFourX		= 222;

spriteSlotY			= 212;

// set nameslot positions
nameSlotColumnOne	= 39;
nameSlotColumnTwo	= 119;

nameSlotRowOne		= 24;
nameSlotRowTwo		= 44;
nameSlotRowThree	= 76;
nameSlotRowFour		= 108;
nameSlotRowFive		= 140;
nameSlotRowSix		= 160;

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

teamSlotLeftList	= ds_list_create();
teamSlotRightList	= ds_list_create();
teamSlotTopList		= ds_list_create();
teamSlotBottomList	= ds_list_create();

var i = 0;	repeat (ds_list_size(teamList)) {
	switch (i) {
		case 0:
			teamSlotLeftList[| i]	= spriteSlotOne_bboxLeft;
			teamSlotRightList[| i]	= spriteSlotOne_bboxRight;
			teamSlotTopList[| i]	= spriteSlot_bboxTop;
			teamSlotBottomList[| i] = spriteSlot_bboxBottom;
		break;
			
		case 1:
			teamSlotLeftList[| i]	= spriteSlotTwo_bboxLeft;
			teamSlotRightList[| i]	= spriteSlotTwo_bboxRight;
			teamSlotTopList[| i]	= spriteSlot_bboxTop;
			teamSlotBottomList[| i] = spriteSlot_bboxBottom;
		break;
		
		case 2:
			teamSlotLeftList[| i]	= spriteSlotThree_bboxLeft;
			teamSlotRightList[| i]	= spriteSlotThree_bboxRight;
			teamSlotTopList[| i]	= spriteSlot_bboxTop;
			teamSlotBottomList[| i] = spriteSlot_bboxBottom;
		break;
		
		case 3:
			teamSlotLeftList[| i]	= spriteSlotFour_bboxLeft;
			teamSlotRightList[| i]	= spriteSlotFour_bboxRight;
			teamSlotTopList[| i]	= spriteSlot_bboxTop;
			teamSlotBottomList[| i] = spriteSlot_bboxBottom;
		break;
	}
	
	// increment i
	i++;	
}

// set selectedTeamSlot
selectedTeamSlot = -1;

// set selectedNameSlot
selectedNameSlot = 0;

// set rowWidth and columnHeight
rowWidth = 2;
columnHeight = 4;

// get rosterHeight
rosterHeight = ds_list_size(talismanList);

// get columnHeight
rowCount = rosterHeight div rowWidth;

// get currentRow and currentColumn
currentRow = selectedNameSlot div rowWidth;
currentColumn = (rowWidth - 1) - ((selectedNameSlot + 1) mod rowWidth);

// initialize bottomRowNum
bottomRowNum	= 0;

// initialize row frames
rowOneFrame			= 0;
rowTwoFrame			= 0;
rowThreeFrame		= 0;
rowFourFrame		= 0;
rowFiveFrame		= 0;
rowSixFrame			= 0;

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
	case 0:		selectorX = nameSlotColumnOne;		selectorY = nameSlotRowTwo;		break;
	case 1:		selectorX = nameSlotColumnTwo;		selectorY = nameSlotRowTwo;		break;
	
	case 2:		selectorX = nameSlotColumnOne;		selectorY = nameSlotRowThree;	break;
	case 3:		selectorX = nameSlotColumnTwo;		selectorY = nameSlotRowThree;	break;
	
	case 4:		selectorX = nameSlotColumnOne;		selectorY = nameSlotRowFour;	break;
	case 5:		selectorX = nameSlotColumnTwo;		selectorY = nameSlotRowFour;	break;
	
	case 6:		selectorX = nameSlotColumnOne;		selectorY = nameSlotRowFive;	break; 
	case 7:		selectorX = nameSlotColumnTwo;		selectorY = nameSlotRowFive;	break;
}

var nsw = sprite_get_width(spr_teambuilderNameSlot);
var nsh = sprite_get_height(spr_teambuilderNameSlot);

nameSlotLeftList	= ds_list_create();
nameSlotRightList	= ds_list_create();
nameSlotTopList		= ds_list_create();
nameSlotBottomList	= ds_list_create();

var i = 0;	repeat (columnHeight * rowWidth) {
	switch (i) {
		case 0:
			nameSlotLeftList[| i]	= nameSlotColumnOne - (nsw / 2);
			nameSlotRightList[| i]	= nameSlotColumnOne + (nsw / 2);
			nameSlotTopList[| i]	= nameSlotRowOne - (nsh / 2);
			nameSlotBottomList[| i] = nameSlotRowOne + (nsh / 2);
		break;
		
		case 1:
			nameSlotLeftList[| i]	= nameSlotColumnTwo - (nsw / 2);
			nameSlotRightList[| i]	= nameSlotColumnTwo + (nsw / 2);
			nameSlotTopList[| i]	= nameSlotRowOne - (nsh / 2);
			nameSlotBottomList[| i] = nameSlotRowOne + (nsh / 2);
		break;
		
		case 2:
			nameSlotLeftList[| i]	= nameSlotColumnOne - (nsw / 2);
			nameSlotRightList[| i]	= nameSlotColumnOne + (nsw / 2);
			nameSlotTopList[| i]	= nameSlotRowTwo - (nsh / 2);
			nameSlotBottomList[| i] = nameSlotRowTwo + (nsh / 2);
		break;
		
		case 3:
			nameSlotLeftList[| i]	= nameSlotColumnTwo - (nsw / 2);
			nameSlotRightList[| i]	= nameSlotColumnTwo + (nsw / 2);
			nameSlotTopList[| i]	= nameSlotRowTwo - (nsh / 2);
			nameSlotBottomList[| i] = nameSlotRowTwo + (nsh / 2);
		break;
		
		case 4:
			nameSlotLeftList[| i]	= nameSlotColumnOne - (nsw / 2);
			nameSlotRightList[| i]	= nameSlotColumnOne + (nsw / 2);
			nameSlotTopList[| i]	= nameSlotRowThree - (nsh / 2);
			nameSlotBottomList[| i] = nameSlotRowThree + (nsh / 2);
		break;
		
		case 5:
			nameSlotLeftList[| i]	= nameSlotColumnTwo - (nsw / 2);
			nameSlotRightList[| i]	= nameSlotColumnTwo + (nsw / 2);
			nameSlotTopList[| i]	= nameSlotRowThree - (nsh / 2);
			nameSlotBottomList[| i] = nameSlotRowThree + (nsh / 2);
		break;
		
		case 6:
			nameSlotLeftList[| i]	= nameSlotColumnOne - (nsw / 2);
			nameSlotRightList[| i]	= nameSlotColumnOne + (nsw / 2);
			nameSlotTopList[| i]	= nameSlotRowFour - (nsh / 2);
			nameSlotBottomList[| i] = nameSlotRowFour + (nsh / 2);
		break;
		
		case 7:
			nameSlotLeftList[| i]	= nameSlotColumnTwo - (nsw / 2);
			nameSlotRightList[| i]	= nameSlotColumnTwo + (nsw / 2);
			nameSlotTopList[| i]	= nameSlotRowFour - (nsh / 2);
			nameSlotBottomList[| i] = nameSlotRowFour + (nsh / 2);
		break;
	}
	
	// increment i
	i++;
}

rowShiftNum = 0;

msg = "";
msgX = 79;
msgY = 12;

if (global.controllerType == controllerTypes.keyboard) {
	msg = "PRESS ENTER TO ACCEPT";
}

if (global.controllerType == controllerTypes.gamepad) {
	msg = "PRESS START TO ACCEPT";	
}

acceptStringX = guiWidth / 2;
acceptStringY = 152;

asHeight = 9;

onlineWaiting = false;

recentSelection = false;

currentSprite		=	-1;
currentFire			=	-1;
currentWater		=	-1;
currentStorm		=	-1;
currentEarth		=	-1;
currentAgility		=	-1;
currentAlign		=	-1;
currentSize			=	-1;
currentAbility		=	-1;
currentPower		=	-1;
currentResistance	=	-1;
currentLuck			=	-1;

currentAbilityDesc	=	-1;
currentAbilityName	=	-1

abilityDescWidth = 89;

teambuilder_get_sprite_parameters();

currentSpriteX = 208;
currentSpriteY = 36;

statColumnOne = 173;
statColumnTwo = 221;

statRowOne = 77;
statRowTwo = 89;
statRowThree = 101;
statRowFour = 113;

abilityNameX = 206;
abilityNameY = 134;

abilityDescX = 208;
abilityDescY = 154;

statCoverageScore = -1;
spellUsageScore = -1;

teambuilder_stat_coverage_calculate_score();
teambuilder_spellbook_usage_calculate_score();

statCoverageX = 52;
statCoverageY = 191;

spellUsageX = 201;
spellUsageY = 191;

selectorMoved = false;

global.roomBuilt = true;

spotClicked = true;