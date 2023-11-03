/// @desc

// set the viewport for each room
view_enabled[0] = true;
view_visible[0] = true;
view_camera[0] = cam;

// set follow as player in the overworld
var ow = global.overworld;
if (ow) and (instance_exists(player)) {
	follow = player;	
}

// increment or decrement x and y

if (follow >= 0) {
	x = follow.x;
	y = follow.y;
}

if (follow < 0) {
	x = 128;
	y = 112;
}

// clamp the x and y
var xMin = 128;
var yMin = 112;

var xMax = 800 - xMin;
var yMax = 800 - yMin;

x = clamp(x, xMin, xMax);
y = clamp(y, yMin, yMax);

// reset the view matrix
var vm = matrix_build_lookat(x, y, -10, x, y, 0, 0, 1, 0);

camera_set_view_mat(cam, vm);