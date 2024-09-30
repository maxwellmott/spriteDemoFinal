/// @description Insert description here
// You can write your code in this editor

surface_set_target(game.guiSurface);

	// check that outro has not yet started
	if !(outroStarted) {
		// check that intro is not yet finished
		if !(introFinished) {
			draw_sprite(sprite_index, image_index, x, y);
			
			// check if opening animation has hit the first frame with the device fully visible
			if (image_index >= 4) {
				// draw the screen shine
				draw_sprite(spr_soulStoneScreenShine, 0, x, y);
			}
		}
		// if intro is finished
		else {
			draw_sprite(sprite_index, 8, x, y);
			
			// draw screen shine
			draw_sprite(spr_soulStoneScreenShine, 0, x, y);
		}
	}
	// if outro has started
	else {
		// draw closing animation
		draw_sprite(spr_soulStoneClose, image_index, x, y);
	}
surface_reset_target();