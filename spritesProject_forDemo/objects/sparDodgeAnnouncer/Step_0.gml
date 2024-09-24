// if player presses the button or key for selecting, display dodge animation instead of sprites
 if animationStarted {
	 if (spar.image_index >= dodgeFrameCount) {
		animationStopped = true;	 
	 }
}
 
if (dodgeBegin) 
&& !(animationStarted) {
	var i = 0; repeat (ds_list_size(dodgeList)) {
		// change sprite to dodge animation
		dodgeList[| i].sprite = spr_sparDodge;
		
		
		// increment i
		i++;
	}
	
	animationStarted = true;
	spar.image_index = 0;
 }
 
if (animationStopped)	instance_destroy(id);