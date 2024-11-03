var i = 0;	repeat (responseCount) {
	var frame	= 0;
	var col		= COL_BLACK;
	
	if (selectedResponse == i) {
		frame = 1;	
		col = COL_WHITE;
	}
	
	var left	= leftList[| i];
	var right	= rightList[| i];
	var top		= topList[| i];
	var bottom	= bottomList[| i];
	
	draw_sprite(buttonSprite, frame, left, top);
	
	draw_set(fa_left, fa_top, 1.0, col);
	
	draw_text_pixel_perfect(left + 2, top, responseList[| i], 9, buttonWidth - 4);
	
	i++;
}

draw_set(fa_center, fa_middle, 1.0, COL_BLACK);

draw_sprite(questionDisplaySprite, 0, questionDisplayX, questionDisplayY);

draw_text_pixel_perfect(questionX, questionY, question, 9, questionDisplayWidth - 4);