/// @desc	DEBUG CODE

surface_set_target(guiSurface);

	var drawX = 32;
	var drawY = guiHeight / 2;
	
	draw_text_pixel_perfect(drawX, drawY, string(player.x) + "," + string(player.y), 7, 256);

	if debugDraw {
		var drawX = 16
		var drawY = guiHeight / 2;
	
		var column	= (player.x div TILEWIDTH) + 1;
		var row		= (player.y div TILEHEIGHT) + 1;
	
		draw_set_font(overworldFont);
		draw_text(drawX, drawY, string(column) + "," + string(row));
		
		draw_text(drawX, drawY + 32, string(overworld.locationName));
	}

surface_reset_target();