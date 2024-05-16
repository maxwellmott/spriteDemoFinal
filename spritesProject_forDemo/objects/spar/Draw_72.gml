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
		draw_sprite_stretched(spr_sparFlashingSliver, image_index, mpBarX, mpBarY, barWidth * costRatio, barHeight);	
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