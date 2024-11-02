/// @description Insert description here
// You can write your code in this editor

application_surface_draw_enable(false);

texturegroup_set_mode(true, false, fallbackTexture);
show_debug_overlay(true);
gpu_set_alphatestenable(false);

// create camera and controller right away
create_once(0, 0, LAYER.meta, controller);
create_once(0, 0, LAYER.meta, camera);
create_once(0, 0, LAYER.meta, audioManager);

// disable surface depth handling
surface_depth_disable(true);

// create guiSurface
guiSurface = surface_create(guiWidth, guiHeight);

// move background layer to background (as if this even matters anymore? I ain't deletin it)
move_layer("Background", LAYER.background);

// initialize debugDraw
debugDraw = false;

drawNums = "";

npcLocationList = ds_list_create();

if (is_debug_overlay_open()) {
	start_new_game();	
	show_debug_overlay(false);
}

bgmEffect = -1;