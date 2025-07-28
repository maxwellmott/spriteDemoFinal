// enumerator containing SCENERY
enum SCENERY {
	FIRMROOT_TREE,
	FARSEED_TREE,
	GRAYWOOD_TREE,
	BOULDER,
	SUB_BOULDER,
	FIRMROOT_CLUSTER,
	FARSEED_CLUSTER,
	GRAYWOOD_CLUSTER,
	BOULDER_CLUSTER,
	SUB_BOULDER_CLUSTER,
	CITY_STREET_LIGHT,
	CITY_SHORT_LAMP,
	CRYSTAL_LAMP_POST,
	RETRO_SENDPORT,
	MODERN_COFFEE_TABLE,
	POST_INDUSTRIAL_COUNTERTOP,
	POST_INDUSTRIAL_CUPBOARD,
	LAVISH_DINING_TABLE,
	RUGGED_DINING_TABLE,
	RUGGED_SLEEPING_PAD,
	TRADITIONAL_WINDOW_INDOOR_UPSTAIRS,
	TRADITIONAL_WINDOW_INDOOR_NORMAL,
	TRADITIONAL_WINDOW_OUTDOOR,
	TRADITIONAL_WOODEN_BOOKCASE,
	TRADITIONAL_WOODEN_BEDFRAME,
	HEIGHT
}

// enumerator containing SCENERY_PARAMS
enum SCENERY_PARAMS {
	ID,
	TYPE,
	SPRITE,
	MASK,
	NAME,
	HEIGHT
}

// enumerator containing SCENERY_TYPES
enum SCENERY_TYPES {
	CLUSTER,
	FLOWER,
	LAMPPOST,
	WINDOW,
	BOOKCASE,
	BOULDER,
	FENCE,
	LARGE_SIGN,
	NEON_SIGN,
	SMALL_SIGN,
	TREE,
	SENDPORT,
	TABLE,
	BED,
	HEIGHT
}

// create overworld object grid
global.sceneryGrid = ds_grid_create(SCENERY_PARAMS.HEIGHT, SCENERY.HEIGHT);

// create add to master grid function
function master_grid_add_scenery(_ID) {
	var i = 0; repeat(SCENERY_PARAMS.HEIGHT) {
		ds_grid_set(global.sceneryGrid, i, _ID, argument[i]);
		i++;
	}
}

// add all objects to master grid	ID											TYPE					SPRITE									MASK									NAME
master_grid_add_scenery(			SCENERY.FIRMROOT_TREE,					SCENERY_TYPES.TREE,		spr_firmrootTree,						spr_firmrootMask,						"FIRMROOT TREE");
master_grid_add_scenery(			SCENERY.FARSEED_TREE,						SCENERY_TYPES.TREE,		spr_farseedTree,						spr_farseedMask,						"FARSEED TREE");
master_grid_add_scenery(			SCENERY.GRAYWOOD_TREE,					SCENERY_TYPES.TREE,		spr_graywoodTree,						spr_graywoodMask,						"GRAYWOOD TREE");
master_grid_add_scenery(			SCENERY.FIRMROOT_CLUSTER,					SCENERY_TYPES.CLUSTER,	spr_firmrootCluster,					spr_firmrootClusterMask,				"FIRMROOT CLUSTER");
master_grid_add_scenery(			SCENERY.FARSEED_CLUSTER,					SCENERY_TYPES.CLUSTER,	spr_farseedCluster,						spr_farseedClusterMask,					"FARSEED CLUSTER");
master_grid_add_scenery(			SCENERY.GRAYWOOD_CLUSTER,					SCENERY_TYPES.CLUSTER,	spr_graywoodCluster,					spr_graywoodClusterMask,				"GRAYWOOD CLUSTER");
master_grid_add_scenery(			SCENERY.BOULDER_CLUSTER,					SCENERY_TYPES.CLUSTER,	spr_boulderCluster,						spr_boulderClusterMask,					"BOULDER CLUSTER");
master_grid_add_scenery(			SCENERY.SUB_BOULDER_CLUSTER,				SCENERY_TYPES.CLUSTER,	spr_subBoulderCluster,					spr_subBoulderClusterMask,				"SUBBOULDER CLUSTER");
master_grid_add_scenery(			SCENERY.CITY_STREET_LIGHT,					SCENERY_TYPES.LAMPPOST,	spr_cityStreetlight,					spr_cityStreetlightMask,				"CITY STREETLIGHT");
master_grid_add_scenery(			SCENERY.CITY_SHORT_LAMP,					SCENERY_TYPES.LAMPPOST,	spr_cityShortlamp,						spr_cityShortlampMask,					"CITY SHORT LAMP");
master_grid_add_scenery(			SCENERY.CRYSTAL_LAMP_POST,					SCENERY_TYPES.LAMPPOST,	spr_crystalStreetlight,					spr_crystalStreetlightMask,				"CRYSTAL STREETLIGHT");
master_grid_add_scenery(			SCENERY.BOULDER,							SCENERY_TYPES.BOULDER,	spr_boulder,							spr_boulderMask,						"BOULDER");
master_grid_add_scenery(			SCENERY.SUB_BOULDER,						SCENERY_TYPES.BOULDER,	spr_subBoulder,							spr_subBoulderMask,						"SUBMERGED BOULDER");
master_grid_add_scenery(			SCENERY.RETRO_SENDPORT,					SCENERY_TYPES.SENDPORT,	spr_sendport,							spr_sendportMask,						"RETRO SENDPORT");
master_grid_add_scenery(			SCENERY.MODERN_COFFEE_TABLE,				SCENERY_TYPES.TABLE,		spr_modernCoffeeTable,					spr_modernCoffeeTableMask,				"MODERN COFFEE TABLE");
master_grid_add_scenery(			SCENERY.POST_INDUSTRIAL_COUNTERTOP,		SCENERY_TYPES.TABLE,		spr_postIndustrialCountertop,			spr_postIndustrialCountertopMask,		"POST INDUSTRIAL COUNTERTOP");
master_grid_add_scenery(			SCENERY.POST_INDUSTRIAL_CUPBOARD,			SCENERY_TYPES.TABLE,		spr_postIndustrialCupboard,				spr_postIndustrialCupboardMask,			"POST INDUSTRIAL CUPBOARD");
master_grid_add_scenery(			SCENERY.LAVISH_DINING_TABLE,				SCENERY_TYPES.TABLE,		spr_lavishDiningTable,					spr_lavishDiningTableMask,				"LAVISH DINING TABLE");
master_grid_add_scenery(			SCENERY.RUGGED_DINING_TABLE,				SCENERY_TYPES.TABLE,		spr_ruggedDiningTable,					spr_ruggedDiningTableMask,				"RUGGED DINING TABLE");
master_grid_add_scenery(			SCENERY.RUGGED_SLEEPING_PAD,				SCENERY_TYPES.BED,		spr_ruggedSleepingPad,					spr_ruggedSleepingPad,					"RUGGED SLEEPING PAD");
master_grid_add_scenery(			SCENERY.TRADITIONAL_WINDOW_OUTDOOR,		SCENERY_TYPES.WINDOW,	spr_traditionalWindowOutdoor,			spr_traditionalWindowOutdoor,			"TRADITIONAL WINDOW");
master_grid_add_scenery(			SCENERY.TRADITIONAL_WINDOW_INDOOR_NORMAL,	SCENERY_TYPES.WINDOW,	spr_traditionalWindowIndoor,			spr_traditionalWindowIndoor,			"TRADITIONAL WINDOW");
master_grid_add_scenery(			SCENERY.TRADITIONAL_WINDOW_INDOOR_UPSTAIRS, SCENERY_TYPES.WINDOW,	spr_traditionalWindowIndoorUpstairs,	spr_traditionalWindowIndoorUpstairs,	"TRADITIONAL WINDOW");
master_grid_add_scenery(			SCENERY.TRADITIONAL_WOODEN_BOOKCASE,		SCENERY_TYPES.BOOKCASE,	spr_traditionalWoodenBookcase,			spr_traditionalWoodenBookcaseMask,		"TRADITIONAL WOODEN BOOKCASE");
master_grid_add_scenery(			SCENERY.TRADITIONAL_WOODEN_BEDFRAME,		SCENERY_TYPES.BED,		spr_traditionalWoodenBedframe,			spr_traditionalWoodenBedframeMask,		"TRADITIONAL WOODEN BEDFRAME");

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
	var grid = ds_grid_create(SCENERY_PARAMS.HEIGHT, SCENERY.HEIGHT);
	decode_grid(global.allScenery, grid);
	
	// use a repeat loop to get the parameters of each token and then create it
	var i = 0; repeat (size) {
		// get id and coordinates from list
		var str = list[| i];
		var params = ds_list_create();
		decode_list(str, params);
		
		var _x = correct_string_after_decode(params[|0]);
		var _y = correct_string_after_decode(params[|1]);
		var ID = correct_string_after_decode(params[|2]);

		// get params from grid using ID
		var type		= grid[# SCENERY_PARAMS.TYPE,			ID];
		var spr			= grid[# SCENERY_PARAMS.SPRITE,			ID];
		var mask		= grid[# SCENERY_PARAMS.MASK,			ID];
		
		type		= correct_string_after_decode(type);
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
		if (type == SCENERY_TYPES.LAMPPOST) {
			switch (ID) {
				case SCENERY.CITY_STREET_LIGHT:	inst.lightY = _y - 46;	inst.lightScale = 2;	break;
				case SCENERY.CITY_SHORT_LAMP:		inst.lightY = _y - 27;	inst.lightScale = 2;	break;
				case SCENERY.CRYSTAL_LAMP_POST:	inst.lightY = _y - 30;	inst.lightScale = 3;	break;
			}
		}
		
		// set tabletop params
		if (type == SCENERY_TYPES.TABLE) {
			switch (ID) {
				case SCENERY.POST_INDUSTRIAL_COUNTERTOP:	inst.tabletopLeft = _x - 29;	inst.tabletopRight = _x + 28;	inst.tabletopTop = _y - 30;	inst.tabletopBottom = _y - 20;	break;
				case SCENERY.POST_INDUSTRIAL_CUPBOARD:		inst.tabletopLeft = _x - 30;	inst.tabletopRight = _x + 30;	inst.tabletopTop = _y - 25; inst.tabletopBottom = _y - 19;	break;
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
		
		case SCENERY_TYPES.CLUSTER:
			return cluster;
		break;
		
		case SCENERY_TYPES.FLOWER:
			return flower;
		break;
		
		case SCENERY_TYPES.LAMPPOST:
			return lamppost;
		break;
		
		case SCENERY_TYPES.WINDOW:
			return window;
		break;
		
		case SCENERY_TYPES.BOULDER:
			return boulder;
		break;
		
		case SCENERY_TYPES.FENCE:
			return fence;
		break;
		
		case SCENERY_TYPES.LARGE_SIGN:
			return largeSign;
		break;
		
		case SCENERY_TYPES.NEON_SIGN:
			return neonSign;
		break;
		
		case SCENERY_TYPES.SMALL_SIGN:
			return smallSign;
		break;
		
		case SCENERY_TYPES.TREE:
			return tree;
		break;
		
		case SCENERY_TYPES.SENDPORT:
			return sendport;
		break;
		
		case SCENERY_TYPES.TABLE:
			return table;
		break;
		
		case SCENERY_TYPES.BED:
			return bed;
		break;
	}
}

///@desc This function draws all of the scenery objects in the room
function draw_scenery() {
	draw_sprite(spriteID, frame, x, y);
	
	// check if any beds exist
	if (object_index == bed) {
		draw_sprite_part(comforterSheet, 0, 0, spriteTop, spriteWidth, spriteHeight, x - (spriteWidth / 2), y - spriteHeight);
	}	
}

///@desc This function can be called to set the depth of a scenery object
function scenery_get_depth(_depthY) {
	var dy = _depthY;
	
	return get_layer_depth(LAYER.collidableTiles) - dy;
}

#endregion