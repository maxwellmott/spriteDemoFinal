player.state = humanStates.standard;

ds_list_destroy(leftList);
ds_list_destroy(rightList);
ds_list_destroy(topList);
ds_list_destroy(bottomList);
ds_list_destroy(accidentals);

if (sound != -1) {
	audio_stop_sound(sound);
}

if !(instance_exists(transitionManager)) {
	with (audioManager) {
		audio_resume_sound(currentBGM);	

		audio_sound_gain(currentBGM, 1.0, 1000);
	}
}

destroy_if_possible(mouse);