spar.turnMsg = "";

ds_list_destroy(dodgeList);

with (sparAlly) {
	if dodging {
		sprite_reload_sprite();
		dodging = false;
	}
}

with (sparEnemy) {
	if dodging {
		sprite_reload_sprite();
		dodging = false;
	}
}

spar.processPhase = PROCESS_PHASES.PRIORITY;