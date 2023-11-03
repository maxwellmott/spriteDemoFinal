/// @desc

if (global.controllerType == controllerTypes.gamepad) {
	x += gamepad_axis_value(0, gp_axisrh);
	y += gamepad_axis_value(0, gp_axislh);
}

if (global.controllerType == controllerTypes.keyboard) {
	x = mouse_x;
	y = mouse_y;
}

if (idle) {
	if (alpha > 0.0) {
		alpha -= fadeRate;
	}
}
else {
	if (alpha < 1.0) {
		alpha += fadeRate;
	}
}

if ((alarm[0] == -1) and (x == xPrev) and (y == yPrev)) {
	alarm[0] = 60;	
}

if ((alarm[1] == -1) and (global.click > 0)) {
	frame = 1;
	alarm[1] = 15;	
}

x = round(x);
y = round(y);