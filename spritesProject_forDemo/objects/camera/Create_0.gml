/// @desc

cam = camera_create();

var vm = matrix_build_lookat(x, y, -10, x, y, 0, 0, 1, 0);
var pm = matrix_build_projection_ortho(camWidth, camHeight, 1, 10000);

camera_set_view_mat(cam, vm);
camera_set_proj_mat(cam, pm);

follow = noone;