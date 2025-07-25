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

// check if any emitters have been added to the emitterQueue
if (ds_list_size(global.emitterQueue) > 0) {	
	// load the paramList stored on the queue
	var pl = ds_list_create();
	decode_list(global.emitterQueue[| 0], pl);
	
	// get parameters from paramList
	var senderID		= pl[| EMITTER_PARAMS.SENDER_ID];
	var emitterX		= pl[| EMITTER_PARAMS.X];
	var emitterY		= pl[| EMITTER_PARAMS.Y];
	var emitterSongID	= pl[| EMITTER_PARAMS.SONG_ID];
	
	// create an emitter
	var emitter = audio_emitter_create();
	
	// set all params for the new emitter
	audio_emitter_position(emitter, emitterX, emitterY, 0);
	audio_emitter_falloff(emitter, 150, 150, 1)
	
	// add that emitter to currentEmitters
	ds_list_add(currentEmitters, emitter);
	
	// set emitterActive and emitterNum for the sender
	senderID.emitterActive = true;
	senderID.emitterNum = ds_list_size(currentEmitters) - 1;
	
	// remove it from the emitterQueue
	ds_list_delete(global.emitterQueue, 0);
}

// loop background music
if (currentBGM != -1) {
	var l = audio_sound_length(currentBGM);
	var p = audio_sound_get_track_position(currentBGM);
	
	if (p > (l / 2)) {
		audio_sound_set_track_position(currentBGM, p - (l / 2));	
	}
}

// check if there are any emitters currently
if (ds_list_size(currentEmitters) > 0) {	
	// use a repeat loop to check the state of all emitters
	var i = 0;	repeat (ds_list_size(currentEmitters)) {
		// get the current emitter
		var e = currentEmitters[| i];
		
		// get the length and position
		var l = audio_sound_length(e);
		var p = audio_sound_get_track_position(e);
		
		// check if the first loop has been completed
		if (p > (l / 2)) {
			// subtract the length of one loop (two loops per sound file)
			audio_sound_set_track_position(e, p - (l / 2));	
		}
		
		i++;
	}
}