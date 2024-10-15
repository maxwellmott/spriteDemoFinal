// these global variables store the information about who is talking
// and what they're saying
global.speaker		= noone;
global.dialogue		= "";

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

/*
	encoding key
	
	^[x,y][x,y]...^		= make speaker walk given path
	*emotion*			= make speaker display given emotion
	_					= insert player name
	|					= next page
	&					= don't wait for player to click enter
*/

///@desc This function is used to build the text pages from and properly
/// handle all encoded symbols within a set of text being called for
/// dialogue.
function talk_bubble_build_dialogue() {
	var currentPage = 0;
	
	pages[| currentPage] = "";
	
	var last_space = 1;
	
	var currentLine = 1;
	
	var height = string_height(text);
	var maxLines = (bubbleHeight div height) - 1;
	
	pages[| currentPage] = "";

	while (string_length(text) > 0) {
		// check if the text signals to start walking a path
		if (string_char_at(text, 1)) == "^" {											//READY TO TEST
				// delete the opening signal character
				text = string_delete(text, 1, 1);
				
				// get the number containing the truth value of whether dialogue
				// should continue while the path is being walked
				var boolString	= string_copy(text, 1, 1);
				var pathBool	= real(boolString);
				
				// remove the number
				text = string_delete(text, 1, 1);
				
				// find the position of the first bracket
				var startPos = string_pos("[", text);				
				
				// find the next signal character to get the size of the coordString
				var endPos = string_pos("^", text) -1;				
				
				// store the whole group of coordinate pairs in a substring
				var coordString = string_copy(text, 1, endPos);
				
				// get the number of coordinate pairs
				var coordCount = string_count("[", coordString);
				
				// create a list to store the coordinate pairs
				var coordList = ds_list_create();
				
				// use a repeat loop to get each pair of coordinates
				// and store them in an encoded list
				var i = 0; repeat(coordCount) {
					var openingPos = string_pos("[", coordString);
					var closingPos = string_pos("]", coordString);
					
					var coords = string_copy(coordString, 1, closingPos);
					
					coordList[| i] = coords;
					
					coordString = string_delete(coordString, openingPos, closingPos);
				}
				
				// delete the coordString from the text
				text = string_delete(text, 1, endPos);
				
				// resize the pathGrid
				ds_grid_resize(pathGrid, 4, pathCount + 1);
				
				// add currentPage to pathGrid
				pathGrid[# 0, pathCount] = currentPage;
				
				// add currentLength to pathGrid
				pathGrid[# 1, pathCount] = string_length(pages[| currentPage]);
				
				// add pathBool to pathGrid
				pathGrid[# 2, pathCount] = pathBool;
				
				// add the encoded coordString to the pathGrid
				pathGrid[# 3, pathCount] = encode_list(coordList);
				
				// increment pathCount
				pathCount++;
			}
		
		// check if the text signals to display an emotion
		else if (string_char_at(text, 1)) == "*" {										//READY TO TEST
				// delete the opening signal character
				text = string_delete(text, 1, 1);
				
				// get the number at the beginning of the emotion string
				// that represents the truth value of whether the dialogue should
				// continue or pause
				var boolString	= string_copy(text, 1, 1);
				var emoBool		= real(boolString);
				
				// delete the boolString
				text = string_delete(text, 1, 1);
				
				// get the position of the next signal character
				var endPos = string_pos("*", text);
				
				// get emotion string
				var emotionString = string_copy(text, 1, endPos - 1);
				
				// initialize emotion variable
				var emo = -1;
				
				// get emoCount
				var emoCount = ds_grid_height(overworld.dialogueEmotes);
				
				// use switch statement to get emotion from enum
				switch (emotionString) {
					case "JOYFUL":
						emo = emotions.joyful;
					break;
					
					case "ANGRY":
						emo = emotions.angry;
					break;
					
					case "IRKED":
						emo = emotions.irked;
					break;
					
					case "HAPPY":
						emo = emotions.happy;
					break;
					
					case "SAD":
						emo = emotions.sad;
					break;
					
					case "CRYING":
						emo = emotions.crying;
					break;
					
					case "PLEASED":
						emo = emotions.pleased;
					break;
					
					case "ENAMORED":
						emo = emotions.enamored;
					break;
					
					case "DISAPPOINTED":
						emo = emotions.disappointed;
					break;
					
					case "UNAMUSED":
						emo = emotions.unamused;
					break;
					
					case "DOUBTFUL":
						emo = emotions.doubtful;
					break;
					
					case "EMBARRASSED":
						emo = emotions.embarrassed;
					break;
					
					case "NERVOUS":
						emo = emotions.nervous;
					break;
					
					case "EYEROLL":
						emo = emotions.eyeroll;
					break;
					
					case "STUNNED":
						emo = emotions.stunned;
					break;
					
					case "SPAR":
						global.opponent		= global.speaker.ID;
						global.ynFunction	= spar_begin_ingame;
				}
				
				// delete emotion string from text
				text = string_delete(text, 1, endPos);
				
				// if emotion is not SPAR, add emotion to grid
				if (emo != -1) {
					// resize overworld.dialogueEmotes
					ds_grid_resize(overworld.dialogueEmotes, 4, emoCount + 1);
					
					// store the currentPage in the emotion grid
					overworld.dialogueEmotes[# 0, emoCount] = currentPage;
					
					// store the currentLength in the emotion grid
					overworld.dialogueEmotes[# 1, emoCount] = string_length(pages[| currentPage]);
					
					// store the emoBool in the emotion grid
					overworld.dialogueEmotes[# 2, emoCount] = emoBool;
					
					// store the emotion in the emotion grid
					overworld.dialogueEmotes[# 3, emoCount] = emo;
					
					// increment emoCount
					emoCount++;
				}				
			}
		
		// check if the text signals to insert the player's name
		else if (string_char_at(text, 1)) == "_" {										//READY TO TEST
				// delete the signal character
				text = string_delete(text, 1, 1);
				
				// initialize punc variable
				var punc = "";
				
				// check if there is punctuation immediately after the signal character
				if (string_char_at(text, 1) != " ") {
					punc = string_copy(text, 1, 1);
				}
				
				// add punc variable to the player's name
				var nameString = player.name;
				var nameLength = string_length(nameString);
				nameString = string_insert(punc, nameString, nameLength);
				
				// check if nameString will fit on the currentLine
				var checkString		= string_insert(nameString, pages[| currentPage], string_length(pages[| currentPage]));
				var checkWidth		= string_width(checkString);
				
				if (checkWidth <= bubbleWidth) {
					// if it fits, add the nameString to the currentLine of the currentPage
					pages[| currentPage] = checkString;
				}
				// else statement in case it doesn't fit
				else {
					// if it doesn't fit, check to see if the next line will fit on the currentPage
					if (currentLine + 1 <= maxLines) {
						// if there's rooom on the currentPage for one more line, add the nameString to that line
						pages[| currentPage] = string_insert("\n", pages[| currentPage], string_length(pages[| currentPage]));
						pages[| currentPage] = string_insert(nameString, pages[| currentPage], string_length(pages[| currentPage]));
						currentLine++;
					}
					// else statement in case there isn't room for one more line
					else {
							// if there's no room for one more line, increment current page
							currentPage++;
							pages[| currentPage] = "";
							pageLength = string_length(pages[| currentPage]);
							currentLine = 1;
							
							// add nameString to the new page
							pages[| currentPage] = string_insert(nameString, pages[| currentPage], string_length(pages[| currentPage]));
					}
				}
				
				// delete nameString from text
				var nameStringLength = string_length(nameString);
				text = string_delete(text, 1, nameStringLength);
			}
		
		// check if the text signals to skip to the next page
		else if (string_char_at(text, 1)) == "|" {										//READY TO TEST
				// delete the signal character
				text = string_delete(text, 1, 1);
				 
				// increment currentPage and reset currentLine
				currentPage++;
				pages[|currentPage] = "";
				currentLine = 1;
			}
		
		// check if the text signals to move on without player input
		else if (string_char_at(text, 1)) == "&" {										//READY TO TEST
				// delete the signal character
				text = string_delete(text, 1, 1);
				
				// set waitForInput to false
				waitForInput = false;
			}
		
		// check if the text signals to change the talkingSpeed
		else if (string_char_at(text, 1)) == "$" {										//READY TO TEST
				// delete first signal character
				text = string_delete(text, 1, 1);
				
				// find next signal character
				var endPos = string_pos("$", text);
				
				// get speed string
				var speedString = string_copy(text, 1, endPos - 1);
				
				// get spd variable
				var spd = real(speedString);
				
				// delete speed string from text
				text = string_delete(text, 1, endPos);
				
				// resize speedGrid
				ds_grid_resize(speedGrid, 3, speedCount + 1);
				
				// store the currentPage in the speed grid
				speedGrid[# 0, speedCount] = currentPage;
				
				// store the currentLength in the speed grid
				speedGrid[# 1, speedCount] = string_length(pages[| currentPage]);
				
				// store the emotion in the speed grid
				speedGrid[# 2, speedCount] = spd;
				
				// increment emoCount
				speedCount++;
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
			
			if (checkWidth <= bubbleWidth) {
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
			
			if (checkWidth <= bubbleWidth) {
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