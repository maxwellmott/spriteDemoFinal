global.keyboardPrompt = -1;

// create temp keyboard list
var charList = ds_list_create();

// build keyboard character list (with shift 
// and no shift options)
ds_list_add(charList,	"1,1,",
						"2,2,",
						"3,3,",
						"4,4,",
						"5,5,",
						"6,6,",
						"7,7,",
						"8,8,",
						"9,9,",
						"0,0,",
						"a,A,",
						"b,B,",
						"c,C,",
						"d,D,",
						"e,E,",
						"f,F,",
						"g,G,",
						"h,H,",
						"i,I,",
						"j,J,",
						"k,K,",
						"l,L,",
						"m,M,",
						"n,N,",
						"o,O,",
						"p,P,",
						"q,Q,",
						"r,R,",
						"s,S,",
						"t,T,",
						"u,U,",
						"v,V,",
						"w,W,",
						"x,X,",
						"y,Y,",
						"z,Z,",
						"-,',",
						"<,>,");

// encode the charList
global.keyboardCharacters = encode_list(charList);

// destroy the temp list
ds_list_destroy(charList);

function keyboard_press_key(_keyID) {
	// store args in locals
	var k = _keyID;
	
	// check if the given keyID is a normal character key
	if (k < charCount) {
		var l = -1;
		
		// get the correct character list depending on shiftSet
		if (shiftSet)	l = shiftList;
		if !(shiftSet)	l = charList;
		
		// check if inputString is below the limit
		if (string_length(inputString) < limit) {
			// add the given character to the inputString
			inputString += l[| k];
		}
	}
	else {
		// check if this is the shift key
		if (k == charCount) {
			// switch shiftSet
			shiftSet = !shiftSet;
		}
		
		// check if this is the delete key
		if (k == charCount + 1) {
			// get length of inputString
			var sl = string_length(inputString);
			
			// check if sl is greater than 0
			if (sl > 0) {
				inputString = string_delete(inputString, sl, 1);	
			}
		}
		
		// check if this is the clear key
		if (k == charCount + 2) {
			// reset inputString
			inputString = "";
		}
		
		// check if this is the accept key
		if (k == charCount + 3) {
			if (string_length(inputString) > 0) {
				acceptFunction();	
			}
		}
	}
}

// enum for all keyboardPrompts
enum KEYBOARD_PROMPTS {
	CHARACTER_NAME,
	TEAM_NAME,
	HEIGHT
}

// enum for keyboardPromptParams
enum KEYBOARD_PROMPT_PARAMS {
	ID,
	PROMPT_STRING,
	ACCEPT_FUNCTION,
	CHAR_LIMIT,
	HEIGHT
}

// create all keyboard prompt functions
function keyboard_accept_character_name() {
	// set pnMenuEntering to true
	pnMenuEntering = true;
}

//  
function keyboard_accept_name_and_pronouns() {
	// set player name
	player.name = inputString;
	
	// set player pronouns
	player.pronouns = selectedPronouns;
	
	// save game
	build_save_file();
	
	// put the player back into the overworld
	room_transition(player.x, player.y, player.facing, rm_overworld, bgm_magicIsInTheAir);
}

function keyboard_accept_team_name() {
	
}

// create temp grid
global.keyboardPromptGrid = ds_grid_create(KEYBOARD_PROMPT_PARAMS.HEIGHT, KEYBOARD_PROMPTS.HEIGHT);

// create function to add to grid
function master_grid_add_keyboard_prompt(_ID) {
	var i = 0;	repeat (KEYBOARD_PROMPT_PARAMS.HEIGHT) {
		global.keyboardPromptGrid[# i, _ID] = argument[i];
	
		// increment i
		i++;
	}
}

// add all keyboard prompts
master_grid_add_keyboard_prompt(KEYBOARD_PROMPTS.CHARACTER_NAME,	"Enter the name of your character!",		keyboard_accept_character_name,		12);
master_grid_add_keyboard_prompt(KEYBOARD_PROMPTS.TEAM_NAME,			"What would you like to name this team?",	keyboard_accept_team_name,			14);

// encode master grid
global.allKeyboardPrompts = encode_grid(global.keyboardPromptGrid);

// destroy temp grid
ds_grid_destroy(global.keyboardPromptGrid);