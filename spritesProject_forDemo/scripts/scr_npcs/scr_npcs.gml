
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
	naiaSeaspear,			// 4 years older than you--lives with mentors at the Wavist Academy
	thorntonVerdman,		// 9 years older than you--graduated from miriabram school in the past, hangs around and helps out sometimes
	graciaVerdman,			// thornton's aunt, gay as hell, very nice and insightful, fought to keep her farmland when food synthesis was invented
	martinFoamhyde,			// locklan's father--used to be pretty cool. He's caved in a lot to make room for Locklan's beliefs. Used to volunteer at the library when bookish was still young and needed help :')
	locklanFoamhyde,		// 8 years older than you--graduated from miriabram in the past, rich pickme boy who joined the military (tries to pressure mercurio to be like him)
	eliciaLancer,			// 11 years older than you--graduated from miriabram in the past, distant relative of Lady Ellevere
	cyrilSenut,				// 16 years older than you. wants desperately to fit into both worlds--the world of his parents, and the world of his friends
	cianaBeachfoot,			// 10 years older than you. miriabram grad. born Ciana Foamhyde--locklan's cousin. She is giving Paris Hilton Enlightenment tm. Totally nihilistic because her experiences showed her the truth of humanity at an early age.
	jadeStonegrasp,			// Mercurio's aunt and foster mother--she and her husband want mercurio to grow into a young man who makes their charity worthwhile...yeh
	grantStonegrasp,		// Mercurio's cousin/adopted brother (Jade's son). He graduated 3 years prior, so now he's like 23. He's a total douchebag. He's basically the Gary Oak of the situation. He thinks Mercurio and his friends are losers
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
	HEIGHT
}

// enumerator containing NPC_PARAMS
enum NPC_PARAMS {
	ID,
	NAME,
	WALKING_SPRITE,
	SWIMMING_SPRITE,
	MUSIC_SPRITE,
	SPECIAL_ANIMATIONS,
	TALISMANS,
	SPELLS,
	RESPONSE_MAP,
	LOCATION_LIST,
	LOCATION_CHECK_FUNCTION,
	BEHAVIOR_FUNCTION,
	RESPOND_FUNCTION,
	TALKING_SPEED,
	VOICE,
	VOCAL_RANGE,
	HEIGHT
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

var naiaResponseGrid = load_csv("DEMO_NAIA_ENGLISH.csv");

fix_response_grid(naiaResponseGrid);
var naiaResponseMap = ds_map_create();
convert_grid_to_map(naiaResponseGrid, naiaResponseMap);

#endregion

#region BUILD ALL TALISMAN LISTS

var mercurioTalismans = ds_list_create();

ds_list_add(mercurioTalismans,
				SPRITES.DEMOLITOPS,
				SPRITES.ZEPHIRA,
				SPRITES.FISHMONGER,
				SPRITES.UPROOTER
			);
			
var naiaTalismans = ds_list_create();

ds_list_add(naiaTalismans,
				SPRITES.FLOOPWALKER,
				SPRITES.SONGBIRD,
				SPRITES.DECIDRUID,
				SPRITES.FISHMONGER,
				SPRITES.GEMBO
			);
			
#endregion

#region BUILD ALL KNOWN SPELLS LISTS

var mercurioSpells = ds_list_create();
var naiaSpells = ds_list_create();

ds_list_add(mercurioSpells,
				SPELLS.FIREBALL,
				SPELLS.HOLY_WATER,
				SPELLS.SHOCK,
				SPELLS.DECAY,
				SPELLS.EXPEL_FORCE,
				SPELLS.HEALING_LIGHT,
				SPELLS.CRECIAS_CRYSTAL_SPIKES
			);
			
ds_list_add(naiaSpells,
				SPELLS.FIREBALL,
				SPELLS.HOLY_WATER,
				SPELLS.SHOCK,
				SPELLS.DECAY,
				SPELLS.EXPEL_FORCE,
				SPELLS.HEALING_LIGHT,
				SPELLS.CHANNEL_ESSENCE
			);
#endregion

#region BUILD ALL LOCATION LISTS
// create all location lists
var mercurioLocations	= ds_list_create();
var naiaLocations		= ds_list_create();

// populate all location lists
//			list name				
ds_list_add(mercurioLocations,	locations.miriabramExt);
ds_list_add(naiaLocations,		locations.miriabramFoyer);

#endregion

#region BUILD ALL BEHAVIOR FUNCTIONS

	function mercurio_behavior() {
		switch (overworld.locationID) {
			case locations.miriabramExt:
				switch(player.weekday) {
					case weekdays.hyggsun:
						state = OVERWORLD_CHARACTER_STATES.ERRATIC_LOOKING;
					break;
					
					case weekdays.plughsun:
						state = OVERWORLD_CHARACTER_STATES.ERRATIC_LOOKING;
					break;
					
					case weekdays.rumnsun:
						state = OVERWORLD_CHARACTER_STATES.ERRATIC_LOOKING;
					break;
					
					case weekdays.famelsun:
						state = OVERWORLD_CHARACTER_STATES.ERRATIC_LOOKING;
					break;
				}
			break;
			
			case locations.miriabramFoyer:
				switch(player.weekday) {
					case weekdays.hyggsun:
					break;
					
					case weekdays.plughsun:
					break;
					
					case weekdays.rumnsun:
					break;
					
					case weekdays.famelsun:
					break;
				}
			break;
		}
	}

	function naia_behavior() {
		switch (overworld.locationID) {
			case locations.miriabramFoyer:
				switch(player.weekday) {
					case weekdays.hyggsun:
						if (state < 0) {
							state = OVERWORLD_CHARACTER_STATES.PLAYING_MUSIC;
							currentSong = wps_test;
							songLoops = 0;
						}
						
						if (state != OVERWORLD_CHARACTER_STATES.PLAYING_MUSIC) {
							if (global.gameTime mod 800 == 0) {
								randomize();
								var r = irandom_range(0, 1);
								
								if (r) {
									state = OVERWORLD_CHARACTER_STATES.ERRATIC_LOOKING;	
								}
								else {
									state = OVERWORLD_CHARACTER_STATES;
									currentSong = wps_test;
									songLoops = 0;
								}
							}
						}
					break;
					
					case weekdays.plughsun:
						state = OVERWORLD_CHARACTER_STATES.ERRATIC_LOOKING;
					break;
					
					case weekdays.rumnsun:
						state = OVERWORLD_CHARACTER_STATES.ERRATIC_LOOKING;
					break;
					
					case weekdays.famelsun:
						state = OVERWORLD_CHARACTER_STATES.ERRATIC_LOOKING;
					break;
				}
			break;
			
			case locations.miriabramFoyer:
				switch(player.weekday) {
					case weekdays.hyggsun:
					break;
					
					case weekdays.plughsun:
					break;
					
					case weekdays.rumnsun:
					break;
					
					case weekdays.famelsun:
					break;
				}
			break;
		}	
	}
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
	// decode the player's todo list
	var tdList = ds_list_create();
	decode_list(player.todoList, tdList);
	
	// check if "Pre-festival Jitters" is on Step 2
	if (tdList[| TASKS.PREFESTIVAL_JITTERS] == 1) {
		global.dialogueKey = "mercurioQuestDialogue1";
	}
	
	// set the encoded grid as the value stored at the dialogueKey
	var eg = ds_map_find_value(global.speaker.responseMap, global.dialogueKey);
	
	return eg;	
}

function naia_respond() {
	// decode the player's todo list
	var tdList = ds_list_create();
	decode_list(player.todoList, tdList);
	
	// check that "Silver Linings" has not yet been started
	// and the festival has not yet started
	
	//check if "Silver Linings" is on Step 3
	
	// FOR TESTING ONLY
	global.dialogueKey = "naiaQuestDialogue1";
	
	// set the encoded grid as the value stored at the dialogueKey
	var eg = ds_map_find_value(global.speaker.responseMap, global.dialogueKey);
	
	return eg;		
}

function npc_get_response(_inst) {
	// store args in locals
	var inst = _inst;
	
	// get npc name
	var name = inst.name;
	
	// get factors for response selection
	var wd	= player.weekday;
	var h	= player.hours;
	var s	= player.season;
	var l	= overworld.locationID;
	var r	= global.rainActive;
	
	switch (wd) {
		case weekdays.hyggsun:
			// morning
			if (h <= 12) {
				global.dialogueKey = name + "DayOneMorningHello";
			}
			
			// afternoon
			if (h <= 18) {
				global.dialogueKey = name + "DayOneAfternoonHello";
			}
			
			// evening
			if (h <= 5)
			|| (h <= 24) {
				global.dialogueKey = name + "DayOneEveningHello";
			}
		break;
		
		case weekdays.plughsun:
		
		break;
		
		case weekdays.rumnsun:
		
		break;
		
		case weekdays.famelsun:
		
		break;
	}
	
	// run the NPCs personal response function to check for any special dialogue that they should be doing
	inst.respondFunction();
	
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
				
				// check if we are in the overworld
				if (instance_exists(overworld)) {
					var inst = instance_create_depth(32, 276, 0, npc);
				
					inst.ID = npcs.mercurioGallant;
				}
			}
		
		break;
	}
}

function naia_location_check() {
	// get the weekday
	var wd = player.weekday;
	
	switch (locationID) {
		case locations.miriabramFoyer:
			// check if this is the first day of the demo
			if (wd == weekdays.hyggsun) {
				// check if we are in the overworld
				if (instance_exists(overworld)) {
					var inst = instance_create_depth(32, 276, 0, npc);
					
					inst.ID = npcs.naiaSeaspear;
				}
			}
	}
}

#endregion

#region BUILD ALL SPECIAL ANIMATION LISTS
	var mercurioSpecialAnimations = ds_list_create();
	var naiaSpecialAnimations = ds_list_create();
	
	//ds_list_add(mercurioSpecialAnimations, spr_mercurioPanicking);
	//ds_list_add(naiaSpecialAnimations, spr_naiaStudying);

#endregion

// load csv file to textGrid
var textGrid = load_csv("npcs_english.csv");

// create npcGrid
global.npcGrid = ds_grid_create(NPC_PARAMS.HEIGHT, npcs.HEIGHT);

// create function to add to master grid
function master_grid_add_npc(_ID) {
	var i = 0; repeat (NPC_PARAMS.HEIGHT) {
		global.npcGrid[# i, _ID] = argument[i];
		i++;
	}
}

// add all npcs to npcGrid		ID							NAME			WALKING SPRITE			SWIMMING SPRITE			MUSIC SPRITE			SPECIAL ANIMATIONS			TALISMANS							SPELLS								RESPONSES									LOCATION LIST					LOCATION CHECK FUNCTION		BEHAVIOR FUNCTION	RESPONSE FUNCTION	TALKING SPEED	VOICE				VOCAL RANGE
master_grid_add_npc(			npcs.mercurioGallant,		"MERCURIO",		spr_mercurioWalking,	spr_mercurioWalking,	spr_mercurioWalking,	mercurioSpecialAnimations,	encode_list(mercurioTalismans),		encode_list(mercurioSpells),		encode_map(mercurioResponseMap),			encode_list(mercurioLocations), mercurio_location_check,	mercurio_behavior,	mercurio_respond,	2,				sfx_mercurioVoice,	0.5);
master_grid_add_npc(			npcs.naiaSeaspear,			"NAIA",			spr_naiaWalking,		spr_naiaWalking,		spr_naiaWavephone,		naiaSpecialAnimations,		encode_list(naiaTalismans),			encode_list(naiaSpells),			encode_map(naiaResponseMap),				encode_list(naiaLocations),		naia_location_check,		naia_behavior,		naia_respond,		3,				sfx_naiaVoice,		0.8);

// encode the grid
global.allNPCs = encode_grid(global.npcGrid);

var ggg = ds_grid_create(NPC_PARAMS.HEIGHT, npcs.HEIGHT);
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
	var grid = ds_grid_create(NPC_PARAMS.HEIGHT, npcs.HEIGHT);
	decode_grid(global.allNPCs, grid);
	
	// get all parameters
	name				= grid[# NPC_PARAMS.NAME,				ID];
	
	walkingSprite		= correct_string_after_decode(grid[# NPC_PARAMS.WALKING_SPRITE,		ID]);
	swimmingSprite		= correct_string_after_decode(grid[# NPC_PARAMS.SWIMMING_SPRITE,	ID]);
	musicSprite			= correct_string_after_decode(grid[# NPC_PARAMS.MUSIC_SPRITE,		ID]);
	respondFunction		= correct_string_after_decode(grid[# NPC_PARAMS.RESPOND_FUNCTION,	ID]);
	talkingSpeed		= correct_string_after_decode(grid[# NPC_PARAMS.TALKING_SPEED,		ID]);
	voice				= correct_string_after_decode(grid[# NPC_PARAMS.VOICE,				ID]);
	vocalRange			= correct_string_after_decode(grid[# NPC_PARAMS.VOCAL_RANGE,		ID]);
	behaviorFunction	= correct_string_after_decode(grid[# NPC_PARAMS.BEHAVIOR_FUNCTION,	ID]);
	
	//decode_list(grid[# NPC_PARAMS.talismans,			ID],		TALISMANS);
	//decode_list(grid[# NPC_PARAMS.spells,				ID],		SPELLS);
	
	responseMap = ds_map_create();
	decode_map(grid[# NPC_PARAMS.RESPONSE_MAP,			ID],		responseMap);
	
	specialAnimations = ds_list_create();
	decode_list(grid[# NPC_PARAMS.SPECIAL_ANIMATIONS,	ID],		specialAnimations);
	
	parametersLoaded = true;
}

function npc_animate() {
	
	if !(global.gameTime mod 8) {
		if (moving) {
			if (frame >= frameCount) {
				frame = 0;	
			}
			else {
				frame++;	
			}
		}
	}
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