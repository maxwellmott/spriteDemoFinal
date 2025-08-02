// initialize locationID
global.newRoom = -1;

// initialize completion checks
spritesCreated = false;
sceneryCreated = false;

// initialize lightningActive
lightningActive = false;

// initialize minutesSinceLightning
minutesSinceLightning = 0;

if !(layer_exists("Background"))	layer_create(get_layer_depth(LAYER.background),			"Background");
if !(layer_exists("Ground"))		layer_create(get_layer_depth(LAYER.groundTiles),		"Ground");
if !(layer_exists("Water"))			layer_create(get_layer_depth(LAYER.waterTiles),			"Water");
if !(layer_exists("Collidables"))	layer_create(get_layer_depth(LAYER.collidableTiles),	"Collidables");
if !(layer_exists("UpperStory"))	layer_create(get_layer_depth(LAYER.upperStoryTiles),	"UpperStory");

move_layer("Background",	LAYER.background);
move_layer("Ground",		LAYER.groundTiles);
move_layer("Water",			LAYER.waterTiles);
move_layer("Collidables",	LAYER.collidableTiles);
move_layer("UpperStory",	LAYER.upperStoryTiles);

enum tilemaps {
	ground,
	water,
	collidables,
	upperStory,
	HEIGHT
}

locationID = player.location;

if locationID < locations.miriabramExt outdoorLocation = false;
if locationID >= locations.miriabramExt outdoorLocation = true;

locationGrid = ds_grid_create(locationParams.HEIGHT, locations.HEIGHT);

decode_grid(global.allLocations, locationGrid);

northExit	= correct_string_after_decode(locationGrid[# locationParams.toNorth, locationID]);
eastExit	= correct_string_after_decode(locationGrid[# locationParams.toEast, locationID]);
southExit	= correct_string_after_decode(locationGrid[# locationParams.toSouth, locationID]);
westExit	= correct_string_after_decode(locationGrid[# locationParams.toWest, locationID]);

tileRowCount	= correct_string_after_decode(locationGrid[# locationParams.tileRowCount, locationID]);
tileColumnCount = correct_string_after_decode(locationGrid[# locationParams.tileColumnCount, locationID]);

locationWidth	= tileColumnCount * TILEWIDTH;
locationHeight	= tileRowCount * TILEHEIGHT;

locationName	= locationGrid[# locationParams.name, locationID];

var objectString		= locationGrid[# locationParams.objectString,	locationID];
var literatureString	= locationGrid[# locationParams.literatureList,	locationID];
var bookcaseString		= locationGrid[# locationParams.bookcaseList,	locationID];
var bedString			= locationGrid[# locationParams.bedList,		locationID];

tilemapList = ds_list_create();

// PLACE ALL TILES
var layerNum = 1; repeat(4) {
	switch(layerNum) {
		
		case 1: 
			var layerName	= "Ground";
			var tSet		= locationGrid[# locationParams.groundTileset,		locationID];
			var encGrid		= locationGrid[# locationParams.groundTiles,		locationID];
			break;

		case 2: 
			var layerName	= "Water";
			var tSet		= locationGrid[# locationParams.waterTileset,		locationID];
			var encGrid		= locationGrid[# locationParams.waterTiles,			locationID];
			break;

		case 3: 
			var layerName	= "Collidables";
			var tSet		= locationGrid[# locationParams.collidableTileset,	locationID];
			var encGrid		= locationGrid[# locationParams.collidables,		locationID];
			break;

		case 4:
			var layerName	= "UpperStory";
			var tSet		= locationGrid[# locationParams.upperTileset,		locationID];
			var encGrid		= locationGrid[# locationParams.upperStoryTiles,	locationID];
			break;
	}
	
	tSet = correct_string_after_decode(tSet);
	
	if (tSet != -1) {tilemapList[| layerNum - 1] = place_all_tiles(layerName, tSet, encGrid, tileRowCount, tileColumnCount)};
	
	layerNum++;
}

tm_ground		= tilemapList[| tilemaps.ground];
tm_water		= tilemapList[| tilemaps.water];
tm_upstairs		= tilemapList[| tilemaps.upperStory];
tm_collidables	= tilemapList[| tilemaps.collidables];

if (bookcaseString != "<>")
&& (bookcaseString != 0) {
	place_bookcases(bookcaseString);
}

if (literatureString != "<>")	
&& (literatureString != 0) {
	place_literature(literatureString);
}

if (objectString != "<>")
&& (objectString != 0) {
	place_scenery(objectString);
}

place_doors();

if (bedString != "<>")
&& (bedString != 0) {
	place_beds(bedString);
}

// create the overworld alerts stack
alertStack = ds_list_create();

// decode npc grid
var npcg = ds_grid_create(NPC_PARAMS.HEIGHT, npcs.HEIGHT);
decode_grid(global.allNPCs, npcg);

var i = 0;	repeat (npcs.HEIGHT) {
	var locationList = npcg[# NPC_PARAMS.LOCATION_LIST, i];
	
	var locationFunc = correct_string_after_decode(npcg[# NPC_PARAMS.LOCATION_CHECK_FUNCTION, i]);
	
	if (locationList != "-4")
	&& (locationList != "-1") 
	&& (locationList != "0") {
		var ll = ds_list_create();
		decode_list(locationList, ll);
		
		if (ds_list_find_index(ll, string(locationID)) != -1) {
			locationFunc();
		}
	}
	
	// increment i
	i++;
}

// decode overworld sprite grid
var osg = ds_grid_create(OVERWORLD_SPRITE_PARAMS.HEIGHT, SPRITES.HEIGHT);
decode_grid(global.allOverworldSprites, osg);

var i = 0;	repeat (SPRITES.HEIGHT) {
	
	var locationList = osg[# OVERWORLD_SPRITE_PARAMS.LOCATION_LIST, i];
	
	var locationFunc = correct_string_after_decode(osg[# OVERWORLD_SPRITE_PARAMS.LOCATION_CHECK_FUNCTION, i]);
	
	if (locationList != "-4")
	&& (locationList != "-1") 
	&& (locationList != "0") {
		var ll = ds_list_create();
		decode_list(locationList, ll);
		
		if (ds_list_find_index(ll, string(locationID)) != -1) {
			locationFunc();
		}
	}
	
	i++;
}

// create overworldDraw object
if !(instance_exists(overworldDraw)) instance_create_depth(0, 0, get_layer_depth(LAYER.meta), overworldDraw);

lightsOn = false;

/*
if (is_debug_overlay_open()) {
	instance_create_depth(x, y, get_layer_depth(LAYER.meta), sceneryPlacingTool);	
}
*/

//create_once(mouse_x, mouse_y, LAYER.mouse, tileChecker_debug);

// this is a grid of emotes that should be immediately displayed. Once emotes
// on the above grid reach their target page, they are added to this grid. This grid
// stores the enumerated ID of the emote as well as the instance id of the character
// displaying that emotion
activeEmotes = ds_grid_create(2, 0);

global.roomBuilt = true;