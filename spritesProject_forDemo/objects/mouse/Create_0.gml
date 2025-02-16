/// @desc

depth = get_layer_depth(LAYER.mouse) - 1;

leftEdge = camera.x - (guiWidth / 2);
rightEdge = camera.x + (guiWidth / 2);
topEdge = camera.y - (guiHeight / 2);
bottomEdge = camera.y + (guiHeight / 2);

x = leftEdge + guiWidth / 2;
y = topEdge + guiHeight / 2;

fadeRate = 0.05;

alpha = 1.0;

idle = false;

hvrSet = false;