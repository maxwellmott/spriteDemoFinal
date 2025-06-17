
/// IMPORTANT NOTE ABT NPCS
/// THE DECISION TO TRANSPORT TO A NEW LOCATION SHOULD COME AS
/// AN ACTION INDICATED ON THE NPCS PATH LIST. THIS SHOULD ALWAYS
/// OCCUR WHEN THE NPC HAS REACHED THE GIVEN MEANS OF TRANSPORT (DOOR,
/// STAIRWAY, EDGE OF SCREEN, ETC)

// enumerator containing npc IDs
enum npcs {
	mercurioGallant,		// 2 years older than you--lives with aunt and uncle in big house off campus
	indigoMyst,				// your same age--lives in the school with you
	dynoBladesman,			// 1 year older than you--lives in the school with you
	naimaHeartseer,			// 4 years older than you--lives with mentors at the Wavist Academy
	thorntonVerdman,		// 9 years older than you--graduated from miriabram school in the past, hangs around and helps out sometimes
	graciaVerdman,			// thornton's aunt, gay as hell, very nice and insightful, fought to keep her farmland when food synthesis was invented
	martinFoamhyde,			// locklan's father--used to be pretty cool. He's caved in a lot to make room for Locklan's beliefs. Used to volunteer at the library when bookish was still young and needed help :')
	locklanFoamhyde,		// 8 years older than you--graduated from miriabram in the past, rich pickme boy who joined the military (tries to pressure mercurio to be like him)
	eliciaLancer,			// 11 years older than you--graduated from miriabram in the past, distant relative of Lady Ellevere
	cyrilSenut,				// 16 years older than you. wants desperately to fit into both worlds--the world of his parents, and the world of his friends
	cianaBeachfoot,			// 10 years older than you. miriabram grad. born Ciana Foamhyde--locklan's cousin. She is giving Paris Hilton Enlightenment tm. Totally nihilistic because her experiences showed her the truth of humanity at an early age.
	jadeStonegrasp,			// Mercurio's aunt and foster mother--she and her husband want mercurio to grow into a young man who makes their charity worthwhile...yeh
	marigoldBushward,		// 7 years older than you, graduated from miriabram school (and both of the other academies on stackrock) she takes herself very seriously and doesn't want to be seen as a silly hippy like her relatives
	violetBushward,			// 7 years older than you, studied at miriabram school but never graduated, indefinitely studying at Wavist Academy (basically has a residency but no degree), she's good but didn't learn properly
	yvesFennet,				// 13 years older than you, graduated early from miriabram school. Keeps to herself these days. She lives with her family in Soulsprig, but it's clear that she is totally focused on her magical practices.
	plumFennet,				// 10 years older than you, graduated from miriabram school and the burnishing school. They work as a crystal architect. Their work incorporates cutting edge tech that they personally invent. Besties with Thornton
	victorStalwarden,		// 17 years older than you. Graduated from miriabram school. total fucking douchebag. Current archbishop of the military. Basically inherited the title from his father, Percival. Typical douchey blonde boy
	brutoLancer,			// 15 years older than you. Studied at miriabram school but never graduated. Total douchebag. Bullied Elicia all her life. Now he lives alone in their family's giant estate. Under the High Council's thumb.
	dimVonVerstolen,		// 16 years older than you. Graduated from miriabram and the burnishing school. Current Overseer of Von Verstolen Labs. Not an evil person, just really strange and lonely.
	perniciaVonVerstolen,	// 18 years older than you. Graduated from miriabram and the burnishing school. Current Head Developer at Von Verstolen Labs. Sort of an evil person. Tortures her cowardly little brother.
	xandraSenut,			// born xandra lancer. Elicia's cousin. They are friends still, even though they have very different lives. Sometimes they argue, but they know they're all they've got.
	salvadorSenut,			// wealthy politician who is trying to get a seat in the High Council (probably never will since he isn't of one of the main houses)
	eoghanStonesword,		// current headmaster of miriabram. He was the first man to sit as the headmaster at miriabram school. He is over 100 years old and is not interested in immortality. He's a real sweetie.
	dianaSenut,				// current practicing master of miriabram. She will someday take Eoghan's place as headmaster, until then she is training under him. Her brother, Salvador, does not approve of this.
	height
}

// enumerator containing NPC_PARAMS
enum NPC_PARAMS {
	ID,
	NAME,
	WALKING_SPRITE,
	MEDITATING_SPRITE,
	EATING_SPRITE,
	DRINKING_SPRITE,
	WAVEPHONE_SPRITE,
	TALISMANS,
	SPELLS,
	RESPONSE_MAP,
	LOCATIONS,
	RESPOND_FUNCTION,
	height
}

#region BUILD ALL RESPONSE GRIDS

///@desc This function is called after each response grid
/// is converted from the attached CSV file. It removes the placeholder
/// value at the front of the grid
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

#region BUILD ALL TALISMAN LISTS

var mercurio = ds_list_create();

ds_list_add(mercurio,
				SPRITES.DEMOLITOPS,
				SPRITES.ZEPHIRA,
				SPRITES.FISHMONGER,
				SPRITES.UPROOTER
			);
#endregion

#region BUILD ALL KNOWN SPELLS LISTS

var mercurioSpells = ds_list_create();

ds_list_add(mercurioSpells,
				SPELLS.FIREBALL,
				SPELLS.HOLY_WATER,
				SPELLS.SHOCK,
				SPELLS.DECAY,
				SPELLS.EXPEL_FORCE,
				SPELLS.HEALING_LIGHT,
				SPELLS.JABULS_FIGHT_SONG,
				SPELLS.CRECIAS_CRYSTAL_SPIKES
			);
#endregion

#region BUILD ALL LOCATION LISTS
// create all location lists
var mercurioLocations	= ds_list_create();

// populate all location lists
//			list name				
ds_list_add(mercurioLocations,	"<`"+string(locations.miriabramExt) + ">",													//hyggsun
								"<`"+string(locations.miriabramLibrary) + ">",												//plughsun
								"<`"+string(locations.miriabramLibrary) + "`"	+ string(locations.miriabramDojo) + ">",	//rumnsun
								"<`"+string(locations.miriabramExt) + ">");													//famelsun
								
#endregion

#region BUILD ALL RESPONSE FUNCTIONS

/*
	DAY ONE:
			12 PM	-- MERCURIO V NAIMA || NAIMA V MARCO
			3 PM	-- INDIGO V PLAYER || INDIGO V MERCURIO
			5 PM	-- INDIGO V MARCO
			8 PM	-- FESTIVAL CLOSES
			
	DAY TWO:
			12 PM	-- MERCURIO V PLAYER || MARCO V NAIMA
			3 PM	-- PLAYER V NAIMA || MERCURIO V MARCO
			5 PM	-- PLAYER V MARCO || NAIMA V INDIGO
			8 PM	-- FESTIVAL CLOSES
			
	DAY THREE:
			12 PM	-- THORNTON, PLUM, VIOLET, AND DIM ALL ARRIVE
			3 PM	-- MATCHES ENSUE AT THE PLAYER'S LEISURE
			5 PM	-- MATCHES ENSUE AT THE PLAYER'S LEISURE
			8 PM	-- FESTIVAL CLOSES
*/

///@desc Mercurio's response function. Determines the proper dialogue
/// response upon being interacted with.
function mercurio_respond() {
	var wd	= player.weekday;
	var h	= player.hours;

	switch (wd) {
		case weekdays.hyggsun:
			if h < 20	global.dialogueKey = "mercurioByeMatch1";
			if h < 17	global.dialogueKey = "mercurioPreBye1";
			if h < 16	global.dialogueKey = "mercurioPostMatch2";
			if h < 15	global.dialogueKey = "mercurioPreMatch2";
			if h < 14	global.dialogueKey = "mercurioPostMatch1";
			if h < 12	global.dialogueKey = "mercurioPreMatch1";
			if h < 10	global.dialogueKey = "mercurioDayOnePreFest";
			
			if h >= 20	global.dialogueKey = "mercurioDayOnePostFest";
		break;
		
		case weekdays.plughsun:
			if h < 20	global.dialogueKey = "mercurioByeMatch2";
			if h < 17	global.dialogueKey = "mercurioPreBye2";
			if h < 16	global.dialogueKey = "mercurioPostMatch4";
			if h < 15	global.dialogueKey = "mercurioPreMatch4";
			if h < 14	global.dialogueKey = "mercurioPostMatch3";
			if h < 12	global.dialogueKey = "mercurioPreMatch3";
			if h < 10	global.dialogueKey = "mercurioDayTwoPreFest";
			
			if h >= 20	global.dialogueKey = "mercurioDayTwoPostFest";
			
			if h < 4	global.dialogueKey = "mercurioDayOnePostFest";
		break;
		
		case weekdays.rumnsun:
			if h < 20	global.dialogueKey = "mercurioDayThreeMatchesEnsue";
			if h < 17	global.dialogueKey = "mercurioDayThreeProsArrive";
		break;
	}
	
	// FOR TESTING ONLY
	global.dialogueKey = "mercurioSparPrompt1";
	
	// set the encoded grid as the value stored at the dialogueKey
	var eg = ds_map_find_value(global.speaker.responseMap, global.dialogueKey);
	
	return eg;	
}

function npc_get_response(_npcID) {
	// store args in locals
	var npcID = _npcID;
	
	// get factors for response selection
	var wd	= player.weekday;
	var h	= player.hours;
	var s	= player.season;
	var l	= overworld.locationID;
	var r	= global.rainActive;
	
	// use a conditional statement to get the NPC's general "small talk" response
		// each conditional should return an ID from an enumerator containing names 
		// of different archetypal dialogues shared by all NPCs (rainySummerNight, sunnyFallMorning, etc)
		// NOTE maybe also take the moon and the NPC's current routine into consideration
	
	// use one long if else, else, else, etc statement to determine if there is a piece of
	// special dialogue that should be used to replace the dialogue selecetd above. 
	// NOTE the if/else for each special dialogue should be listed in order of most conditions
	// to least conditions.
	
	// set the encoded grid as the value stored at the dialogueKey
	var eg = ds_map_find_value(global.speaker.responseMap, global.dialogueKey);
		
}

#endregion

// load csv file to textGrid
var textGrid = load_csv("npcs_english.csv");

// create npcGrid
global.npcGrid = ds_grid_create(NPC_PARAMS.height, npcs.height);

// create function to add to master grid
function master_grid_add_npc(_ID) {
	var i = 0; repeat (NPC_PARAMS.height) {
		global.npcGrid[# i, _ID] = argument[i];
		i++;
	}
}

// add all npcs to npcGrid		ID							NAME									WALKING SPRITE			MEDITATING SPRITE			EATING SPRITE			DRINKING SPRITE			WAVEPHONE SPRITE											SPELLS								RESPONSES									LOCATIONS							RESPONSE FUNCTION
master_grid_add_npc(			npcs.mercurioGallant,		"MERCURIO",								spr_mercurioWalking,	spr_mercurioMeditating,		spr_mercurioEating,		spr_mercurioDrinking,	spr_mercurioWavephone,			encode_list(mercurio),		encode_list(mercurioSpells),		encode_map(mercurioResponseMap),			encode_list(mercurioLocations),		mercurio_respond);

// encode the grid
global.allNPCs = encode_grid(global.npcGrid);

// delete the grid
ds_grid_destroy(global.npcGrid);

///@desc This function is called when a new location is being built. The function
/// takes the NPC who is being added to the location, and gets all their parameters
/// from the NPC grid
function npc_load_parameters(_id) {	
	// get local vars
	var ID = _id;
	
	// decode npc grid
	var grid = ds_grid_create(NPC_PARAMS.height, npcs.height);
	decode_grid(global.allNPCs, grid);
	
	// get all parameters
	name				= grid[# NPC_PARAMS.NAME,				ID];
	
	walkingSprite		= correct_string_after_decode(grid[# NPC_PARAMS.WALKING_SPRITE,		ID]);
	meditatingSprite	= correct_string_after_decode(grid[# NPC_PARAMS.MEDITATING_SPRITE,	ID]);
	eatingSprite		= correct_string_after_decode(grid[# NPC_PARAMS.EATING_SPRITE,		ID]);
	drinkingSprite		= correct_string_after_decode(grid[# NPC_PARAMS.DRINKING_SPRITE,		ID]);
	wavephoneSprite		= correct_string_after_decode(grid[# NPC_PARAMS.WAVEPHONE_SPRITE,		ID]);
	responseFunction	= correct_string_after_decode(grid[# NPC_PARAMS.RESPOND_FUNCTION,		ID]);
	
	//decode_list(grid[# NPC_PARAMS.,		ID],		);
	//decode_list(grid[# NPC_PARAMS.spells,			ID],		SPELLS);
	decode_map(grid[# NPC_PARAMS.RESPONSE_MAP,		ID],		responseMap);
	
	// get npcListIndex using npcID
	npcListIndex = ds_list_find_index(overworld.npcList, ID);
	
	parametersLoaded = true;
}



///@desc This function is called when an NPC collides with one of the offscreen gates. 
/// The function moves them to the next location in that direction if there is one.
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
function build_npc_location_list() {
	var grid = ds_grid_create(NPC_PARAMS.height, npcs.height);
	decode_grid(global.allNPCs, grid);
	
	var i = 0;	repeat (npcs.height) {		
		// get encoded list of locations for all weekdays from npc grid
		var encList		= grid[# NPC_PARAMS.LOCATIONS, i];
		
		// break if no locations
		if (encList == "-4")
		|| (encList == "-1")
		|| (encList == "0") {
			break;
		}
		else {
		
			//@TODO THIS IS NOT FINISHED. THE ONLY REASON THIS WORKS IS THAT
			// WE ARE BREAKING THE LOOP RIGHT AFTER DECODING MERCURIO'S LOCATIONS
			// TO THE LOCATION LIST. IDEALLY, THE END OF EACH LOOP SHOULD SELECT
			// A SINGLE LOCATION (IF THERE ARE MULTIPLE) AND THEN PLACE IT ON
			// THE NPC LOCATION LIST AT POSITION i.
			
			// I'M NOT SURE IF I'LL KEEP THIS LOGIC ANYWAY AFTER SUBMITTING FOR PAX.
		
			// create two dummy lists
			var weekList	= ds_list_create();
			var dayList		= ds_list_create();
			
			// decode the first encoded list to the full week dummy list
			decode_list(encList, weekList);
			
			// get encoded list of locations for the current weekday from weekList
			encList = weekList[| player.weekday];
			
			// add the day list to the location list 
			decode_list(encList, global.npcLocationList);

		}
		
		// increment i
		i++;
	}
}

///@desc This function is called in the human draw event if the human in question is
/// an NPC. The function simply takes the NPCs current sprite--set by the npc_set_sprite
/// function--and draws that sprite to the app surface
function draw_npc() {
	if (sprite >= 0) {
		draw_sprite(sprite, frame, x, y);
	}
}

///@desc This function takes the list of npc locations and uses it to change each location's list of 
// present NPCs for the following day
function edit_npc_location_lists() {	
	var grid = ds_grid_create(locationParams.height, locations.height);
	decode_grid(global.allLocations, grid);		
	
	var _location = 0;	repeat (locations.height) {
		var encList = grid[# locationParams.npcList, _location];
		var npcList	= ds_list_create();
		
		// break if no locations
		if (encList != "-4")
		&& (encList != "-1")
		&& (encList != "0") {
		
			decode_list(encList, npcList);
		
			ds_list_reset(npcList);
		
			var _npc = 0;		repeat (npcs.height) {
				if global.npcLocationList[| _npc] == _location {
					ds_list_add(npcList, _npc);
				}
				
				_npc++;
			}
		
			grid[# locationParams.npcList, _location] = encode_list(npcList);
		}
		
		_location++;
	}
	
	global.allLocations = encode_grid(grid);
}