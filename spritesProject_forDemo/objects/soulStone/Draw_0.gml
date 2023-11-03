/// @desc

// draw outline
draw_self();

// draw offScreen background
draw_sprite(ssMenu_offScreen, 0, x, y);

// set alpha
draw_set_alpha(alpha);

// draw onScreen background
draw_sprite(ssMenu_onScreen, 0, x, y);

// reset alpha
draw_set_alpha(1.0);