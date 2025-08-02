// check if currentSFX is not yet set
if (currentSFX == -1) {
	// check that the transitionManager is not present
	if !(instance_exists(transitionManager)) {
		// check if bgmGain is less than 1.0
		if (bgmGain < 1.0) {
			// increment bgmGain
			bgmGain += 0.0125
			audio_sound_gain(currentBGM, bgmGain, 0);
		}
	}
}

// check if there is a new sound effect
if (newSFX != -1) {
	// set bgmGain to 0
	bgmGain = 0.2;
	audio_sound_gain(currentBGM, bgmGain, 0);
	
	// set pitch mod val
	var pmv = 1;
	
	// set pitch range
	var pr = -1;
	
	// check if this is dialogue sfx
	if (instance_exists(talkBubble)) {
		// set pitch range
		pr = talkBubble.vocalRange;
	}
	
	// check if these are footsteps
	if (newSFX == sfx_footstep_woodenFloor) {
		pr = 0.2;
	}
	
	// check if range was set
	if (pr != -1) {
		// reset random seed
		randomize();
		
		// get random pitch mod val using pitch range
		var pmv = random_range(1 - (pr / 2), 1 + (pr / 2));
	}

	// start playing the given sfx
	currentSFX = audio_play_sound(newSFX, 1, 0, sfxGain, 0, pmv);

	
	// reset newSFX
	newSFX = -1;
}	

// check if currentSFX has been set
if (currentSFX != -1) {
	// check if the sound is no longer playing
	if !(audio_is_playing(currentSFX)) {
		// reset currentSFX
		currentSFX = -1;
	}
}

// loop background music
if (currentBGM != -1) {
	var l = audio_sound_length(currentBGM);
	var p = audio_sound_get_track_position(currentBGM);
	
	if (p > (l / 2)) {
		audio_sound_set_track_position(currentBGM, p - (l / 2));	
	}
}