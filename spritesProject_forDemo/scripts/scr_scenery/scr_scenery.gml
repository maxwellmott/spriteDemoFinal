// enumerator containing sceneryIDs
enum sceneryIDs {
	firmrootTree,
	farseedTree,
	graywoodTree,
	boulder,
	subBoulder,
	firmrootCluster,
	farseedCluster,
	graywoodCluster,
	boulderCluster,
	subBoulderCluster,
	cityStreetlight,
	cityShortLamp,
	crystalLampPost,
	retroSendport,
	modernCoffeeTable,
	postIndustrialCountertop,
	postIndustrialCupboard,
	lavishDiningTable,
	ruggedDiningTable,
	ruggedSleepingPad,
	height
}

// enumerator containing sceneryParams
enum sceneryParams {
	ID,
	type,
	sprite,
	mask,
	name,
	height
}

// enumerator containing sceneryTypes
enum sceneryTypes {
	cluster,
	flower,
	lamppost,
	window,
	bookcase,
	boulder,
	fence,
	largeSign,
	neonSign,
	smallSign,
	tree,
	sendport,
	table,
	bed,
	height
}

// create overworld object grid
global.sceneryGrid = ds_grid_create(sceneryParams.height, sceneryIDs.height);

// create add to master grid function
function master_grid_add_scenery(_ID) {
	var i = 0; repeat(sceneryParams.height) {
		ds_grid_set(global.sceneryGrid, i, _ID, argument[i]);
		i++;
	}
}

// add all objects to master grid	ID										TYPE					SPRITE							MASK								NAME
master_grid_add_scenery(			sceneryIDs.firmrootTree,				sceneryTypes.tree,		spr_firmrootTree,				spr_firmrootMask,					"FIRMROOT TREE");
master_grid_add_scenery(			sceneryIDs.farseedTree,					sceneryTypes.tree,		spr_farseedTree,				spr_farseedMask,					"FARSEED TREE");
master_grid_add_scenery(			sceneryIDs.graywoodTree,				sceneryTypes.tree,		spr_graywoodTree,				spr_graywoodMask,					"GRAYWOOD TREE");
master_grid_add_scenery(			sceneryIDs.firmrootCluster,				sceneryTypes.cluster,	spr_firmrootCluster,			spr_firmrootClusterMask,			"FIRMROOT CLUSTER");
master_grid_add_scenery(			sceneryIDs.farseedCluster,				sceneryTypes.cluster,	spr_farseedCluster,				spr_farseedClusterMask,				"FARSEED CLUSTER");
master_grid_add_scenery(			sceneryIDs.graywoodCluster,				sceneryTypes.cluster,	spr_graywoodCluster,			spr_graywoodClusterMask,			"GRAYWOOD CLUSTER");
master_grid_add_scenery(			sceneryIDs.boulderCluster,				sceneryTypes.cluster,	spr_boulderCluster,				spr_boulderClusterMask,				"BOULDER CLUSTER");
master_grid_add_scenery(			sceneryIDs.subBoulderCluster,			sceneryTypes.cluster,	spr_subBoulderCluster,			spr_subBoulderClusterMask,			"SUBBOULDER CLUSTER");
master_grid_add_scenery(			sceneryIDs.cityStreetlight,				sceneryTypes.lamppost,	spr_cityStreetlight,			spr_cityStreetlightMask,			"CITY STREETLIGHT");
master_grid_add_scenery(			sceneryIDs.cityShortLamp,				sceneryTypes.lamppost,	spr_cityShortlamp,				spr_cityShortlampMask,				"CITY SHORT LAMP");
master_grid_add_scenery(			sceneryIDs.crystalLampPost,				sceneryTypes.lamppost,	spr_crystalStreetlight,			spr_crystalStreetlightMask,			"CRYSTAL STREETLIGHT");
master_grid_add_scenery(			sceneryIDs.boulder,						sceneryTypes.boulder,	spr_boulder,					spr_boulderMask,					"BOULDER");
master_grid_add_scenery(			sceneryIDs.subBoulder,					sceneryTypes.boulder,	spr_subBoulder,					spr_subBoulderMask,					"SUBMERGED BOULDER");
master_grid_add_scenery(			sceneryIDs.retroSendport,				sceneryTypes.sendport,	spr_sendport,					spr_sendportMask,					"RETRO SENDPORT");
master_grid_add_scenery(			sceneryIDs.modernCoffeeTable,			sceneryTypes.table,		spr_modernCoffeeTable,			spr_modernCoffeeTableMask,			"MODERN COFFEE TABLE");
master_grid_add_scenery(			sceneryIDs.postIndustrialCountertop,	sceneryTypes.table,		spr_postIndustrialCountertop,	spr_postIndustrialCountertopMask,	"POST INDUSTRIAL COUNTERTOP");
master_grid_add_scenery(			sceneryIDs.postIndustrialCupboard,		sceneryTypes.table,		spr_postIndustrialCupboard,		spr_postIndustrialCupboardMask,		"POST INDUSTRIAL CUPBOARD");
master_grid_add_scenery(			sceneryIDs.lavishDiningTable,			sceneryTypes.table,		spr_lavishDiningTable,			spr_lavishDiningTableMask,			"LAVISH DINING TABLE");
master_grid_add_scenery(			sceneryIDs.ruggedDiningTable,			sceneryTypes.table,		spr_ruggedDiningTable,			spr_ruggedDiningTableMask,			"RUGGED DINING TABLE");
master_grid_add_scenery(			sceneryIDs.ruggedSleepingPad,			sceneryTypes.bed,		spr_ruggedSleepingPad,			spr_ruggedSleepingPad,				"RUGGED SLEEPING PAD");

// convert grid to an encoded string
global.allScenery = encode_grid(global.sceneryGrid);

// destroy sceneryGrid
ds_grid_destroy(global.sceneryGrid);

#region ALL SCENERY FUNCTIONS

///@desc This function is called when a new location is being loaded. The
/// function gets all of the scenery that is meant to be in the current
/// location and loads it into it's respective position
function place_scenery(_encodedList) {
	// get local vars
	var el = _encodedList;
	
	// decode list
	var list = ds_list_create();
	decode_list(el, list);
	
	// get list size
	var size = ds_list_size(list);
	
	// decode the sceneryGrid to a temp grid
	var grid = ds_grid_create(sceneryParams.height, sceneryIDs.height);
	decode_grid(global.allScenery, grid);
	
	// use a repeat loop to get the parameters of each token and then create it
	var i = 0; repeat (size) {
		// get id and coordinates from list
		var str = list[| i];
		var params = ds_list_create();
		decode_list(str, params);
		
		var _x = real(params[|0]);
		var _y = real(params[|1]);
		var ID = real(params[|2]);

		// get params from grid using ID
		var type		= grid[# sceneryParams.type,			ID];
		var spr			= grid[# sceneryParams.sprite,			ID];
		var mask		= grid[# sceneryParams.mask,			ID];
		
		type		= real(type);
		spr			= correct_string_after_decode(spr);
		mask		= correct_string_after_decode(mask);

		// get the proper object and create it
		var obj		= scenery_get_object_index(type);
		var inst	= instance_create_depth(_x, _y, get_layer_depth(LAYER.collidableTiles), obj);
		
		// set object vars
		inst.type			= type;
		inst.spriteID		= spr;
		inst.sprite_index	= mask;
		inst.spriteWidth	= sprite_get_width(spr);
		inst.spriteHeight	= sprite_get_height(spr);
		inst.x				= _x;
		inst.y				= _y;
		inst.depth			= scenery_get_depth(_y);
		
		// set lightY if lamppost
		if (type == sceneryTypes.lamppost) {
			switch (ID) {
				case sceneryIDs.cityStreetlight:	inst.lightY = _y - 46;	inst.lightScale = 2;	break;
				case sceneryIDs.cityShortLamp:		inst.lightY = _y - 27;	inst.lightScale = 2;	break;
				case sceneryIDs.crystalLampPost:	inst.lightY = _y - 30;	inst.lightScale = 3;	break;
			}
		}
		
		// set tabletop params
		if (type == sceneryTypes.table) {
			switch (ID) {
				case sceneryIDs.postIndustrialCountertop:	inst.tabletopLeft = _x - 29;	inst.tabletopRight = _x + 28;	inst.tabletopTop = _y - 30;	inst.tabletopBottom = _y - 20;	break;
				case sceneryIDs.postIndustrialCupboard:		inst.tabletopLeft = _x - 30;	inst.tabletopRight = _x + 30;	inst.tabletopTop = _y - 25; inst.tabletopBottom = _y - 19;	break;
			}
		}
		
		// increment i
		i++;
	}
	
	// check if there are any tables
	if (instance_number(table) > 0) {	
		// use a repeat loop to correct the depth of all objects colliding with tables
		var	i = 0;	repeat (instance_number(table)) {
			// get the current scenery instance
			var inst = instance_find(table, i);
			
			#region SCENERY--TABLE COLLISIONS
			// check if it is colliding with a table
			with (inst) {
				// create a temp list
				var l = ds_list_create();
			
				// store all scenery collisions on the temp list
				collision_rectangle_list(tabletopLeft, tabletopTop, tabletopRight, tabletopBottom, scenery, false, true, l, true);
			
				// if there are any scenery collisions
				if (ds_list_size(l) > 0) {
					// use a repeat loop to get all scenery on the list
					var i = 0;	repeat (ds_list_size(l)) {
						// get the next scenery instance
						var sid = l[| i];
						
						// set it's depth to one less than the table's depth
						sid.depth = inst.depth - 1;
						
						// increment i
						i++;
					}
				}
				
				// destroy the temp list
				ds_list_destroy(l);
				
				#endregion
				
				#region LITERATURE--TABLE COLLISIONS
				// create a temp list
				var l = ds_list_create();
			
				// store all scenery collisions on the temp list
				collision_rectangle_list(tabletopLeft, tabletopTop, tabletopRight, tabletopBottom, literature, false, true, l, true);
			
				// if there are any scenery collisions
				if (ds_list_size(l) > 0) {
					// use a repeat loop to get all scenery on the list
					var i = 0;	repeat (ds_list_size(l)) {
						// get the next scenery instance
						var sid = l[| i];
						
						// set it's depth to one less than the table's depth
						sid.depth = inst.depth - 1;
						
						// increment i
						i++;
					}
				}
				
				// destroy the temp list
				ds_list_destroy(l);
			}
			#endregion
		
			// increment i
			i++;
		}
	}

	// set sceneryCreated to true
	sceneryCreated	= true;
}

///@desc This function uses a switch statement to return the object index
/// of the given instance of scenery
function scenery_get_object_index(_type) {
	var t = _type;
	
	switch (t) {
		
		case sceneryTypes.cluster:
			return cluster;
		break;
		
		case sceneryTypes.flower:
			return flower;
		break;
		
		case sceneryTypes.lamppost:
			return lamppost;
		break;
		
		case sceneryTypes.window:
			return window;
		break;
		
		case sceneryTypes.bookcase:
			return bookcase;
		break;
		
		case sceneryTypes.boulder:
			return boulder;
		break;
		
		case sceneryTypes.fence:
			return fence;
		break;
		
		case sceneryTypes.largeSign:
			return largeSign;
		break;
		
		case sceneryTypes.neonSign:
			return neonSign;
		break;
		
		case sceneryTypes.smallSign:
			return smallSign;
		break;
		
		case sceneryTypes.tree:
			return tree;
		break;
		
		case sceneryTypes.sendport:
			return sendport;
		break;
		
		case sceneryTypes.table:
			return table;
		break;
		
		case sceneryTypes.bed:
			return bed;
		break;
	}
}

///@desc This function draws all of the scenery objects in the room
function app_surface_draw_scenery() {
	surface_set_target(application_surface);
		draw_sprite(spriteID, frame, x, y);
	surface_reset_target();
}

///@desc This function can be called to set the depth of a scenery object
function scenery_get_depth(_depthY) {
	var dy = _depthY;
	
	return get_layer_depth(LAYER.collidableTiles) - dy;
}

#endregion