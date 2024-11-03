
var i = 0;	repeat (responseCount) {
	var left	= leftList[| i];
	var right	= rightList[| i];
	var top		= topList[| i];
	var bottom	= bottomList[| i];
	
	if (collision_rectangle(left, top, right, bottom, mouse, true, false)) {
		selectedResponse = i;	
	
		if (global.click) {
			instance_destroy(id);	
		}
	}
	
	i++;	
}