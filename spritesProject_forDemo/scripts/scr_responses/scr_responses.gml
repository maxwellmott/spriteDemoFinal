///@desc This function can be stored behind a response from the player.
/// It gets the key for the NPC dialogue being responded to.
/// It then uses that key as well as the index of the selected response
/// and uses that to get the correct NPC response and then creates a new
/// talk bubble.
function player_reponse_get_npc_response(_responseIndex, _dialogueKey, _npcID) {
	var ri = _responseIndex;
	var dk = dialogueKey;
	var ni = _npcID;
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
	
	// destroy temp map
	ds_map_destroy(playerResponseMap);

#endregion

/*		--PLAYER RESPONSE GRID STRUCTURE--
		"key"	:	{(["Question being asked" ]	["First response" ] ["Second response" ]....)
					(["Question being asked" ]["First response" ]["Second response" ]....)
					....}
*/