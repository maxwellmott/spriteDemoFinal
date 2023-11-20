enum npcs {
	mercurioGallant,
	indigoMyst,
	marcoBladesman,
	naimaHeartseer,
	thorntonVerdman,
	graciaVerdman,
	martinFoamhyde,
	locklanFoamhyde,
	eliciaLancer,
	cyrilSenut,
	cianaBeachfoot,
	jadeStonegrasp,
	marigoldBushward,
	violetBushward,
	yvesFennet,
	plumFennet,
	victorStalwarden,
	brutoLancer,
	dimVonVerstolen,
	perniciaVonVerstolen,
	xandraSenut,
	salvadorSenut,
	height
}

enum npcParams {
	ID,
	name,
	walkingSprite,
	meditatingSprite,
	eatingSprite,
	drinkingSprite,
	wavephoneSprite,
	talismans,
	spells,
	responses,
	locations,
	respondFunction,
	height
}

#region

function fix_response_grid(_grid) {
	var g = _grid;
	
	var i = 0;	repeat (ds_grid_height(g)) {
		g[# 0, i] = g[# 1, i];
		g[# 1, i] = g[# 2, i];
		g[# 2, i] = -1;
		
		i++;
	}
	
	ds_grid_resize(g, 2, i+1);
}

// load response maps from csv files
var mercurioResponseGrid = load_csv("DEMO_MERCURIO_ENGLISH.csv");

fix_response_grid(mercurioResponseGrid);
var mercurioResponseMap = ds_map_create();
convert_grid_to_map(mercurioResponseGrid, mercurioResponseMap);

#endregion

#region TALISMANS
// create all talisman lists
var mercurioTalismans	= ds_list_create();

// populate all talisman lists

#endregion

#region SPELLS
// create all spell lists
var mercurioSpells		= ds_list_create();

// populate all spell lists

#endregion

#region LOCATION LISTS
// create all location lists
var mercurioLocations	= ds_list_create();

// populate all location lists
//			list name				
ds_list_add(mercurioLocations,	string(locations.miriabramExt) + ",",													//hyggsun
								string(locations.miriabramLibrary) + ",",												//plughsun
								string(locations.miriabramLibrary) + ","	+ string(locations.miriabramDojo) + ",",	//rumnsun
								string(locations.miriabramExt) + ",");													//famelsun
								
#endregion

#region RESPONSE FUNCTIONS

/*
	DAY ONE:
			12 PM -- MERCURIO V NAIMA || NAIMA V MARCO
			3 PM  -- INDIGO V PLAYER || INDIGO V MERCURIO
			5 PM  -- INDIGO V MARCO
			8 PM  -- FESTIVAL CLOSES
			
	DAY TWO:
			12 PM -- MERCURIO V PLAYER || MARCO V NAIMA
			3 PM  -- PLAYER V NAIMA || MERCURIO V MARCO
			5 PM  -- PLAYER V MARCO || NAIMA V INDIGO
			8 PM  -- FESTIVAL CLOSES
*/

// create all response functions
function mercurio_respond() {
	var wd	= player.weekday;
	var h	= player.hours;

	switch (wd) {
		case weekdays.hyggsun:
			if h < 20	return ds_map_find_value(global.speaker.responseMap, "byeMatch1");
			if h < 17	return ds_map_find_value(global.speaker.responseMap, "preBye1");
			if h < 16	return ds_map_find_value(global.speaker.responseMap, "postMatch2");
			if h < 15	return ds_map_find_value(global.speaker.responseMap, "preMatch2");
			if h < 14	return ds_map_find_value(global.speaker.responseMap, "postMatch1");
			if h < 12	return ds_map_find_value(global.speaker.responseMap, "preMatch1");
			if h < 10	return ds_map_find_value(global.speaker.responseMap, "dayOnePreFest");
			
			if h >= 20	return ds_map_find_value(global.speaker.responseMap, "dayOnePostFest");
		break;
		
		case weekdays.plughsun:
			if h < 20	return ds_map_find_value(global.speaker.responseMap, "byeMatch2");
			if h < 17	return ds_map_find_value(global.speaker.responseMap, "preBye2");
			if h < 16	return ds_map_find_value(global.speaker.responseMap, "postMatch4");
			if h < 15	return ds_map_find_value(global.speaker.responseMap, "preMatch4");
			if h < 14	return ds_map_find_value(global.speaker.responseMap, "postMatch3");
			if h < 12	return ds_map_find_value(global.speaker.responseMap, "preMatch3");
			if h < 10	return ds_map_find_value(global.speaker.responseMap, "dayTwoPreFest");
			
			if h >= 20	return ds_map_find_value(global.speaker.responseMap, "dayTwoPostFest");
			
			if h < 4	return ds_map_find_value(global.speaker.responseMap, "dayOnePostFest");
	}
}

#endregion

// load csv file to textGrid
var textGrid = load_csv("npcs_english.csv");

// create npcGrid
global.npcGrid = ds_grid_create(npcParams.height, npcs.height);

// create function to add to master grid
function master_grid_add_npc(_ID) {
	var i = 0; repeat (npcParams.height) {
		global.npcGrid[# i, _ID] = argument[i];
		i++;
	}
}

// add all npcs to npcGrid		ID							NAME									WALKING SPRITE			MEDITATING SPRITE			EATING SPRITE			DRINKING SPRITE			WAVEPHONE SPRITE				TALISMANS							SPELLS								RESPONSES									LOCATIONS							RESPONSE FUNCTION
master_grid_add_npc(			npcs.mercurioGallant,		"MERCURIO",								spr_mercurioWalking,	spr_mercurioMeditating,		spr_mercurioEating,		spr_mercurioDrinking,	spr_mercurioWavephone,			encode_list(mercurioTalismans),		encode_list(mercurioSpells),		encode_map(mercurioResponseMap),			encode_list(mercurioLocations),		mercurio_respond);

// encode the grid
global.allNPCs = encode_grid(global.npcGrid);

// delete the grid
ds_grid_destroy(global.npcGrid);

function npc_load_parameters(_id) {	
	// get local vars
	var ID = _id;
	
	// decode npc grid
	var grid = ds_grid_create(npcParams.height, npcs.height);
	decode_grid(global.allNPCs, grid);
	
	// get all parameters
	name				= grid[# npcParams.name,				ID];
	
	walkingSprite		= real(string_digits(grid[# npcParams.walkingSprite,	ID]));
	meditatingSprite	= real(string_digits(grid[# npcParams.meditatingSprite,	ID]));
	eatingSprite		= real(string_digits(grid[# npcParams.eatingSprite,		ID]));
	drinkingSprite		= real(string_digits(grid[# npcParams.drinkingSprite,	ID]));
	wavephoneSprite		= real(string_digits(grid[# npcParams.wavephoneSprite,	ID]));
	responseFunction	= real(string_digits(grid[# npcParams.respondFunction,	ID]));
	
	//decode_list(grid[# npcParams.talismans,		ID],		talismans);
	//decode_list(grid[# npcParams.spells,			ID],		spells);
	decode_map(grid[# npcParams.responses,		ID],		responseMap);
	
	// get npcListIndex using npcID
	npcListIndex = ds_list_find_index(overworld.npcList, ID);
	
	parametersLoaded = true;
}
	
function gate_check_npc() {
	// check north gate
	if (bbox_top < 0) {
		// change location on schedule
		// destroy instance
	}
	
	// check east gate
	if (bbox_right > 800) {
		// change location on schedule
		// destroy instance
	}
	
	// check south gate
	if (bbox_bottom > 800) {
		// change location on schedule
		// destroy instance
	}
	
	// check west gate
	if (bbox_left < 0) {
		// change location on schedule
		// destroy instance
	}
}	

// this function returns a list of each NPC's chosen location for the next day in order of NPC ID
// the list is then used to edit the npc lists stored for each location
function day_change_build_location_list(_targetList) {
	var tl	 = _targetList;
	var grid = ds_grid_create(npcParams.height, npcs.height);
	decode_grid(global.allNPCs, grid);
	
	var i = 0;	repeat (npcs.height) {		
		// get encoded list of locations for all weekdays from npc grid
		var encList		= grid[# npcParams.locations, i];
		
		// break if no locations
		if (string_digits(encList) == noone) {
			i++;	break;
		}
		
		// create two dummy lists
		var weekList	= ds_list_create();
		
		// decode the first encoded list to the full week dummy list
		decode_list(encList, weekList);
		
		// get encoded list of locations for the current weekday from weekList
		encList = weekList[| player.weekday];
		
		// decode the second encoded list to the single day dummy list
		decode_list(encList, tl);
		
		// increment i
		i++;
	}
}

// this function takes the list of npc locations and uses it to correct each locations list of 
// present NPCs for the following day
function day_change_edit_npc_lists(_locationList) {
	var locationList = _locationList;
	
	var grid = ds_grid_create(locationParams.height, locations.height);
	decode_grid(global.allLocations, grid);		
	
	var _location = 0;	repeat (locations.height) {
		randomize();
		
		var encList = grid[# locationParams.npcList, _location];
		var npcList	= ds_list_create();
		
		decode_list(encList, npcList);
		
		ds_list_reset(npcList);
		
		var _npc = 0;		repeat (npcs.height) {
			if locationList[| _npc] == _location {
				ds_list_add(npcList, _npc);
			}
			
			_npc++;
		}
		
		grid[# locationParams.npcList, _location] = encode_list(npcList);
		
		_location++;
	}
	
	global.allLocations = encode_grid(grid);
}