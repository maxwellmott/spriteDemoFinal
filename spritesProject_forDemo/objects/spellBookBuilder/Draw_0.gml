/// @description Insert description here
// You can write your code in this editor

draw_set(fa_center, fa_middle, 1.0, COL_BLACK);

// draw background
draw_sprite(spr_spellBookBuilderBackground, 0, 0, 0);

if (displayingSpellSelector) {
	// draw arrows
	if (currentSpellIndex > 0)				draw_sprite_ext(spr_spellSelectorArrow, leftArrowFrame,		leftArrowX,		arrowY, 1, 1, 0, c_white, 1.0);
	if (currentSpellIndex < spellCount - 1)	draw_sprite_ext(spr_spellSelectorArrow, rightArrowFrame,	rightArrowX,	arrowY, -1, 1, 0, c_white, 1.0);
	
	// draw square bar
	draw_sprite(spr_selectorSquareBar, 0, squareBarX, squareBarY);
	
	// draw spellInfo
	draw_sprite(spr_spellInfoBanner, 0, infoBannerX, infoBannerY);
	
	draw_text(infoBannerX, infoBannerY + 1.5, spellInfoString);
	
	// draw addSpellButton
	draw_sprite(spr_addSpellButton, addButtonFrame, addSpellButtonX, addSpellButtonY);
	
	// draw name slots
	draw_sprite(spr_spriteNameDisplay, 0, spriteNameSlotX, spriteNameSlotOneY);
	draw_sprite(spr_spriteNameDisplay, 0, spriteNameSlotX, spriteNameSlotTwoY);
	draw_sprite(spr_spriteNameDisplay, 0, spriteNameSlotX, spriteNameSlotThreeY);
	draw_sprite(spr_spriteNameDisplay, 0, spriteNameSlotX, spriteNameSlotFourY);
	
	// draw names and spellChecks
	var i = 0;	repeat (4)	{
		switch (i) {
			case 0:
				var ssy = spriteNameSlotOneY; 
			break;
			
			case 1:
				var ssy = spriteNameSlotTwoY;
			break;
			
			case 2:
				var ssy = spriteNameSlotThreeY;
			break;
			
			case 3:
				var ssy = spriteNameSlotFourY;
			break;
		}
		
		var sn = spriteNameList[| i];
		var sl = usableSpellsLists[| i];
		
		// draw name slot
		draw_sprite(spr_spriteNameDisplay, 0, spriteNameSlotX, ssy);
		
		// draw name
		draw_text(spriteNameSlotX, ssy, sn);
		
		// check if sprite can use current spell
		if (ds_list_find_index(sl, currentSpellID) >= 0) {
			// draw spell check
			draw_sprite(spr_usableSpellCheck, 0, usableSpellCheckX, ssy)
		}
		
		
		i++;
	}
	
	// draw spell name
	draw_sprite(spr_spellNameDisplay, 0, spellNameX, spellNameY);
	draw_text(spellNameX, spellNameY, currentSpellName);
}

if !(displayingSpellSelector) {
	// draw delete buttons
	draw_sprite(spr_removeSpellButton, deleteOneFrame,		deleteColumnOne, nameSlotRowOne);
	draw_sprite(spr_removeSpellButton, deleteTwoFrame,		deleteColumnTwo, nameSlotRowOne);
	
	draw_sprite(spr_removeSpellButton, deleteThreeFrame,	deleteColumnOne, nameSlotRowTwo);
	draw_sprite(spr_removeSpellButton, deleteFourFrame,		deleteColumnTwo, nameSlotRowTwo);
	
	draw_sprite(spr_removeSpellButton, deleteFiveFrame,		deleteColumnOne, nameSlotRowThree);
	draw_sprite(spr_removeSpellButton, deleteSixFrame,		deleteColumnTwo, nameSlotRowThree);
	
	draw_sprite(spr_removeSpellButton, deleteSevenFrame,	deleteColumnOne, nameSlotRowFour);
	draw_sprite(spr_removeSpellButton, deleteEightFrame,	deleteColumnTwo, nameSlotRowFour);
	
	// draw name slots
	draw_sprite(spr_displaySpellNameBanner, 0, nameSlotColumnOne, nameSlotRowOne);
	draw_sprite(spr_displaySpellNameBanner, 0, nameSlotColumnTwo, nameSlotRowOne);
	
	draw_sprite(spr_displaySpellNameBanner, 0, nameSlotColumnOne, nameSlotRowTwo);
	draw_sprite(spr_displaySpellNameBanner, 0, nameSlotColumnTwo, nameSlotRowTwo);
	
	draw_sprite(spr_displaySpellNameBanner, 0, nameSlotColumnOne, nameSlotRowThree);
	draw_sprite(spr_displaySpellNameBanner, 0, nameSlotColumnTwo, nameSlotRowThree);
	
	draw_sprite(spr_displaySpellNameBanner, 0, nameSlotColumnOne, nameSlotRowFour);
	draw_sprite(spr_displaySpellNameBanner, 0, nameSlotColumnTwo, nameSlotRowFour);
	
	// draw info slots
	draw_sprite(spr_displaySpellBanner, 0, infoSlotColumnOne, infoSlotRowOne);
	draw_sprite(spr_displaySpellBanner, 0, infoSlotColumnTwo, infoSlotRowOne);
	
	draw_sprite(spr_displaySpellBanner, 0, infoSlotColumnOne, infoSlotRowTwo);
	draw_sprite(spr_displaySpellBanner, 0, infoSlotColumnTwo, infoSlotRowTwo);

	draw_sprite(spr_displaySpellBanner, 0, infoSlotColumnOne, infoSlotRowThree);
	draw_sprite(spr_displaySpellBanner, 0, infoSlotColumnTwo, infoSlotRowThree);

	draw_sprite(spr_displaySpellBanner, 0, infoSlotColumnOne, infoSlotRowFour);
	draw_sprite(spr_displaySpellBanner, 0, infoSlotColumnTwo, infoSlotRowFour);	
	
	// draw names
	var i = 0;	repeat (SPELLMAX) {
		if (spellBookList[| i] >= 0) {
		
			var xx = 0;
			var yy = 0;
			var sn = "";
			
			switch (i) {
				case 0:	xx = nameSlotColumnOne;	yy = nameSlotRowOne;	break;
				case 1: xx = nameSlotColumnTwo; yy = nameSlotRowOne;	break;
				case 2: xx = nameSlotColumnOne; yy = nameSlotRowTwo;	break;
				case 3: xx = nameSlotColumnTwo; yy = nameSlotRowTwo;	break;
				case 4: xx = nameSlotColumnOne; yy = nameSlotRowThree;	break;
				case 5: xx = nameSlotColumnTwo; yy = nameSlotRowThree;	break;
				case 6: xx = nameSlotColumnOne; yy = nameSlotRowFour;	break;
				case 7: xx = nameSlotColumnTwo;	yy = nameSlotRowFour;	break;
			}
			
			sn = spellGrid[# SPELL_PARAMS.NAME, spellBookList[| i]];
			
			draw_text(xx, yy, sn);
			
			// draw spell info
				
		}
		
		i++;
	}
	
	// draw ditherBars
	draw_sprite(spr_displayDitherBar, 0, ditherBarX, ditherBarOneY);
	draw_sprite(spr_displayDitherBar, 0, ditherBarX, ditherBarTwoY);
	draw_sprite(spr_displayDitherBar, 0, ditherBarX, ditherBarThreeY);
	draw_sprite(spr_displayDitherBar, 0, ditherBarX, ditherBarFourY);
	draw_sprite(spr_displayDitherBar, 0, ditherBarX, ditherBarFiveY);
	
	// draw squareWalls
	draw_sprite(spr_displaySquareBar, 0, squareWallX, infoSlotRowOne);
	draw_sprite(spr_displaySquareBar, 0, squareWallX, infoSlotRowTwo);
	draw_sprite(spr_displaySquareBar, 0, squareWallX, infoSlotRowThree);
	draw_sprite(spr_displaySquareBar, 0, squareWallX, infoSlotRowFour);
}

if (onlineWaiting) {
	draw_set_alpha(0.5);
	
	draw_rectangle_color(0, 0, guiWidth, guiHeight, COL_BLACK, COL_BLACK, COL_BLACK, COL_BLACK, false);
	
	draw_set_alpha(1.0);
}