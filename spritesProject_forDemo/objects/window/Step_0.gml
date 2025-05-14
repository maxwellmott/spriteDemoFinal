if (player.hours < 10)
&& (frame == 0) {
	frame = 1;
}
else if (player.hours > 20)
&& (frame == 0) {
	frame = 1;	
}
else {
	if (frame == 1) {
		frame = 0;	
	}
}