// this is the max alpha for the layer of darkness that fades in during sunset and out during sunrise.
#macro camWidth					256
#macro camHeight				224
#macro shadowBlendAlpha			0.65

function populate_object_draw_list() {	

	var list = overworldDraw.objectDrawList;
	
	// add all sceneryIDs to list
	with (scenery) {
		if (spriteHeight >= 0) ds_list_add(list, id);
	}
	
	// add all human IDs to list
	with (human) {
		if (spriteHeight >= 0) ds_list_add(list, id);
	}
}

// this function should be called in the overworldDraw's draw end event to
// sort all scenery and humans by their y values and draws them to the overworldDrawSurface
// in that order
function draw_objects_sorted_depth() {
	// use a repeat loop to appropriately draw each object in the list
	var i = 0; repeat (ds_list_size(objectDrawList)) {
		// get inst
		var inst = objectDrawList[| i];
		
		// check object type
		var parent = object_get_parent(inst.object_index);
		
		// draw if human
		if (parent == human) {
			draw_human(inst);
		}
		
		// draw if scenery
		if (parent == scenery) || (parent == sceneryCollidable) {
			draw_scenery(inst);
		}
		
		// increment i
		i++;
	}
}

function draw_shadows_sorted_depth() {
	var dc = overworldDraw.darkColor;
	var sa = overworldDraw.shadowAlpha;
	
	// use a repeat loop to appropriately draw each object in the list
	var i = 0; repeat (ds_list_size(objectDrawList)) {
		// get inst
		var inst = objectDrawList[| i];
		
		// check object type
		var parent = object_get_parent(inst.object_index);
		
		// draw if human
		if (parent == human) {			
			if !inst.swimming	draw_sprite_ext(humanShadowMask, 0, inst.x, inst.shadowY, 1, 1, 0, dc, sa);
		}
		
		// draw if scenery
		if (parent == scenery) || (parent == sceneryCollidable) {
			draw_scenery_shadow(inst);
		}
		
		// increment i
		i++;
	}
}

function reset_object_draw_list() {
	// reset list
	ds_list_destroy(objectDrawList);
	objectDrawList = ds_list_create();	
}

function object_depth_sort() {
	var size = ds_list_size(objectDrawList);
	
	var i = 0;	repeat (size - 1) {
		
		var j = 0;	repeat (size - i - 1) {
			var token1	= objectDrawList[| j];
			var dy1		= token1.y;
			
			var token2	= objectDrawList[| j + 1];
			var dy2		= token2.y;
			
			if (dy1 < dy2) {
				var temp = objectDrawList[| j];
				objectDrawList[| j] = objectDrawList[| j + 1];
				objectDrawList[| j + 1] = temp;
			}
			
			j++;
		}
		
		i++;
	}
}