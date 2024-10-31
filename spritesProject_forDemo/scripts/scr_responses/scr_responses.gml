// This enum contains the enumerated IDs of the following three function types.
// These IDs will be stored between asterisks on each player response. The 
enum RESPONSE_FUNCTION_TYPES {
	GET_NPC_RESPONSE,
	BEGIN_SPAR,
	NAVIGATE_CUTSCENE,
	HEIGHT
}

///@desc This function can be stored behind a response from the player.
/// It gets the key for the NPC dialogue being responded to.
/// It then uses that key as well as the index of the selected response
/// and uses that to get the correct NPC response and then creates a new
/// talk bubble.
function player_reponse_get_npc_response() {
	
}

///@desc This function can be stored behind a response from the player.
/// It gets the ID of the NPC being spoken to, it then starts a match with
/// that NPC.
function player_response_begin_spar() {
	
}


///@desc This function can be stored behind a response from the player.
/// It gets the key for the cutscene dialogue being responded to.
/// It then uses that key as well as the index of the selected response
/// and uses that to get the correct cutscene dialogue to play next.
function player_response_navigate_cutscene() {
	
}

#region BUILD PLAYER RESPONSE MAP

	// initialize temp map
	var playerResponseMap = ds_map_create();

	// load response maps from csv files
	var playerResponseGrid = load_csv("PLAYER_RESPONSES_ENGLISH.csv");
	
	// correct the response grid (remove the placeholder column)
	fix_response_grid(playerResponseGrid);
	
	// convert response grid to map
	convert_grid_to_map(playerResponseGrid, playerResponseMap);
	
	// encode map to a string
	global.playerResponses = encode_map(playerResponseMap);
	
	// destroy temp grid and temp map
	ds_grid_destroy(playerResponseGrid);
	ds_map_destroy(playerResponseMap);

#endregion

/*		--PLAYER RESPONSE MAP STRUCTURE--
		"key"	:	"Question being responded to",/;
					"First response" *functionID*,/;
					"Second response" *functionID*,/;
					....
					
	,/; indicates that each item will either be followed by either a comma or a semicolon. This
		depends on whether any of the strings contain commas (if so, use semicolons to end each item.
		
	Make sure to leave a space between each response and the asterisk preceding the functionID
*/