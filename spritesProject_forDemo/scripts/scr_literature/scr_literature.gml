// enumerator containing literature IDs
enum literatureIDs {
	inhumanEntities,					//a book describing everything about sprites from a scientific perspective
	twmFirstEdition,					//scrolls abt fake jesus. Changing over time to show how politics shape the narratives fed to people. needs to be actually named, I'm not sure what that acronym is lmao
	twmSecondEdition,					//
	twmThirdEdition,					//
	twmFourthEdition,					//
	twmFifthEdition,					//
	pureMagic,							//a slightly narrative book on wavephones, the way they work and their significance in magic
	sparmastersHandbook,				//book on everything you need to know regarding cosmic spars
	illuminiad,							//high level magic book
	sacriLibriI,						//the standard scrolls for learning magic--introductory volume
	sacriLibriII,						//volume on the elements and their roles in nature
	sacriLibriIII,						//volume on life energy (MP) and how healing and trick spells work (mind over matter)
	sacriLibriIV,						//volume on the way that magic closes the circle
	sacriLibriV,						//volume on how to live magically
	epicOfTheAeons,						//genesis as told by the dwarven plates
	phremnsBirth,						//book that blends science with myth and attempts to explain dwarven plates found on Stackrock.
	mysticalDoctrine,					//bible as told by the dwarven plates
	threeWitchesGrimoireVol1,			//books on giving into chaos and tapping into your innate magical powers--volume on how you aren't really anywhere
	threeWitchesGrimoireVol2,			//volume on how if you tried to consider every possible factor you would never stop counting variables
	threeWitchesGrimoireVol3,			//volume on how giving up or not giving up will not change anything for you but the way you see the world. But by the time you finish this book, you understand that your view of the world is everything
	cosmicTreatise,						//translation of dwarven scroll that seems to describe the predicament regarding the mystical wall around stackrock.
	legendsOfStackrockVol1,				//encyclopedia of the most important events. year 0-249
	legendsOfStackrockVol2,				//years 250-499
	legendsOfStackrockVol3,				//years 500-749
	legendsOfStackrockVol4,				//years 750-999
	legendsOfStackrockVol5,				//years 1000-1250
	sousVide,							//a trippy, amateur book that describes the way that the sprite dimension works
	aBookOnSprites1,					//ethnographies written by a woodsman who loved sprites--volume on appearances
	aBookOnSprites2,					//volume on abilities and behaviors
	aBookOnSprites3,					//volume on their general nature and role in the surrounding ecosystems--including social and industrial ecosystems!
	height
}

// enumerator containing literature params
enum literatureParams {
	ID,
	title,
	author,
	object,
	color,
	text,
	font,
	images,
	height
}

// enumerator containing bookcase types
enum bookcaseTypes {
	standardWood1,
	height
}

// enumerator containing bookcase params
enum bookcaseParams {
	ID,
	type,
	facing,
	_x,
	_y,
	bookList,
	height
}

// get all of the text from the csv file containing literature names
// and contents
var textGrid = load_csv("LITERATURE_ENGLISH.csv");

#region CREATE ALL IMAGE LISTS

// INHUMAN ENTITIES
	// initialize list
	var inhumanEntitiesImages = ds_list_create();
	
	// add all images
	ds_list_add(inhumanEntitiesImages, string_digits(spr_inhumanEntities1) + ",");
	
#endregion

// initialize the literature grid
global.literatureGrid = ds_grid_create(literatureParams.height, literatureIDs.height);

// create master grid add function
function master_grid_add_literature(_ID) {
	var i = 0; repeat (literatureParams.height) {
		global.literatureGrid[# i, _ID] = argument[i];
		
		i++;
	}
}

// add all literature to literature grid
master_grid_add_literature(literatureIDs.inhumanEntities, "Inhuman Entities", "Gregoria Von Verstolen", guiBook, colors.brown, textGrid[# 1, literatureIDs.inhumanEntities], cursiveFont, encode_list(inhumanEntitiesImages));

// encode listerature grid
global.allLiterature = encode_grid(global.literatureGrid);

///@desc This function gets all of the parameters for a piece of literature when
/// it's being loaded into a new location
function literature_get_params() {
	var tempGrid = ds_grid_create(literatureParams.height, literatureIDs.height);
	
	decode_grid(global.allLiterature, tempGrid);
	
	var colorNum	=	real(tempGrid[# literatureParams.color,		ID]);
	
	var colorList = ds_list_create();
	decode_list(global.allColors, colorList);
	
	color = real(colorList[|colorNum]);
	
	ds_list_destroy(colorList)
	
	text =	tempGrid[# literatureParams.text, ID];
	font =	real(string_digits(tempGrid[# literatureParams.font, ID]));
	
	var encList = tempGrid[# literatureParams.images,		ID];
	decode_list(encList, spriteIDs);
	
	ds_grid_destroy(tempGrid);
}

///@desc This function is called when the player opens a book. The function builds 
/// all of the pages of text into a book format
function book_build_text(_string) {
	var text = _string;
	
	var last_space = 1;
	
	var currentLine = 1;
	var currentPage = 1;
	var newPage = true;
	
	var height = string_height(text);
	var maxLines = (pageHeight div height);
	
	pages[| 0] = "";
	pages[| 1] = "";

	while (string_length(text) > 0) {		
		// if the text signals to start a new line, add the substring to the current page,
		// then add the newLine to the substring and increment the currentLine
		if (string_char_at(text, 1) == "+") {				
				// delete the signal character
				text = string_delete(text, 1, 1);
				
				// add the new line to the current page
				pages[|currentPage] = string_insert("\n", pages[|currentPage], string_length(pages[|currentPage]));
				
				// increment currentline
				currentLine++;
			}
		
		// if the text signals to start a new page, add the substring to the current page,
		// then increment the count and the page
		if (string_char_at(text, 1) == "|") {
				// delete the signal character
				text = string_delete(text, 1, 1);
				 
				// increment currentPage and reset currentLine
				newPage = true;
				currentPage++;
				pages[|currentPage] = "";
				pages[|currentPage + 1] = "";
				currentLine = 1;
			}
		
		// if the text signals that there is a heading, add the substring to the current page,
		// then add the heading to the headingGrid and add lines to create space 
		if (string_char_at(text, 1) == "%") {				
				// delete the opening signal character
				text = string_delete(text, 1, 1);
				
				// get the heading and remove it from the text
				var endPos = string_pos("%", text);
				var headingLength = endPos - 2;
				var headingString = string_copy(text, 1, headingLength + 1);
				
				// delete the signal encoded in the text
				text = string_delete(text, 1, headingLength + 2);
				
				// get the x and y position for the heading
				var headingY = (height * (currentLine - 1)) + textY;
				if !(currentPage mod 2) var headingX = leftPageX + (pageWidth / 2);
					else var headingX = rightPageX + (pageWidth / 2);
					
				var newGridY = headingCount + 1;
				ds_grid_resize(headingGrid, 4, newGridY);	
					
				// add all heading parameters to headingGrid
				headingGrid[# 0, headingCount] = format_text(headingString, pageWidth, 4, 1);
				headingGrid[# 1, headingCount] = headingX;
				headingGrid[# 2, headingCount] = headingY;
				headingGrid[# 3, headingCount] = currentPage;
				
				// increment headingCount
				headingCount++;
				
				// clear a line for the heading
				pages[|currentPage] = string_insert("\n", pages[|currentPage], string_length(pages[|currentPage]));
				
				// increment currentLine
				currentLine++;
			}
		
		// if the text signals to draw an image, add the substring to the current page,
		// then add the image to the imageGrid and add lines to create space
		if (string_char_at(text, 1) == "*") {
				// get the ID and height of the sprite signaled by the text
				text			= string_delete(text, 1, 1);
				var endPos		= string_pos("*", text);
				var imageLength = endPos - 1;
				var imageString = string_copy(text, 1, imageLength + 1);
				var imageIndex	= real(string_digits(imageString));
				var imageID		= real(string_digits(spriteIDs[|imageIndex]));
				var imageHeight = sprite_get_height(imageID);
				
				var linesNeeded = (imageHeight div height);
				
				if (currentLine + linesNeeded) > maxLines {
					newPage = true;
					currentPage++;
					pages[|currentPage] = "";
					pages[|currentPage + 1] = "";
					currentLine = 1;
				}
				
				// delete the signal encoded in the text
				text = string_delete(text, 1, imageLength + 2);
				
				// get the x and y at which to draw the image
				var imageY = (height * (currentLine)) + textY;
				if !(currentPage mod 2) var imageX = leftPageX + (pageWidth / 2);
					else var imageX = rightPageX + (pageWidth / 2);
					
				// resize image grid
				var newGridY = imageCount + 1;
				ds_grid_resize(imageGrid, 4, newGridY);
					
				// add all image parameters to imageGrid
				imageGrid[# 0, imageCount] = imageID;
				imageGrid[# 1, imageCount] = imageX;
				imageGrid[# 2, imageCount] = imageY;
				imageGrid[# 3, imageCount] = currentPage;
					
				// increment imageCount
				imageCount++;
				
				// clear space for the image
				repeat (linesNeeded) {
					pages[|currentPage] = string_insert("\n", pages[|currentPage], string_length(pages[|currentPage]));
				}

				// increment count and currentLine (add 2 to count for signal characters,
				// add imageLineCount to currentLine as well as one extra line to be sure
				// the text isn't touching the image.
				currentLine += linesNeeded + 1;
			}
		
		// if the text contains a space in the next position, find the next word in the text.
		// add a newLine if the nextWord doesn't fit. Then add the nextWord.
		if (string_char_at(text, 1) == " ") {
				if (string_char_at(text, 2) == "+") || (string_char_at(text, 2) == "|") || (string_char_at(text, 2) == "*") || (string_char_at(text, 2) == "%") {
					text = string_delete(text, 1, 1);	
				}	else {
					// add the first space to the substring
					var ll = string_length(pages[| currentPage]);
					
					if (newPage) {
						ll += 1;
						
						pages[|currentPage] = string_insert(" ", pages[| currentPage], ll);
						
						newPage = false;
					}
					
					pages[|currentPage] = string_insert(" ", pages[| currentPage], ll);
				
					// delete the first space
					text = string_delete(text, 1, 1);

					// get the nextWord by finding the next space
					var nextSpace = string_pos(" ", text);
					var nextWord = string_copy(text, 1, nextSpace -1);
					var wordLength = string_length(nextWord);
				
					// check if adding this word would make the currentPage too wide
					var substring = string_insert(nextWord, pages[| currentPage], string_length(pages[| currentPage]));
					var checkWidth = string_width(substring);
					if checkWidth > pageWidth {
						// add a newLine
						pages[| currentPage] = string_insert("\n", pages[|currentPage], string_length(pages[|currentPage]));
					
						// if next line isn't below the bottom of the page, add the nextWord
						if (currentLine + 1 <= maxLines) {
							// add the nextWord to the currentPage
							pages[| currentPage] = string_insert(nextWord, pages[|currentPage], string_length(pages[|currentPage]));
						
							currentLine++;
						}	else {
								// initialize next page
								pages[| currentPage + 1] = "";
								pages[| currentPage + 2] = "";
								
								// add the nextWord to the next page
								pages[| currentPage + 1] = nextWord;
								
								newPage = true;
								currentLine = 1;
								currentPage++;
						}
					}	else {
							// add the nextWord to the currentPage
							pages[| currentPage] = string_insert(nextWord, pages[|currentPage], string_length(pages[|currentPage]));								
					}	
					text = string_delete(text, 1, wordLength);
					substring = "";
				}				
			}
	}
}

///@desc This function is called when the player opens a scroll. The function builds
/// one long page of text that can be scrolled up and down
function scroll_build_text() {
	
}

///@desc This function is called when the player opens a document. The function builds
/// all of the text into a document format
function document_build_text() {
	
}

///@desc This function is called when a new location is being loaded. The function builds
/// all of the literature that is supposed to be in the room and places each piece in it's
/// respective position
function place_literature(_encodedList) {
	// get local vars
	var el = _encodedList;
	
	// decode list
	var list = ds_list_create();
	decode_list(el, list);

	// get list size
	var size = ds_list_size(list);
	
	// decode the literatureGrid to a temp grid
	var grid = ds_grid_create(literatureParams.height, literatureIDs.height);
	decode_grid(global.allLiterature, grid);
	
	// use a repeat loop to get the parameters of each token and then create it
	var i = 0; repeat (size) {
		// get id and coordinates from list
		var str = list[| i];
		var params = ds_list_create();
		decode_list(str, params);
		
		var _x = string_digits(params[|0]);
		var _y = string_digits(params[|1]);
		var ID = string_digits(params[|2]);
		
		var obj	= grid[# literatureParams.object,	ID];
		obj	= real(string_digits(obj));
		
		var z = scenery_get_depth(_y);
		
		var inst = instance_create_depth(_x, _y, z, literature);
		
		inst.x		= _x;
		inst.y		= _y;
		inst.ID		= ID;
		inst.obj	= obj;
		
		i++;
	}
}

///@desc This function is called when a player interacts with a piece of  literature. The function
/// gets the instance of the piece of literature and creates the proper object depending on the 
/// type of literature
function read_literature() {
	player.currentLiterature = instance_place(player.pointerX, player.pointerY, literature);
	var inst = player.currentLiterature;
	
	var lit = instance_create_depth(x, y, depth, inst.obj);
	lit.ID = inst.ID;
}