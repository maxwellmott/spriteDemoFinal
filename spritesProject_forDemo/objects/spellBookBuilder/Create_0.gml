// this variable stores the spell slot that is currently being "inspected" (resets to -1 when not inspecting)
displaySpell = -1;

// check if we are setting up an online match
if (instance_exists(onlineEnemy)) {
	// initialize data map
	data = ds_map_create();

	// intialize socket and connect to server port
	client = network_create_socket(network_socket_udp);	
	network_connect_raw(client, SERVER_ADDRESS, 3000);

	// initialize onlineBuffer
	onlineBuffer = buffer_create(120, buffer_fixed, 120);
}

// create the mouse if necessary
create_once(guiWidth / 2, guiHeight / 2, LAYER.mouse, mouse);

// initialize teamList
teamList = ds_list_create();

// decode player's currentTeam into teamList
decode_list(player.currentTeam, teamList);

// initialize spriteGrid
spriteGrid = ds_grid_create(SPRITE_PARAMS.HEIGHT, SPRITES.HEIGHT);

// decode sprite master grid into spriteGrid
decode_grid(global.allSprites, spriteGrid);

// initialize spriteNameList and usableSpellsLists
spriteNameList = ds_list_create();
usableSpellsLists = ds_list_create();

// use a repeat loop to populate the lists of names and usable spellsl lists
var i = 0;	repeat (4) {
	// initialize a temp list
	var list = ds_list_create();
	
	// get the spriteID stored at i on the team list
	var spriteID = teamList[| i];
	
	// get the string of usable spells stored for this sprite on the sprite grid
	var spellString = spriteGrid[# SPRITE_PARAMS.SPELL_LIST, spriteID];
	
	// decode that string to the temp list
	decode_list(spellString, list);
	
	// get the name of the current sprite
	var name = spriteGrid[# SPRITE_PARAMS.NAME, spriteID];
	
	// add the usable spells list to the usableSpellsLists list
	usableSpellsLists[| i] = list;
	
	// add the name to the spriteNameList
	spriteNameList[| i] = name;
	
	// increment i
	i++;
}

// destroy the spriteGrid
ds_grid_destroy(spriteGrid);

// initialize the knownSpellList
knownSpellList = ds_list_create();

// decode the player's knownSpells to the knownSpellList
decode_list(player.knownSpells, knownSpellList);

// initialize categoryChanging
categoryChanging = false;

// initialize all categoryLists list
categoryLists = ds_list_create();

// initialize currentCategory
currentCategory = SPELL_TYPES.HEIGHT;

// initialize categoryString
categoryString = spell_type_get_string(currentCategory);

// use a repeat loop to initialize all categoryLists on categoryLists list
var i = SPELL_TYPES.HEIGHT;	repeat (SPELL_TYPES.HEIGHT + 1) {
	categoryLists[| i] = ds_list_create();
	
	// increment i
	i--;
}

// initialize the spellBookList
spellBookList = ds_list_create();

// decode the player's currentSpellBook to the spellBookList
decode_list(player.currentSpellBook, spellBookList);

// initialize the spellGrid
spellGrid = ds_grid_create(SPELL_PARAMS.HEIGHT, SPELLS.HEIGHT);

// decode the spell master grid to the spellGrid
decode_grid(global.allSpells, spellGrid);

// use a repeat loop to populate categoryLists
var i = 0;	repeat (ds_list_size(knownSpellList)) {
	// get the spell at i in knownSpellList
	var s = knownSpellList[| i];
	
	// add the spell to the any categoryList
	ds_list_add(categoryLists[| SPELL_TYPES.HEIGHT], real(s));
	
	// get the spell's type
	var t = spellGrid[# SPELL_PARAMS.TYPE, s];
	
	// add the spell's ID to the respective categoryList
	ds_list_add(categoryLists[| t], real(s));
	
	// increment i
	i++;		
}

// initialize selectedSpellSlot
selectedSpellSlot = -1;

// initialize currentSpellIndex
currentSpellIndex = 0;

// initialize currentSpell
currentSpell = real(knownSpellList[| currentSpellIndex]);

// get all currentSpell params
builder_load_spell_params();

// initialize onlineWaiting
onlineWaiting = false;

// initialize acceptString
acceptString = "";

// set accept string based on whether you're about to have an online
// match and also what type of controller you're using
if (instance_exists(onlineEnemy)) {
	if (global.controllerType == controllerTypes.keyboard) {
		acceptString = "PRESS ENTER TO SUBMIT";
	}

	if (global.controllerType == controllerTypes.gamepad) {
		acceptString = "PRESS START TO SUBMIT";	
	}
}
else {
	if (global.controllerType == controllerTypes.keyboard) {
		acceptString = "PRESS ENTER TO FINALIZE";
	}

	if (global.controllerType == controllerTypes.gamepad) {
		acceptString = "PRESS START TO FINALIZE";	
	}
}

// get spellbook sprite
spellBookSprite		= spr_spellBook;

// get infoDisplay sprite
infoDisplaySprite	= spr_sparSpellInfoDisplay;

// get width and height of spellBook sprite
spriteWidth		= sprite_get_width(spellBookSprite);
spriteHeight	= sprite_get_height(spellBookSprite);

// initialize the starting and max frame for the spellBook sprite
spellBookFrame		= 0;
spellBookFrameMax	= 5;

#region INITIALIZE SPELLBOOK ANIMATION VARIABLES
// initialize pageFlip boolean
pageFlip = false;

// initialize flipRight and flipLeft booleans
flipRight	= false;
flipLeft	= false;

// initialize flipFrame and flipMax
flipFrame	= 0;
flipMax	= 1;

// initialize modVar
modVar = 6;

// initialize drawFlip boolean
drawFlip = false;

// get the height of the knownSpellList
spellBookHeight = ds_list_size(knownSpellList);

#endregion

// initialize the shadeAlpha
shadeAlpha = 1.0;

#region INITIALIZE ALL DRAW POSITIONS

// spellbook should start offscreen
spellBookX = 0 - (spriteWidth / 2);
spellBookY = 58;
spellBookTargetX = spriteWidth / 2;

// initialize info display x and y 
var idsw = sprite_get_width(infoDisplaySprite);

// get the width of the info banner
infoBannerWidth = idsw - 10;

// set the x adn y for the infoDisplay
infoDisplayX = (idsw / 2) + spriteWidth + 4;
infoDisplayY = round(guiHeight * 0.25) - 22;

// initialize draw positions for spell params 
rangeDrawX = infoDisplayX - (idsw / 2) + 31;
rangeDrawY = infoDisplayY - 14;

powerDrawX = rangeDrawX + 41;
powerDrawY = rangeDrawY - 2;

costDrawX = powerDrawX + 39;
costDrawY = powerDrawY;

typeDrawX = costDrawX + 40;
typeDrawY = rangeDrawY;

descDrawX = infoDisplayX - 86;
descDrawY = infoDisplayY - 16;

var cfw = sprite_get_width(spr_spellBookCategoryFlash);
var cfh = sprite_get_height(spr_spellBookCategoryFlash);

categoryFlashX = 7;
categoryFlashY = 18;

cFlash_bbLeft	= categoryFlashX;
cFlash_bbTop	= categoryFlashY;
cFlash_bbRight	= cFlash_bbLeft + cfw;
cFlash_bbBottom = cFlash_bbTop + cfh;

nameSlotWidth	= sprite_get_width(spr_spellBookNameSlot);
nameSlotHeight	= sprite_get_height(spr_spellBookNameSlot);

nameSlotBottoms		= ds_list_create();
nameSlotTops		= ds_list_create();
nameSlotLefts		= ds_list_create();
nameSlotRights		= ds_list_create();

var i = 0;	repeat (8) {
	// check if this slot is on the left side
	if (i mod 2 == 0) {
		nameSlotLefts[| i]		= 2;	
		nameSlotRights[| i]		= 126;
	}
	// if this slot is on the right side
	else {
		nameSlotLefts[| i]		= 129;
		nameSlotRights[| i]		= 253;
	}
	
	// check if this slot is in the top row
	if (i div 2 == 0) {
		nameSlotTops[| i]		= 99;
		nameSlotBottoms[| i]	= 122;
	}
	
	// check if this slot is in the second row
	if (i div 2 == 1) {
		nameSlotTops[| i]		= 123;
		nameSlotBottoms[| i]	= 146;
	}
	
	// check if this slot is in the third row
	if (i div 2 == 2) {
		nameSlotTops[| i]		= 147;
		nameSlotBottoms[| i]	= 170;
	}
	
	// check if this slot is in the bottom row
	if (i div 2 == 3) {
		nameSlotTops[| i]		= 171;
		nameSlotBottoms[| i]	= 194;
	}

	// increment i
	i++;
}

#endregion

// set global.roombuilt to true
global.roomBuilt = true;