if (restBegin) 
&& !(animationStarted) {
	// replenish mp for each sprite using a repeat loop
	var i = 0;	repeat (ds_list_size(restList)) {
		var inst = restList[| i];
		
		//set the sprite's swapping var to true
		inst.resting = true;
		
		// process the sprite's rest
		sprite_process_rest(inst);
		
		i++;
	}
	
	// start the animation
	animationStarted = true;
	
	// set spar sprite built-ins
	spar.image_index = 0;
}

// check if it's time to stop the animation
if (animationStarted) {
	 if (spar.image_index >= restFrameCount) {
		animationStopped = true;	 
	 }
 
	if (animationStopped)	instance_destroy(id);
}