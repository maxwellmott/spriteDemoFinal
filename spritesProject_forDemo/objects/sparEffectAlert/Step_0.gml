/// @description Insert description here
// You can write your code in this editor

if (drawReady) {
	if (audio >= 0) {
		if !(audioPlayed) {
			audio_push_sfx(audio);	
			
			audioPlayed = true;
		}
	}
	// check if animation is finished
	if (spar.image_index >= spar.image_number - 1)	{
			instance_destroy(id);
	}
}