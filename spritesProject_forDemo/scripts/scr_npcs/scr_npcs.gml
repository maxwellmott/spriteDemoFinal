
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
	SWIMMING_SPRITE,
	MEDITATING_SPRITE,
	EATING_SPRITE,
	DRINKING_SPRITE,
	WAVEPHONE_SPRITE,
	TALISMANS,
	SPELLS,
	RESPONSE_MAP,
	LOCATION_LIST,
	LOCATION_CHECK_FUNCTION,
	RESPOND_FUNCTION,
	TALKING_SPEED,
	VOICE,
	VOCAL_RANGE,
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

var mercurioTalismans = ds_list_create();

ds_list_add(mercurioTalismans,
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
ds_list_add(mercurioLocations,	locations.miriabramExt);
								
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
	
	global.dialogueKey = "mercurioSparPrompt1";
	
	// set the encoded grid as the value stored at the dialogueKey
	var eg = ds_map_find_value(global.speaker.responseMap, global.dialogueKey);

	return eg;		
}

#endregion

#region BUILD ALL LOCATION CHECK FUNCTIONS
// REMEMBER-- WITH ALL OF THESE FUNCTIONS, START WITH THE MOST SPECIFIC HEURISTIC
// AND END WITH THE MOST VAGUE. FOR EXAMPLE, ONE OF THE CONDITIONALS NEAR THE TOP MIGHT
// CHECK IF ONE PIECE OF DIALOGUE HAS BEEN PERFORMED WHILE ANOTHER HASN'T WHILE A CERTAIN
// QUEST STEP IS ACTIVE. THIS WOULD BE A REALLY SPECIFIC SET OF CONDITIONS FOR SOMETHING LIKE
// PUTTING AN NPC IN A SPECIFIC ROOM FOR ONE PIECE OF DIALOGUE FOR ONE QUEST STEP. ONE OF THE
// CONDITIONALS NEAR THE BOTTOM, HOWEVER, WOULD BE SOMETHING LIKE CHECKING THE DAY OF THE WEEK
// TO SEE IF THE NPC SHOULD BE AT THE BEACH OR AT SCHOOL.

// THIS SHOULD BE THE CASE FOR EVERY LOCATION IN THE FUNCTION.

function mercurio_location_check() {
	// get the weekday
	var wd = player.weekday;
	
	switch (locationID) {
		case locations.miriabramExt:
			// check if this is the first day of the demo
			if (wd == weekdays.hyggsun) {
				var inst = instance_create_depth(32, 276, 0, npc);
				
				inst.ID = npcs.mercurioGallant;
			}
		
		break;
	}
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

// add all npcs to npcGrid		ID							NAME			WALKING SPRITE			SWIMMING SPRITE			MEDITATING SPRITE			EATING SPRITE			DRINKING SPRITE			WAVEPHONE SPRITE			TALISMANS							SPELLS								RESPONSES									LOCATION LIST					LOCATION CHECK FUNCTION		RESPONSE FUNCTION	TALKING SPEED	VOICE				VOCAL RANGE
master_grid_add_npc(			npcs.mercurioGallant,		"MERCURIO",		spr_mercurioWalking,	spr_mercurioWalking,	spr_mercurioMeditating,		spr_mercurioEating,		spr_mercurioDrinking,	spr_mercurioWavephone,		encode_list(mercurioTalismans),		encode_list(mercurioSpells),		encode_map(mercurioResponseMap),			encode_list(mercurioLocations), mercurio_location_check,	mercurio_respond,	2,				sfx_mercurioVoice,	0.5);

// encode the grid
global.allNPCs = encode_grid(global.npcGrid);

var ggg = ds_grid_create(NPC_PARAMS.height, npcs.height);
decode_grid(global.allNPCs, ggg);

// delete the grid
ds_grid_destroy(global.npcGrid);

///@desc This function is called when a new location is being built. The function
/// takes the NPC who is being added to the location, and gets all their parameters
/// from the NPC grid
function npc_load_parameters(_id) {	
	// get local vars
	var ID = correct_string_after_decode(_id);
	
	// decode npc grid
	var grid = ds_grid_create(NPC_PARAMS.height, npcs.height);
	decode_grid(global.allNPCs, grid);
	
	// get all parameters
	name				= grid[# NPC_PARAMS.NAME,				ID];
	
	walkingSprite		= correct_string_after_decode(grid[# NPC_PARAMS.WALKING_SPRITE,		ID]);
	swimmingSprite		= correct_string_after_decode(grid[# NPC_PARAMS.SWIMMING_SPRITE,	ID]);
	meditatingSprite	= correct_string_after_decode(grid[# NPC_PARAMS.MEDITATING_SPRITE,	ID]);
	eatingSprite		= correct_string_after_decode(grid[# NPC_PARAMS.EATING_SPRITE,		ID]);
	drinkingSprite		= correct_string_after_decode(grid[# NPC_PARAMS.DRINKING_SPRITE,	ID]);
	wavephoneSprite		= correct_string_after_decode(grid[# NPC_PARAMS.WAVEPHONE_SPRITE,	ID]);
	responseFunction	= correct_string_after_decode(grid[# NPC_PARAMS.RESPOND_FUNCTION,	ID]);
	talkingSpeed		= correct_string_after_decode(grid[# NPC_PARAMS.TALKING_SPEED,		ID]);
	voice				= correct_string_after_decode(grid[# NPC_PARAMS.VOICE,				ID]);
	vocalRange			= correct_string_after_decode(grid[# NPC_PARAMS.VOCAL_RANGE,		ID]);
	
	//decode_list(grid[# NPC_PARAMS.talismans,		ID],		TALISMANS);
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

///@desc This function is called in the human draw event if the human in question is
/// an NPC. The function simply takes the NPCs current sprite--set by the npc_set_sprite
/// function--and draws that sprite to the app surface
function draw_npc() {
	if (sprite >= 0) {
		draw_sprite(sprite, frame, x, y);
	}
}