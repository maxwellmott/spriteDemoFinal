
switch (splashScreenState) {
	
	case splashScreenStates.fadingIn:
	
		if (alpha > 0.0) alpha -= 0.01;
		else splashScreenState = splashScreenStates.pausing;
		
	break;
	
	case splashScreenStates.pausing:
		
		if (timer < 240) timer++;
		else splashScreenState = splashScreenStates.fadingOut;
		
	break;
	
	case splashScreenStates.fadingOut:
		
		if (alpha < 1.0) alpha += 0.01;
		else splashScreenState = splashScreenStates.height;
		
	break;
	
	case splashScreenStates.height:
		
		instance_destroy(id);
		
	break;
}