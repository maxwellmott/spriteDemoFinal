/// @description Insert description here
// You can write your code in this editor
if (instance_exists(onlineEnemy)) {

	data = ds_map_create();

	client = network_create_socket(network_socket_udp);	
	network_connect_raw(client, SERVER_ADDRESS, 3000);

	onlineBuffer = buffer_create(120, buffer_fixed, 120);
}

if !(instance_exists(mouse))	instance_create_depth(mouse_x, mouse_y, get_layer_depth(LAYER.mouse), mouse);

teamList = ds_list_create();

decode_list(player.teamString, teamList);

spriteGrid = ds_grid_create(SPRITE_PARAMS.HEIGHT, SPRITES.HEIGHT);

decode_grid(global.allSprites, spriteGrid);

spriteNameList = ds_list_create();
usableSpellsLists = ds_list_create();

var i = 0;	repeat (4) {
	var list = ds_list_create();
	
	var spriteID = teamList[| i];
	
	var spellString = spriteGrid[# SPRITE_PARAMS.SPELL_LIST, spriteID];
	
	decode_list(spellString, list);
	
	var name = spriteGrid[# SPRITE_PARAMS.NAME, spriteID];
	
	usableSpellsLists[| i] = list;
	spriteNameList[| i] = name;
	
	// increment i
	i++;
}

ds_grid_destroy(spriteGrid);

knownSpellList = ds_list_create();

decode_list(player.knownSpellString, knownSpellList);

spellCount = ds_list_size(knownSpellList);

spellBookList = ds_list_create();

decode_list(player.spellBookString, spellBookList);

spellGrid = ds_grid_create(SPELL_PARAMS.HEIGHT, SPELLS.HEIGHT);

decode_grid(global.allSpells, spellGrid);

squareBarX = guiWidth / 2;
squareBarY = 75;

infoBannerX = 64;
infoBannerY = 154;

rightArrowFrame = 0;
leftArrowFrame = 0;

rightArrowX = 234;
leftArrowX = 21;

arrowY = 21;

spellNameFrame = 0;

changingSpell = false;

currentSpellIndex = 0;

currentSpellID = knownSpellList[| currentSpellIndex];

infoBannerWidth = sprite_get_width(spr_spellInfoBanner);

spellInfoString = spellGrid[# SPELL_PARAMS.DESCRIPTION, currentSpellID];

// initialize displayingSpellSelector
addButtonFrame = 0;

displayingSpellSelector = true;

addSpellButtonX = guiWidth / 2;
addSpellButtonY = 50;

buttonWidth		= sprite_get_width(spr_addSpellButton);
buttonHeight	= sprite_get_height(spr_addSpellButton);

addButton_bboxLeft		= addSpellButtonX - (buttonWidth / 2);
addButton_bboxRight		= addSpellButtonX + (buttonWidth / 2);

addButton_bboxTop		= addSpellButtonY - (buttonWidth / 2);
addButton_bboxBottom	= addSpellButtonY + (buttonWidth / 2);

spriteNameSlotOneY		= 107;
spriteNameSlotTwoY		= 138;
spriteNameSlotThreeY	= 169;
spriteNameSlotFourY		= 200;

spriteNameSlotX	= 176;

usableSpellCheckX = 238;

spellNameX = guiWidth / 2;
spellNameY = 21;

currentSpellName = spellGrid[# SPELL_PARAMS.NAME, currentSpellID];

ditherBarOneY	= 25;
ditherBarTwoY	= 73;
ditherBarThreeY = 121;
ditherBarFourY	= 169;
ditherBarFiveY	= 217;

ditherBarX = guiWidth / 2;

squareWallX = guiWidth / 2;

nameSlotRowOne		= 38;
nameSlotRowTwo		= 86;
nameSlotRowThree	= 134;
nameSlotRowFour		= 182;

nameSlotColumnOne = 76;
nameSlotColumnTwo = 199;

infoSlotRowOne		= 60;
infoSlotRowTwo		= 108;
infoSlotRowThree	= 156;
infoSlotRowFour		= 204;

infoSlotColumnOne = 64;
infoSlotColumnTwo = 190;

deleteColumnOne = 15;
deleteColumnTwo = 138;

deleteOneFrame		= 0;
deleteTwoFrame		= 0;
deleteThreeFrame	= 0;
deleteFourFrame		= 0;
deleteFiveFrame		= 0;
deleteSixFrame		= 0;
deleteSevenFrame	= 0;
deleteEightFrame	= 0;

var w = sprite_get_width(spr_removeSpellButton);
var h = sprite_get_height(spr_removeSpellButton);

deleteColumnOne_bboxLeft	= deleteColumnOne - (w / 2);
deleteColumnOne_bboxRight	= deleteColumnOne + (w / 2);

deleteColumnTwo_bboxLeft	= deleteColumnTwo - (w / 2);
deleteColumnTwo_bboxRight	= deleteColumnTwo + (w / 2);

deleteRowOne_bboxTop	= nameSlotRowOne - (h / 2);
deleteRowOne_bboxBottom = nameSlotRowOne + (h / 2);

deleteRowTwo_bboxTop	= nameSlotRowTwo - (h / 2);
deleteRowTwo_bboxBottom = nameSlotRowTwo + (h / 2);

deleteRowThree_bboxTop		= nameSlotRowThree - (h / 2);
deleteRowThree_bboxBottom	= nameSlotRowThree + (h / 2);

deleteRowFour_bboxTop		= nameSlotRowFour - (h / 2);
deleteRowFour_bboxBottom	= nameSlotRowFour + (h / 2);

deletePressed = false;

onlineWaiting = false;

acceptString = "";

if (global.controllerType == controllerTypes.keyboard) {
	acceptString = "PRESS ENTER TO ACCEPT";
}

if (global.controllerType == controllerTypes.gamepad) {
	acceptString = "PRESS START TO ACCEPT";	
}

global.roomBuilt = true;