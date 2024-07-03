#region PLAYER BAR SURFACES

	var barWidth	= sprite_get_width(spr_sparBar) - 2;
	var barHeight	= sprite_get_height(spr_sparBar) - 2;
	
	surface_set_target(playerBarSurface);
		var playerHealthRatio	= playerDisplayHP / MAX_HP;
		var playerMagicRatio	= playerDisplayMP / MAX_MP;
		
		draw_sprite(spr_sparBar, 0, hpBarX - 1, hpBarY - 1);
		draw_sprite(spr_sparBar, 0, mpBarX - 1, mpBarY - 1);
		
		draw_sprite_stretched(spr_sparHealthSliver, 0, hpBarX,	hpBarY,	barWidth * playerHealthRatio,	barHeight);
		draw_sprite_stretched(spr_sparMagicSliver,	0, mpBarX,	mpBarY,	barWidth * playerMagicRatio,	barHeight);
		
		if (totalSelectionCost > 0)
		|| (potentialCost > 0) {
			var costRatio = (totalSelectionCost + potentialCost) / MAX_MP;
			if (costRatio > player.currentMP)	costRatio = player.currentMP;
			
			var fBarSize	= barWidth * costRatio;
			var fBarX		= mpBarX + (barWidth - fBarSize);

			var mpBuffer	= barWidth - (barWidth * playerMagicRatio);
			
			draw_sprite_stretched(spr_sparFlashingSliver, image_index, fBarX - mpBuffer, mpBarY, fBarSize, barHeight);
		}
	
	surface_reset_target();
	
	surface_set_target(enemyBarSurface);
		var enemyHealthRatio	= enemyDisplayHP / MAX_HP;
		var enemyMagicRatio		= enemyDisplayMP / MAX_MP;
	 
		draw_sprite(spr_sparBar, 0, hpBarX - 1, hpBarY - 1);
		draw_sprite(spr_sparBar, 0, mpBarX - 1, mpBarY - 1);
			
		draw_sprite_stretched(spr_sparHealthSliver, 0, hpBarX,	hpBarY,	barWidth * enemyHealthRatio,	barHeight);
		draw_sprite_stretched(spr_sparMagicSliver,	0, mpBarX,	mpBarY,	barWidth * enemyMagicRatio,		barHeight);
		
	surface_reset_target();

#endregion

#region SPELL SHADE SURFACES

if (instance_exists(sparActionProcessor)) {
		// check if the acton processor is in the fading in phase
		if (sparActionProcessor.state >= ACTION_PROCESSOR_STATES.FADING_IN) {
			
			// set surface
			surface_set_target(spellShadeSurface);
			

			// draw shade
			draw_rectangle_color(0, 0, guiWidth, guiHeight, COL_BLACK, COL_BLACK, COL_BLACK, COL_BLACK, false);
			
			// set blendmode to subtractive for holepunching
			gpu_set_blendmode(bm_subtract);
			
			// draw holepunches for activeSprite and targetSprite
			draw_sprite(activeSpriteCutout, 0, sparActionProcessor.activeSprite.x, sparActionProcessor.activeSprite.y);
			
			if (sparActionProcessor.activeSprite != sparActionProcessor.targetSprite) {
				draw_sprite(activeSpriteCutout, 0, sparActionProcessor.targetSprite.x, sparActionProcessor.targetSprite.y);
			}

			// set blendmode back to normal
			gpu_set_blendmode(bm_normal);	
			
			// reset surface
			surface_reset_target();
		}
}
#endregion