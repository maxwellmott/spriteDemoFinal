/// @description Insert description here
// You can write your code in this editor

if !(bookBuilt) && (ID >= 0) {	
	literature_get_params();
	font = spellbookFont;
	draw_set_font(font);
	book_build_text(text);
	leftPageNum		= pageIndex * 2;
	rightPageNum	= (pageIndex * 2) + 1;
	
	leftPageText	= pages[|leftPageNum];
	rightPageText	= pages[|rightPageNum];
	image_index = 0;
	bookBuilt = true;
}

if !(introFinished) 
&& (image_index >= 3) {
	introFinished = true;	
}

if (introFinished)
&& !(outroStarted) {
	if !(turningPage) {	
		if (pageIndex < (ds_list_size(pages) div 2) -1) {
			if (global.menuRight) {
				audio_push_sfx(sfx_bookNextPage);
				pageIndex++;
				turningPageRight = true;	
				flipFrame = 0;
				turningPage = true;
			}
		}
		
		if (pageIndex > 0) {
			if (global.menuLeft) {
				audio_push_sfx(sfx_bookLastPage);
				pageIndex--;
				turningPageLeft = true;
				flipFrame = 3;
				turningPage = true;
			}
		}	
	}
	
	if (turningPage) && !(pageTurned) {
		leftPageNum		= pageIndex * 2;
		rightPageNum	= (pageIndex * 2) + 1;
		
		leftPageText	= pages[|leftPageNum];
		rightPageText	= pages[|rightPageNum];
		
		pageTurned = true;
	
	}
	
	if (turningPageLeft) {
		if (flipFrame <= 0) {
			pageTurned = false;
			turningPage = false;
			turningPageLeft = false;
		}
	
		if (flipFrame > 0) && !(global.gameTime mod 6) {
			flipFrame--;
		}
	}
	
	if (turningPageRight) {
		if (flipFrame >= 3) {
			pageTurned = false;
			turningPage = false;
			turningPageRight = false;
		}
	
		if (flipFrame < 3) && !(global.gameTime mod 6) {
			flipFrame++;
		}
	}
	
	if (global.back) {
		image_index = 0;
		outroStarted = true;
		audio_push_sfx(sfx_bookClose);
	}
}

if (outroStarted) 
&& (image_index >= 3) {
	player.currentLiterature = -4;
	instance_destroy(id);
}