/// @desc

// set alpha
draw_set_alpha(alpha);

// set font, alignment, alpha, and color
draw_set(fa_center, fa_middle, alpha, $001f00);
draw_set_font(ssFont);

// draw names
draw_text(x, tbDrawY, tbName);
draw_text(x, cbDrawY, cbName);
draw_text(x, bbDrawY, bbName);

// draw clock
draw_set_font(overworldFont);
draw_text(clockX, clockY, drawHours + ":" + drawMinutes);

// reset alpha
draw_set_alpha(1.0);