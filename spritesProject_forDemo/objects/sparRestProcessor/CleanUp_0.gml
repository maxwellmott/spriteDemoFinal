spar.turnMsg = "";

ds_list_destroy(restList);

// perform an ability check for sprite resting
ability_check(ABILITY_TYPES.SPRITE_RESTING);

with (sparAlly) {
	if resting {
		sprite_reload_sprite();
		resting = false;
	}
}

with (sparEnemy) {
	if resting {
		sprite_reload_sprite();
		resting = false;
	}
}