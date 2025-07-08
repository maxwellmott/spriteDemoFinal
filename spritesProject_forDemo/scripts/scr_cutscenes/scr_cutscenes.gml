global.currentCutscene = -1;

// declare an enumerator containing all cutscene IDs
enum CUTSCENES {
	DEMO_CUTSCENE_1,
	HEIGHT
}

// declare an enumerator containing all cutscene parameters
enum CUTSCENE_PARAMS {
	ID,
	CHARACTER_LIST,					// list of character IDs (NPC enum for humans, sprite enum + NPCs.height for sprites)
	CHARACTER_OBJ_TYPES,			// list of object tpyes for different characters on the above list
	STARTING_COORDS_LIST,			// list of starting coordinates--indeces match up with character list
	DIALOGUE_LIST,					// list of steps to be taken in the cutscene (each step is an encoded list containing [character list num, instructions (coordiates, dialogue, emoji, etc))]) on the given beat
	SPEAKER_LIST,				
	START_LOCATION,		
	START_CAMERA_FOLLOW,
	HEIGHT
}

#region CREATE ALL CHARACTER LISTS

#endregion

#region CREATE ALL CHARACTER OBJ TYPE LISTS

#endregion

#region CREATE ALL STARTING COORDS LISTS

#endregion

#region CREATE ALL DIALOGUE LISTS

#endregion

#region CREATE ALL SPEAKER LISTS

#endregion

/* CUTSCENE DIALOGUE SPECIAL ACTION ENCODING KEY

	...MOVE CHARACTER (player = npcs.height + sprites.height)
	...MOVE LIST OF CHARACTERS (each character on list is paired with list of coordinates to follow)
	...MOVE CAMERA 
	...CHANGE CAMERA FOLLOW
	...DISPLAY EMOJIS
	...TRIGGER UNLOCK
	...CHANGE BACKGROUND MUSIC
	...PAUSE BACKGROUND MUSIC
	...LOAD NEW DIALOGUE GRID (This might happen if the player has to give input during a cutscene)
	...END CUTSCENE
	...START NEW CUTSCENE
(add any of these that are missing from the dialogue encoding system)
*/

// load all text to a text grid
var textGrid = load_csv("DEMO_CUTSCENE_1_ENGLISH.csv");

// create the cutscene master grid
global.cutsceneGrid = ds_grid_create(CUTSCENE_PARAMS.HEIGHT, CUTSCENES.HEIGHT);

// create a function to add to the cutscene grid
function master_grid_add_cutscene(_ID, _characterList, _characterObjTypes, _startingCoordsList, _dialogueList, _speakerList, _startLocation, _startCameraFollow) {
	// use a repeat loop to add all arguments to the given row
	var i = 0;	repeat (CUTSCENE_PARAMS.HEIGHT) {
		// add the current argument
		global.cutsceneGrid[# i, _ID] = argument[i];
	
		// increment i
		i++;
	}
}

// add all cutscenes to the master grid

///@desc This function is called whenever a new cutscene should begin
function cutscene_begin(_cutsceneID) {
		
}