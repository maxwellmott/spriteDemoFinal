enum CUTSCENES {
	DEMO_CUTSCENE_1,
	HEIGHT
}

enum CUTSCENE_PARAMS {
	ID,
	CHARACTER_LIST,					// list of character IDs (NPC enum for humans, sprite enum for sprites)
	CHARACTER_OBJ_TYPES,			// list of object tpyes for different characters on the above list
	STARTING_COORDS_LIST,			// list of starting coordinates--indeces match up with character list
	DIALOGUE_LIST,					//
	LOCATION,
	CAMERA_FOLLOW,
	HEIGHT
}

var textGrid = load_csv("DEMO_CUTSCENE_1_ENGLISH.csv");

function cutscene_create(_ID) {
	// move to location
	
	// get NPC list
	
	// create all characters on character list
	
	// add all instance IDs to usbable list local to cutscene object
}