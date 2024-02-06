spar.turnMsg = "";

ds_list_destroy(restList);

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

spar.processPhase = PROCESS_PHASES.DODGE;