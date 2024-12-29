// check if spell failed
if !(instance_exists(sparActionProcessor)) 
|| (sparActionProcessor.spellFailed) {
	instance_destroy(id);	
}

// if animation finishes,							destroy object						set flash rate inside sparActionProcessor
if (spar.image_index >= spar.image_number - 2)		instance_destroy(id);				with (sparActionProcessor)	flash_rate_set_from_damage();