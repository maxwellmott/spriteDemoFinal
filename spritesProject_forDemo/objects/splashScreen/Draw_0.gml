draw_set_alpha(1.0);

// draw background 
draw_rectangle_color(0, 0, screenWidth, screenHeight, $e69ee2, $e69ee2, $e69ee2, $e69ee2, false);

// draw logo
draw_sprite(spr_logo, 0, screenWidth / 2, screenHeight / 2);

draw_set_alpha(alpha);

// draw black rectangle to fade in and out
draw_rectangle_color(0, 0, screenWidth, screenHeight, c_black, c_black, c_black, c_black, false);

draw_set_alpha(1.0);