/// @description Insert description here
// You can write your code in this editor

draw_set_font(plainFont);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_black);

with (mouse) {
	event_perform(ev_gui, 1);	
}

// set surface to GUI
surface_set_target(game.guiSurface);
	// draw background
	draw_sprite(spr_battleSceneBackground, 0, 0, 0);
	
	// draw spell backdrop
	
	// draw arena if there is one
	
	// draw sprites
	var i = 0; repeat (8) {
		var inst = spriteList[| i];
		
		draw_set_alpha(inst.alpha);
		draw_sprite(inst.sprite, 0, inst.x, inst.y);	
		
		i++;
	}
	
	// draw selectionMenu
	if (sparPhase == sparPhases.select) {
		draw_sprite(spr_sparSelectionMenu, 0, messageX, messageY);
		draw_text_transformed(messageX, messageY, msg, 0.5, 0.5, 0);
	}
	
	// if there is an action button, draw all the buttons
	if (instance_exists(sparActionButton)) {
		var count = instance_number(sparActionButton);
		
		var i = 0;	repeat (count) {
			var inst = sparActionMenu.actionButtons[| i];
			
			draw_sprite(spr_sparActionButton, inst.frame, inst.x, inst.y);
			draw_set_color(inst.textColor);
			
			draw_text_transformed(inst.x, inst.y, inst.name, 0.5, 0.5, 0);
			
			i++;
		}
		
		draw_set_color(c_black);
	}
	
	// draw ui

	
	// draw spell FX
	
// reset surface
surface_reset_target();