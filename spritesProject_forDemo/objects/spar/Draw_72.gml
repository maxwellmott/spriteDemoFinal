if !(surface_exists(playerBarSurface))		playerBarSurface = surface_create(48, 16);
if !(surface_exists(enemyBarSurface))		enemyBarSurface = surface_create(48, 16);

#region PLAYER BAR SURFACES

	var barWidth	= sprite_get_width(spr_sparBar) - 2;
	var barHeight	= sprite_get_height(spr_sparBar) - 2;
	
	surface_set_target(playerBarSurface);
		var playerHealthRatio	= playerDisplayHP / MAX_HP;
		var playerMagicRatio	= playerDisplayMP / MAX_MP;
		
		draw_sprite(spr_sparBar, 0, hpBarX - 1, hpBarY - 1);
		draw_sprite(spr_sparBar, 0, mpBarX - 1, mpBarY - 1);
		
		var hpScale = barWidth * playerHealthRatio;
		var mpScale = barWidth * playerMagicRatio;
		
		if (hpScale < 1)
		&& (hpScale > 0) {
			hpScale = 1;
		}
		
		if (mpScale < 1) 
		&& (hpScale > 0) {
			mpScale = 1;
		}
		
		draw_sprite_stretched(spr_sparHealthSliver, 0, hpBarX,	hpBarY,	hpScale,	barHeight);
		draw_sprite_stretched(spr_sparMagicSliver,	0, mpBarX,	mpBarY,	mpScale,	barHeight);
		
		if (totalSelectionCost > 0)
		|| ((totalSelectionCost + potentialCost) > 0) {
			var costRatio = ((totalSelectionCost + potentialCost) - global.mpCostDiff) / MAX_MP;
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
		
		hpScale = barWidth * enemyHealthRatio;
		mpScale = barWidth * enemyMagicRatio;
		
		if (hpScale < 1)
		&& (hpScale > 0) {
			hpScale = 1;
		}
		
		if (mpScale < 1) 
		&& (hpScale > 0) {
			mpScale = 1;
		}
			
		draw_sprite_stretched(spr_sparHealthSliver, 0, hpBarX,	hpBarY,	hpScale,	barHeight);
		draw_sprite_stretched(spr_sparMagicSliver,	0, mpBarX,	mpBarY,	mpScale,	barHeight);
		
	surface_reset_target();

#endregion