/// @description Insert description here
// You can write your code in this editor

if !(bookBuilt) && (ID >= 0) {	
	literature_get_params();
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
		turningPage = true;	
	}
	
	if (global.menu_left) {
		pageIndex--;
		turningPage = true;
	}
}

if (turningPage) {
	leftPageNum		= pageIndex * 2;
	rightPageNum	= (pageIndex * 2) + 1;
	
	leftPageText	= pages[|leftPageNum];
	rightPageText	= pages[|rightPageNum];
	alarm[0] = 24;
}