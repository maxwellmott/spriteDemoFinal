// check if the bgm is still on
if !(audio_is_paused(audioManager.currentBGM)) {
	// check that the bgm has NOT been faded out completely
	if (audio_sound_get_gain(audioManager.currentBGM) != 0.0) {
		// if not, fade the audio out
		audio_sound_gain(audioManager.currentBGM, 0.0, 50);
	}
	// if the bgm HAS been faded out completely
	else {
		// turn off the bgm
		audio_pause_sound(audioManager.currentBGM);
	}
}

// check if intro is finished AND outro has started
if (introFinished)
&& (outroStarted) {
	// check if image index is on the final frame
	if (image_index >= image_number - 1) {
		// destroy this instance
		instance_destroy(id);
	}
}

// check if intro is finished AND outro has NOT started
if (introFinished)
&& !(outroStarted) {
	// increment trackerLineFrame
	if !(global.gameTime mod 8) {
		trackerLineFrame++;
		
		if (trackerLineFrame >= trackerLineFrameCount) {
			trackerLineFrame -= trackerLineFrameCount;	
		}
	}
	
	// set image index to the final frame (display the actual menu)
	image_index = image_number - 1;
	
		// check if back button is being pressed
	if (global.back) {
		// set image index to 0 to start outro animation
		image_index = 0;
		
		// set outro started to true
		outroStarted = true;	
	}
	
	// check if player is using keyboard and mouse
	if (global.controllerType == controllerTypes.keyboard) {
		// check if the space bar is currently being held down
		if (global.click) 
		|| (global.select) 
		|| (mouse_check_button(mb_right)) {
			if !(playing) {
				// set playing to true
				playing = true;	
				
				// set filter phase to attack
				filterPhase = FILTER_PHASES.ATTACK;
			}
		}
	}
	

	wavephone_set_notenum();
	
	// set currentTone
	currentTone = wavephone_get_note_frequency(noteNum);
	
	// 
	pitchVal = (currentTone / CENTRAL_TONE);		

	
	if (playing) {
		// use a state machine to control the filter
		switch (filterPhase) {
			case FILTER_PHASES.ATTACK:
				if (sound == -1) {
					audio = audio_create_buffer_sound(audioBuffer, buffer_s16, AUDIO_SAMPLE_RATE, 0, bufferLength, audio_stereo);
					sound = audio_play_sound(audio, 0, 0, gain, 0, pitchVal);
					
					audio_sound_loop(sound, false);
				}
				// if audio HAS been set
				else {
				
					// check if gain has NOT yet hit target gain
					if (gain < targetGain_attack) {
						// move gain toward target gain
						gain += attackRate_gain;
					}
					// if gain HAS hit target gain
					else {
						filterPhase = FILTER_PHASES.DECAY;
					}
				}
			break;
			
			case FILTER_PHASES.DECAY:
				// check if gain has NOT yet hit target gain
				if (gain > targetGain_sustain) {
					// move gain toward target gain
					gain -= decayRate_gain;
				}
				// if gain HAS hit target gain
				else {
					filterPhase = FILTER_PHASES.SUSTAIN;	
				}
			break;
			
			case FILTER_PHASES.SUSTAIN:
				audio_sound_gain(sound, gain, 0);
			break;
			
			case FILTER_PHASES.RELEASE:
				// check that gain has NOT yet hit 0
				if (gain > 0.0) {
					// move gain toward 0
					gain -= releaseRate_gain;
				}
			break;
		}
		
		// check that we are not in the SUSTAIN phase
		if (filterPhase != FILTER_PHASES.SUSTAIN) {
			// correct gain
			audio_sound_gain(sound, gain, 1);
		}
			
		// check if filter phase is set to RELEASE
		if (filterPhase == FILTER_PHASES.RELEASE) {	
			// check if gain is 0
			if (gain <= 0.0) {
				audio_stop_sound(sound);
				audio = -1;
				sound = -1;
				playing = false;
			}
		}
	}
}

if (sound != -1) {
	if !(audio_is_playing(sound)) {
		playing = false;
		sound = -1;
	}
}

// check if intro is not finished
if !(introFinished) {
	// check if image index is on the final frame
	if (image_index >= image_number - 1) {
		// set intro finished to true
		introFinished = true;	
	}
}