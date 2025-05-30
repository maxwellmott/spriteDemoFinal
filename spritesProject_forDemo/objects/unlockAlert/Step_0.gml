// reset y in case camera.y or num changes
y = camera.y - (guiHeight / 2) + (40 + (40 * num));

// reset x in case camera.x changes
x = camera.x - (guiWidth / 2) + 12;

// reset type in case num changes
type = player.unlockAlertList[| num];

// check if this alert is fading out
if (fadingOut) {
	// check if alpha is greater than 0
	if (alpha > 0.0) {
		alpha -= 0.025;
	}
	// if alpha is equal to or less than 0
	else {
		// destroy this instance
		instance_destroy(id);
	}
}