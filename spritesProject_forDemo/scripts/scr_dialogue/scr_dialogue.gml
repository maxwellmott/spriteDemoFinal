// this enumerator contains the different types of talkbubbles
enum TALK_BUBBLE_TYPES {
	TOP_LEFT_NORMAL,
	TOP_LEFT_FIXED,
	TOP_RIGHT_NORMAL,
	TOP_RIGHT_FIXED,
	BOTTOM_LEFT_NORMAL,
	BOTTOM_LEFT_FIXED,
	BOTTOM_RIGHT_NORMAL,
	BOTTOM_RIGHT_FIXED
}

#macro	EMO_GIFT_NUM		414
#macro	EMO_SPAR_NUM		416

// these global variables store the information about who is talking
// and what they're saying
global.speaker		= noone;
global.dialogueGrid	= -1;

// initialize global.dialogueRow
global.dialogueRow = -1;

// initialize global.dialogueColumn
global.dialogueColumn = -1;

// initialize global.dialogueKey
global.dialogueKey = -1;

// @TODO CREATE A MAP CONTAINING KEYS THAT MATCH DIALOGUE MAP KEYS AND VALUES THAT
//			INDICATE AN UNLOCKABLE OF SOME TYPE ALONG WITH ITS ID

enum emotions {
	joyful,
	angry,
	irked,
	happy,
	sad,
	crying,
	pleased,
	enamored,
	disappointed,
	unamused,
	doubtful,
	embarrassed,
	nervous,
	eyeroll,
	stunned,
	height
}

var nameList = ds_list_create();

nameList[| emotions.stunned]		= "stunned";
nameList[| emotions.eyeroll]		= "eyeroll";
nameList[| emotions.nervous]		= "nervous";
nameList[| emotions.embarrassed]	= "embarrassed";
nameList[| emotions.doubtful]		= "doubtful";
nameList[| emotions.unamused]		= "unamused";
nameList[| emotions.disappointed]	= "disappointed";
nameList[| emotions.enamored]		= "enamored";
nameList[| emotions.pleased]		= "pleased";
nameList[| emotions.crying]			= "crying";
nameList[| emotions.sad]			= "sad";
nameList[| emotions.happy]			= "happy";
nameList[| emotions.irked]			= "irked";
nameList[| emotions.angry]			= "angry";
nameList[| emotions.joyful]			= "joyful";

global.emotionNames = encode_list(nameList);

ds_list_destroy(nameList);

// declare an enum containing all dialogue unlock types
enum DIALOGUE_UNLOCK_TYPES {
	SPELL,
	TALISMAN,
	CONTACT,
	CLOTHING_DYE,
	HAIR_DYE,
	OUTFIT,
	HAIRSTYLE,
	HAT,
	FOOTWEAR,
	ACCESSORY,
	EYEWEAR,
	INVENTORY_ITEM,
	HEIGHT
}

/* FIX THE ENCODING KEY SO IT WORKS LIKE THIS

	ONLY HAVE ONE ENCODED COMMAND, AND IT LOOKS LIKE THIS:
		*<`ACTION _ID`ARGUMENT`ARGUMENT`...>*
	WHEN YOU COME ACROSS AN ASTERISK, DECODE EVERYTHING BETWEEN IT
	AND THE NEXT ONE AS A DS_LIST. DIFFERENT ACTIONS WILL HAVE DIFFERENT
	ARGUMENTS, BUT ARGUMENT[0] WILL ALWAYS BE ACTION_ID

*/

/*
	encoding key (character IDs refers to a specific ID for this context wherein the lists of
	npcs and the list of sprites are both added together.
	
	ID									ARGUMENTS
	...ADD PATHS						LIST OF CHARACTERS TO MOVE						LIST OF PATHS TO FOLLOW (MATCH INDECES W CHARACTER LIST)
	...MOVE CAMERA						PATH FOR CAMERA TO FOLLOW						SPEED FOR CAMERA TO MOVE (PIXELS PER 60 FRAMES)
	...CHANGE CAMERA FOLLOW				CHARACTER ID OF THE OBJECT TO FOLLOW		
	...DISPLAY EMOJIS					LIST OF CHARACTERS TO EMOTE						LIST OF EMOTIONS TO DISPLAY (NUMBERS FROM EMOTIONS ENUM)
	...TRIGGER UNLOCK					UNLOCK TYPE ID									ID FOR PARTICULAR UNLOCK (ITEM ID, TALISMAN ID, SPELL ID, ETC)
	...CHANGE MUSIC						ID OF NEW MUSIC	(-1 FOR STOP)			
	...CUTSCENE NEW DIALOGUE GRID		THE NAME OF THE CSV FILE TO LOAD (WITH .csv)
	...BEGIN SPAR						(currently just starts a spar with the speaker, this should be fixed after completing the grid of npc sparsets)
	...END CUTSCENE						
	...START NEW CUTSCENE				CUTSCENE ID
	...SKIP INPUT PAUSE					
	...INSERT PLAYER NAME				
	...INSERT PLAYER PRONOUNS			PRONOUN TYPE ID (POSSESSIVE, CONJUNCTIVE, ETC)
	...CHANGE TALKING SPEED				NEW TALKING SPEED
	...RESET TALKING SPEED		
	...NEXT PAGE
*/


///@desc This function will check the same thing for every NPC,
/// it will basically find a key with a particular phrase in it
/// (e.g. "morningGreeting") and return what it finds at that key
function npc_check_general_dialogue() {
	
}

///@desc This function simply calls the NPC specific function that
/// checks heuristics in order of priority to get and return any
/// special dialogue that might need to happen depending on the circumstances
function npc_check_special_dialogue() {
	
}

///@desc This function is called in the talk bubble clean up phase when there
/// are paths on the dialoguePaths. It sets all of the given characters to begin walking
/// the given paths.
function dialogue_post_paths() {
	
}

///@desc This function is called in the talk bubble clean up phase when there
/// are emotes on the dialogueEmotes. It sets all of the given characters to begin
/// displaying the given emotes.
function dialogue_post_emotes() {
	
}

///@desc This function is called by the talk_bubble_build_dialogue function
/// whenever the function comes upon an encoded action. This function takes
/// the encoded list stored between the asterisks, decodes it, then
/// performs some action depending on the encoded information.
function dialogue_perform_action(_encodedList) {
	// store args in locals
	var el = _encodedList;
	
	// decode list of arguments
	var args = ds_list_create();
	decode_list(el, args);
	
	// get the the action ID from the list of arguments
	var actionID = args[| 0];
	
	// use a switch statement to perform the action
	switch (actionID) {
		case "ADD PATHS":
			// get the list of characters
			var charList = ds_list_create();
			decode_list(args[| 1], charList);
			
			// get the list of paths
			var pathList = ds_list_create();
			decode_list(args[| 2], pathList);
			
			// check each entry on the two lists
			var i = 0;	repeat (ds_list_size(charList)) {
				var char = correct_string_after_decode(charList[| i]);
				
				var path = correct_string_after_decode(pathList[| i]);
				
				// if path is valid, add it to the grid
				if (path < PATHS.HEIGHT) 
				&& (path >= 0) {
					// resize overworld.dialoguePaths
					ds_grid_resize(dialoguePaths, 2, ds_list_size(charList));
					
					// store the character in the path grid
					dialoguePaths[# 0, i] = char;
					
					// store the path in the grid
					dialoguePaths[# 1, i] = path;
				}
				
				// increment i
				i++;
			}
		
		break;
		
		case "MOVE CAMERA":
		
		break;
		
		case "CHANGE CAMERA FOLLOW":
		
		break;
		
		case "DISPLAY EMOJIS":
			// get the list of characters
			var charList = ds_list_create();
			decode_list(args[| 1], charList);
			
			// get the list of emotions
			var emoList = ds_list_create();
			decode_list(args[| 2], emoList);
			
			// check each entry on the two lists
			var i = 0;	repeat (ds_list_size(charList)) {
				var emo = correct_string_after_decode(emoList[| i]);
				
				var char = correct_string_after_decode(charList[| i]);
				
				// if emotion is valid, add it to the grid
				if (emo < emotions.height) 
				&& (emo >= 0) {
					// resize overworld.dialogueEmotes
					ds_grid_resize(dialogueEmotes, 2, ds_list_size(charList));
					
					// store the character in the emotion grid
					dialogueEmotes[# 0, i] = char;
					
					// store the emotion in the emotion grid
					dialogueEmotes[# 1, i] = emo;
				}				
			
				// increment i
				i++;
			}
		break;
		
		case "TRIGGER UNLOCK":
			// get the unlock type
			
			// get the id indicating the specific unlockable
			
			// use a switch statement to call the correct unlock function for the given type
			
		break;
		
		case "CHANGE MUSIC":
			// get the indicated music id
			
			// pass a new bgm to the audioManager
		break;

		case "CUTSCENE NEW DIALOGUE GRID":
			
		break;
		
		case "BEGIN SPAR":
			beginSpar = true;
		break;
		
		case "END CUTSCENE":
		
		break;
		
		case "START CUTSCENE":
		
		break;
		
		case "SKIP INPUT PAUSE":
			waitForInput = false;
		break;
		
		case "INSERT PLAYER NAME":
			// get the player's name
			var pn = player.name;
			
			// insert the player's name into the text, right after the encodedList
			text = string_insert(pn, text, string_length(_encodedList));
		break;
		
		case "INSERT PLAYER PRONOUNS":
			
		break;
		
		case "CHANGE TALKING SPEED":
		
		break;
		
		case "RESET TALKING SPEED":
		
		break;
		
		case "CHANGE VOCAL RANGE":
		
		break;
		
		case "RESET VOCAL RANGE":
		
		break;
		
		case "NEXT PAGE":
			// increment currentPage and reset currentLine
			currentPage++;
			pages[|currentPage] = "";
			currentLine = 1;
		break;
	}
	
	// delete the action code from the dialogue string
	text = string_delete(text, 1, string_length(_encodedList));
}

///@desc This function is used to build the text pages from and properly
/// handle all encoded symbols within a set of text being called for
/// dialogue.
function talk_bubble_build_dialogue() {
	var last_space = 1;
	
	var height = 6;
	var maxLines = 3;
	
	pages[| currentPage] = "";

	while (string_length(text) > 0) {
		
		// CHECK IF THE TEXT INDICATES A DIALOGUE ACTION
		if (string_char_at(text, 1)) == "*" {										//READY TO TEST
			// remove the first asterisk
			text = string_delete(text, 1, 1);
			
			// find the position of the second asterisk
			var endPos = string_pos("*", text);
			
			// get the encoded list
			var el = string_copy(text, 1, endPos - 1);
			
			// remove the second asterisk
			text = string_delete(text, endPos, 1);
			
			dialogue_perform_action(el);	
		}
		
		// check if the next character is a space
		else if (string_char_at(text, 1)) == " " {										//READY TO TEST
			// add the first space to the current page
			pages[| currentPage] += " ";
			
			// delete the first space
			text = string_delete(text, 1, 1);
			
			// find the next space
			var endPos = string_pos(" ", text);
			
			// use the position of the next space to get the nextWord
			var nextWord = string_copy(text, 1, endPos);
			
			// check if the nextWord will fit on the current line
			var checkString		= string_insert(nextWord, pages[| currentPage], string_length(pages[| currentPage]));
			var checkWidth		= string_width(checkString);
			
			var sl = string_length(pages[| currentPage]);
			
			if (checkWidth <= textWidth) {
				// if it fits, add the nextWord to the currentPage
				pages[| currentPage] += nextWord;
			}
			// else statement if the nextWord doesn't fit on the current line
			else {
				// check if there is room on the currentPage for a new line
				if (currentLine + 1 <= maxLines) {
					// if there is room for a new line, add the new line
					pages[| currentPage] += "\n";
					
					// increment currentLine
					currentLine++;
					
					// add the nextWord to the currentPage
					pages[| currentPage] += nextWord;
				}
				// else statement if there is not room for a new line
				else {
					// increment currentPage
					currentPage++;
					
					// initialize next page
					pages[| currentPage] = "";
					
					// initialize currentLine
					currentLine = 1;
					
					// add nextWord
					pages[| currentPage] += nextWord;
				}
			}
			
			// delete nextWord from text
			text = string_delete(text, 1, endPos - 1);
		}
		
		// if the next char is a regular character, add it
		else {																			//READY TO TEST
			// get next character
			var char = string_char_at(text, 1);
			
			// check if there's room on the current line
			var checkString = char;
			var checkWidth = string_width(checkString);
			
			if (checkWidth <= textWidth) {
				// add the character
				pages[| currentPage] = string_insert(char, pages[| currentPage], string_length(pages[| currentPage]));
				
			}
			// else statement if there's no room on the current line
			else {
				// check if there's room for another line on the current page
				if (currentLine + 1 <= maxLines) {
					// add a new line
					pages[| currentPage] += "\n";
					
					// increment current line
					currentLine++;
					
					// add the character to the new line
					pages[| currentPage] = string_insert(char, pages[| currentPage], string_length(pages[| currentPage]));
					
				}
				// else statement if there's no room for another line
				else {
					// increment current page
					currentPage++;
					
					// initialize new page
					pages[| currentPage] = "";
					
					// initialize current line
					currentLine = 1;
					
					// add the character to the new page
					pages[| currentPage] = string_insert(char, pages[| currentPage], string_length(pages[| currentPage]));
					
				}
			}
			
			// delete the character from the text
			text = string_delete(text, 1, 1);
		}
	}
}