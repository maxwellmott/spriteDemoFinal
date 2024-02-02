// replenish mp for each sprite using a repeat loop

var i = 0;	repeat (ds_list_size(restList)) {
	var inst = restList[| i];
	
	sprite_process_rest(inst);
	
	i++;
}


 if (spar.image_index == restFrameCount) {
	animationStopped = true;	 
 }
 
if (spar_check_hpmp()) && (animationStopped)	instance_destroy(id);