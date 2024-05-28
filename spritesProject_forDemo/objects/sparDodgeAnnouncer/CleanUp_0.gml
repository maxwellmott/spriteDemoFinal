spar.turnMsg = "";

ds_list_destroy(dodgeList);

with (sparAlly) {
	if dodging {
		sprite_reload_sprite();
	}
}

with (sparEnemy) {
	if dodging {
		sprite_reload_sprite();
	}
}

spar.processPhase = PROCESS_PHASES.PRIORITY;