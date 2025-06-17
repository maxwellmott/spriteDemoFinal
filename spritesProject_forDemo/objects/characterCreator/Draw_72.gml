if !(surface_exists(playerAppearanceSurface)) {
	playerAppearanceSurface = surface_create(24, 42);	
}

// clear playerAppearanceSurface
surface_set_target(playerAppearanceSurface);

	draw_clear_alpha(c_black, 0);
	
	character_creator_draw_player(eyewear, skintone, outfit, outfitColor, hairstyle, hairColor, hat, hatColor, shoes, shoeColor, accessory);

// reset surface target
surface_reset_target();