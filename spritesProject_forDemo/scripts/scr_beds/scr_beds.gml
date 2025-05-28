// declare an enumerator for all comforter IDs
enum COMFORTERS {
	AFFORDABLE_MODERN,
	HEIGHT
}

// This is a function that is used to load all beds into the room. There needs to be a 
// special list just for beds since they have individual comforters.
function place_beds(_encodedList) {
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
		var _c = real(params[|3]);
	
		// get params from grid using ID
		var type		= grid[# sceneryParams.type,			ID];
		var spr			= grid[# sceneryParams.sprite,			ID];
		var mask		= grid[# sceneryParams.mask,			ID];
		
		type		= real(type);
		spr			= correct_string_after_decode(spr);
		mask		= correct_string_after_decode(mask);

		var inst	= instance_create_depth(_x, _y, get_layer_depth(LAYER.collidableTiles), bed);
		
		// set object vars
		inst.type			= type;
		inst.spriteID		= spr;
		inst.sprite_index	= mask;
		inst.spriteWidth	= sprite_get_width(spr);
		inst.spriteHeight	= sprite_get_height(spr);
		inst.x				= _x;
		inst.y				= _y;
		inst.depth			= scenery_get_depth(_y);
		inst.comforter		= _c;
		inst.spriteTop		= 34 * _c;
		
		// increment i
		i++;
	}
	
}