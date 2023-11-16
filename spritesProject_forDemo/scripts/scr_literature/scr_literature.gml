enum literatureIDs {
	inhumanEntities,
	twmFirstEdition,
	twmSecondEdition,
	twmThirdEdition,
	sparmastersHandbook,
	illuminiad,							//high level magic book
	sacriLibriI,						//the standard book for learning magic
	sacriLibriII,
	sacriLibriIII,
	sacriLibriIV,
	sacriLibriV,
	epicOfTheAeons,						//genesis
	phremnsBirth,
	astralDoctrine,						//bible
	threeWitchesGrimoireVol1,
	threeWitchesGrimoireVol2,
	threeWitchesGrimoireVol3,
	cosmicTreatise,
	knightsOfAlcompasVol1,
	knightsOfAlcompasVol2,
	knightsOfAlcompasVol3,
	aBookOnSprites1,
	aBookOnSprites2,
	aBookOnSprites3,
	height
}

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

enum bookcaseTypes {
	standardWood1,
	height
}

enum bookcaseParams {
	ID,
	type,
	facing,
	_x,
	_y,
	bookList,
	height
}

var textGrid = load_csv("LITERATURE_ENGLISH.csv");

var inhumanEntitiesImages = ds_list_create();

ds_list_add(inhumanEntitiesImages, string(spr_inhumanEntities1)+",");

var encodedImageList = encode_list(inhumanEntitiesImages);

global.literatureGrid = ds_grid_create(literatureParams.height, literatureIDs.height);

function master_grid_add_literature(_ID) {
	var i = 0; repeat (literatureParams.height) {
		global.literatureGrid[# i, _ID] = argument[i];
		
		i++;
	}
}

master_grid_add_literature(literatureIDs.inhumanEntities, "Inhuman Entities", "Gregoria Von Verstolen", guiBook, colors.brown, textGrid[# 1, literatureIDs.inhumanEntities], cursiveFont, encode_list(inhumanEntitiesImages));

global.allLiterature = encode_grid(global.literatureGrid);

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

function book_build_text(_string) {
	var text = _string;
	
	var last_space = 1;
	
	var currentLine = 1;
	var currentPage = 1;
	
	var height = string_height(text);
	var maxLines = (pageHeight div height) - 1;
	
	pages[| currentPage] = "";

	while (string_length(text) > 0) {
		while (currentLine < maxLines) {			
			// if the text signals to start a new line, add the substring to the current page,
			// then add the newLine to the substring and increment the currentLine
			var char = string_char_at(text, 1);
			if (char == "+") {				
				// delete the signal character
				text = string_delete(text, 1, 1);
				
				// add the new line to the current page
				pages[|currentPage] = string_insert("\n", pages[|currentPage], string_length(pages[|currentPage]));
				
				// increment currentline
				currentLine++;
			}
		
			// if the text signals to start a new page, add the substring to the current page,
			// then increment the count and the page
			var char = string_char_at(text, 1);
			if (char == "|") {
				// delete the signal character
				text = string_delete(text, 1, 1);
				 
				// increment currentPage and reset currentLine
				currentPage++;
				pages[|currentPage] = "";
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
				if !(currentPage mod 2) var headingX = rightPageX + (pageWidth / 2);
					else var headingX = leftPageX + (pageWidth / 2);
					
				var newGridY = headingCount + 1;
				ds_grid_resize(headingGrid, 4, newGridY);	
					
				// add all heading parameters to headingGrid
				headingGrid[# 0, headingCount] = headingString;
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
				
				var linesNeeded = (imageHeight div height) + 1;
				
				if (currentLine + linesNeeded + 2) > maxLines {
					currentPage++;
					pages[|currentPage] = "";
					currentLine = 1;
				}
				
				// delete the signal encoded in the text
				text = string_delete(text, 1, imageLength + 2);
				
				// get the x and y at which to draw the image
				var imageY = (height * (currentLine)) + textY;
				if !(currentPage mod 2) var imageX = leftPageX + (pageWidth / 4);
					else var imageX = rightPageX + (pageWidth / 4);
					
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
	// FIRST BUG OCCURS HERE FIRST BUG OCCURS HERE FIRST BUG OCCURS HERE FIRST BUG OCCURS HERE FIRST BUG OCCURS HERE FIRST BUG OCCURS HERE FIRST BUG OCCURS HERE	
	// FIRST BUG OCCURS HERE FIRST BUG OCCURS HERE FIRST BUG OCCURS HERE FIRST BUG OCCURS HERE FIRST BUG OCCURS HERE FIRST BUG OCCURS HERE FIRST BUG OCCURS HERE				
					// add the first space to the substring
					pages[|currentPage] = string_insert(" ", pages[| currentPage], string_length(pages[| currentPage]));
				
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
								
								// add the nextWord to the next page
								pages[| currentPage + 1] = string_insert(nextWord, pages[|currentPage + 1], 1);
								
								length -= wordLength + 1;
								currentLine = 1;
								currentPage++;
						}
					}	else {
							// add the nextWord to the currentPage
							pages[| currentPage] = string_insert(nextWord, pages[|currentPage], string_length(pages[|currentPage]));								
					}	
					text = string_delete(text, 1, wordLength);	
				}				
			}
				
			if (string_length(text) == 0) currentLine = maxLines;
		}
		
		// if the currentLine has moved beyond maxLines, move to the next page and start from line 1	
		currentPage++;
		pages[|currentPage] = "";
		currentLine = 1;
	}
}

function scroll_build_text() {
	
}

function document_build_text() {
	
}

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
		
		var _x = real(params[|0]);
		var _y = real(params[|1]);
		var ID = real(params[|2]);
		
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

function read_literature() {
	player.currentLiterature = instance_place(player.pointerX, player.pointerY, literature);
	var inst = player.currentLiterature;
	
	var lit = instance_create_depth(x, y, depth, inst.obj);
	lit.ID = inst.ID;
}