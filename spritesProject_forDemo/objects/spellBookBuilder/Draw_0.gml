// draw spellbookbuilder background
draw_sprite(spr_spellBookBuilderBackground, 0, 0, 0);

// set color to black
draw_set_color(COL_BLACK);

// draw category incidator
if !(categoryChanging) {
	draw_text_pixel_perfect(36, 27, categoryString, 10, 256);
}
else	{
	draw_sprite(spr_spellBookCategoryFlash, 0, categoryFlashX, categoryFlashY);
}

// draw currently selected spells
var i = 0;	repeat (ds_list_size(spellBookList)) {
	// get x and y for nameslot
	var sx = nameSlotLefts[| i];
	var sy = nameSlotTops[| i];
	
	// get x and y for text
	var tx = round(sx + (nameSlotWidth / 2));
	var ty = round(sy + (nameSlotHeight / 2) + 2);
	
	// check if selectedSpellSlot is i
	if (i == selectedSpellSlot)
	&& (displaySpell < 0) {
		// draw the name slot
		draw_sprite(spr_spellBookNameSlot, 1, sx, sy);
		
		if !(global.gameTime mod 32 < 16) {
			// indicate that it is time to select
			draw_text_pixel_perfect(tx, ty, "Press Space to Select the Above Spell", 10, nameSlotWidth - 4);
		}
	}
	// if selectedSpell is not i
	else {
		// draw the name slot
		draw_sprite(spr_spellBookNameSlot, 0, sx, sy);
		
		// draw the name
		draw_text_pixel_perfect(tx, ty, spellGrid[# SPELL_PARAMS.NAME, spellBookList[| i]], 10, nameSlotWidth - 4);
	}
	
	// increment i
	i++;
}

// draw compatible ally names
var i = 0;	repeat (4) {
	// check if the current spell is on this sprite's usableSpells list
	if (ds_list_find_index(usableSpellsLists[| i], currentSpell) != -1) {
		// get nameSlotWidth
		var w = 60;
		
		// set x and y
		var nx = ((w / 2) + 1) + (i * ((guiWidth -2) / 4));
		var ny = 215;
		
		// set draw params
		draw_set(fa_center, fa_middle, 1.0, COL_BLACK);
		
		// draw this sprite's name
		draw_text_pixel_perfect(nx, ny, spriteNameList[| i], 8, ((guiWidth - 2) / 4));
	}
	
	// increment i
	i++;
}

// set shadeAlpha
draw_set_alpha(shadeAlpha);

// draw shade rectangle
draw_rectangle_color(0, 0, guiWidth, guiHeight, c_black, c_black, c_black, c_black, false);

// reset alpha
draw_set_alpha(1.0);

// draw spellBook
draw_sprite(spellBookSprite, spellBookFrame, spellBookX, spellBookY);

// if the book is open and the page isn't being flipped, draw the current spell icon and all spell params
if !(drawFlip) && (spellBookFrame == 5) {
	draw_set_font(spellbookFont);
	
	if (displaySpell < 0) {
		draw_sprite(spr_spellBookIconSheet, currentSpell, spellBookX, spellBookY + 4);
	}
	else {
		draw_sprite(spr_spellBookIconSheet, displaySpell, spellBookX, spellBookY + 4);
	}
	
	draw_sprite(spr_spellRangeIndicator, spellRange, rangeDrawX, rangeDrawY);
	draw_sprite(spr_spellTypeIndicator, spellType, typeDrawX, typeDrawY);
	
	// check if power is greater than 0
	if (spellPower > 0) {
		draw_text_pixel_perfect(powerDrawX, powerDrawY, string(spellPower), 1, 256);
	}	else	{
		draw_text_pixel_perfect(powerDrawX, powerDrawY + 1, "--", 1, 256);	
	}
	
	// check if cost is greater than 0
	if (spellCost > 0) {
		draw_text_pixel_perfect(costDrawX, costDrawY, string(spellCost), 1, 256);
	}	else	{
		draw_text_pixel_perfect(costDrawX, costDrawY + 1, "--", 1, 256);	
	}
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	draw_text_pixel_perfect(descDrawX, descDrawY, description, 8, infoBannerWidth);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
}

// check if pageFlip is happening
if (drawFlip) {
	draw_sprite(spr_spellBookPageFlip, flipFrame, spellBookX, spellBookY);
}


