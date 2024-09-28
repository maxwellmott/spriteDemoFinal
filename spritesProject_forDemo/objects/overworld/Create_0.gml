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
	height
}

locationID = player.location;

if locationID < locations.miriabramExt outdoorLocation = false;
if locationID >= locations.miriabramExt outdoorLocation = true;

locationGrid = ds_grid_create(locationParams.height, locations.height);

decode_grid(global.allLocations, locationGrid);

northExit	= real(locationGrid[# locationParams.toNorth, locationID]);
eastExit	= real(locationGrid[# locationParams.toEast, locationID]);
southExit	= real(locationGrid[# locationParams.toSouth, locationID]);
westExit	= real(locationGrid[# locationParams.toWest, locationID]);

tileRowCount	= real(locationGrid[# locationParams.tileRowCount, locationID]);
tileColumnCount = real(locationGrid[# locationParams.tileColumnCount, locationID]);

locationWidth	= tileColumnCount * TILEWIDTH;
locationHeight	= tileRowCount * TILEHEIGHT;

locationName	= locationGrid[# locationParams.name, locationID];

var objectString		= ds_grid_get(locationGrid,	locationParams.objectString,	locationID);
var literatureString	= ds_grid_get(locationGrid, locationParams.literatureList,	locationID);

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
	
	if (tSet != string(noone)) tSet = string_digits(tSet);
	
	if (tSet != noone) {tilemapList[| layerNum - 1] = place_all_tiles(layerName, tSet, encGrid, tileRowCount, tileColumnCount)};
	
	layerNum++;
}

player.tm_ground		= tilemapList[| tilemaps.ground];
player.tm_water			= tilemapList[| tilemaps.water];
player.tm_upstairs		= tilemapList[| tilemaps.upperStory];
player.tm_collidables	= tilemapList[| tilemaps.collidables];

place_scenery(objectString);
place_doors();
place_literature(literatureString);

// create the overworld alerts stack
alertStack = ds_list_create();

// get location's npc list
npcList	= ds_list_create();
decode_list(locationGrid[# locationParams.npcList,	locationID], npcList);

var firstEntry = npcList[|0];

var i = 0; repeat (ds_list_size(npcList)) {
	var _npc = instance_create_depth(32, 276, LAYER.sprites, npc);
	
	_npc.ID = string_digits(npcList[| i]);
	
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

global.roomBuilt = true;