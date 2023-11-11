/// @description Insert description here
// You can write your code in this editor

if !(bookBuilt) && (ID >= 0) {	
	literature_get_params();
	font = plainFont;
	draw_set_font(font);
	book_build_text(text);
	leftPageNum		= pageIndex * 2;
	rightPageNum	= (pageIndex * 2) + 1;
	
	leftPageText	= pages[|leftPageNum];
	rightPageText	= pages[|rightPageNum];
	bookBuilt = true;
}

if !(turningPage) {	
	if (global.menu_right) {
		pageIndex++;
		turningPageRight = true;	
		flipFrame = 0;
		turningPage = true;
	}
	
	if (global.menu_left) {
		pageIndex--;
		turningPageLeft = true;
		flipFrame = 3;
		turningPage = true;
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