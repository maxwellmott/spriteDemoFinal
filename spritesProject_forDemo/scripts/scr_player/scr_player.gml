#macro playerStartX			128
#macro playerStartY			128
#macro playerStartFacing	directions.south

// interactions enum
enum interactions {
	swimStart,
	swimStop,
	doorCheck,
	talk,
	read,
	height
}

function player_move() {
	
	// store all globals in locals
	var right	= global.char_right;
	var left	= global.char_left;
	var up		= global.char_up;
	var down	= global.char_down;
	var ow		= global.overworld;
	
	if (ow) {
	
		hmove = right - left;
		vmove = down - up;	
	}
	
	if !(ow) {
		hmove = 0;
		vmove = 0;
	}
	
	human_check_moving();
	if moving human_set_facing();
}

function gate_check_player() {
	// check north gate
	if (player.bbox_top < 0) {
		if (northExit >= 0) {
			overworld_transition(player.x, 772, directions.north, northExit);
		}	else player.y = 2;
	}
	
	// check east gate
	if (player.bbox_right > locationWidth) {
		if (eastExit >= 0) {
			overworld_transition(16, player.y, directions.east, eastExit);	
		}	else player.x = locationWidth - 9;
	}
	
	// check south gate
	if (player.bbox_bottom >= locationHeight) {
		if (southExit >= 0) {
			overworld_transition(player.x, 16, directions.south, southExit);	
		}	else player.y = locationHeight - 2;
	}
	
	// check west gate
	if (player.bbox_left < 0) {
		if (westExit >= 0) {
			overworld_transition(784, player.y, directions.west, westExit);	
		}	else player.x = 9;
	}
}
	
function overworld_create_player_sprite() {
	// get appearance list
	var app = player.appearance;
	var list = ds_list_create();
	decode_list(app, list);
	
	// decode color list
	var colorList = ds_list_create();
	decode_list(global.allColors, colorList);
	
	// get all appearance vars from list
	var skintoneNum					= real(list[| 0]);
	var skintone					= colorList[| skintoneNum];
	
	var outfit						= real(list[| 1]);
	var outfitColorNum				= real(list[| 2]);
	var outfitColor					= colorList[| outfitColorNum];
	
	var hairstyle					= real(list[| 3]);
	var hairColorNum				= real(list[| 4]);
	var hairColor					= colorList[| hairColorNum];
	
	var hat							= real(list[| 5]);
	var hatColorNum					= real(list[| 6]);
	var hatColor					= colorList[| hatColorNum];
	
	var shoes						= real(list[| 7]);
	var shoeColorNum				= real(list[| 8]);
	var shoeColor					= colorList[| shoeColorNum];
	
	var accessory					= real(list[| 9]);
	var accessoryColorNum			= real(list[| 10]);
	var accessoryColor				= colorList[| accessoryColorNum];
	
	// repeat for all humanStates
	var i = 0; repeat (humanStates.height) {
		
			// set temporary surface
			var surf = surface_create(400, 400);
			surface_set_target(surf);
			
			// clear display buffer
			draw_clear_alpha(c_black, 0.0);
			
			// use a switch statement to call the correct draw function
			switch (i) {
				case humanStates.standard:
					draw_standard_human(skintone, outfit, outfitColor, hairstyle, hairColor, hat, hatColor, shoes, shoeColor, accessory, accessoryColor);
					var frameCount = 16;
				break;
				case humanStates.wandering:
					draw_swimming_human(skintone, hairstyle, hairColor, hat, hatColor);
					var frameCount = 16;
				break;
				default: frameCount = -1;	break;
			}
			
			// create sprite from surface and add all frames
			if (frameCount > 0) {
				var currentSprite = sprite_create_from_surface(surf, 0, 0, humanSpriteWidth, humanSpriteHeight, false, false, 12, 21);
				var ii = 1; repeat (frameCount - 1) {
					// add next portion of surface as new frame
					sprite_add_from_surface(currentSprite, surf, ii * humanSpriteWidth, 0, humanSpriteWidth, humanSpriteHeight, false, false);

					// increment iii
					ii++;
				}
			}	else	currentSprite = -1;
			
			// add sprite to playerSpriteList 
			if currentSprite >= 0 {
				sprite_assign(playerSpriteList[| i], currentSprite);
				
				var i = 0; repeat (frameCount) {
					var sprText = sprite_get_texture(currentSprite, i);
					texturegroup_unload(string(sprText));
				}
			}
			
			// reset surface
			surface_reset_target();
			
			// free surface
			surface_free(surf);
		
			// delete sprite
			if (currentSprite >= 0) sprite_delete(currentSprite);
			
			// increment ii
			i++;
		
	}			
}
	
function player_get_sprites() {
	walkingSprite		= overworld.playerSpriteList[| humanStates.standard];
	eatingSprite		= overworld.playerSpriteList[| humanStates.eating];
	drinkingSprite		= overworld.playerSpriteList[| humanStates.drinking];
	wavephoneSprite		= overworld.playerSpriteList[| humanStates.playingWavephone];
	meditatingSprite	= overworld.playerSpriteList[| humanStates.meditating];
	swimmingSprite		= overworld.playerSpriteList[| humanStates.wandering];	// no swim state/no wander sprite	
	
	appearanceLoaded = true;
}