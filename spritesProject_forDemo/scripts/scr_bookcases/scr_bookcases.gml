///@desc This function is called when new location is being loaded. The function builds
/// all of the bookcases that are supposed to be in the room and places each piece in it's
/// respective position
function place_bookcases(_encodedList) {
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
		// get param string from list
		var str = list[| i];
		var params = ds_list_create();
		decode_list(str, params);
		
		// store x, y, ID, and bookcaseNum in temp vars
		var _x = real(params[|0]);
		var _y = real(params[|1]);
		var ID = real(params[|2]);
		var bn = real(params[|3]);
		
		// get params from grid using ID
		var type		= grid[# sceneryParams.type,			ID];
		var spr			= grid[# sceneryParams.sprite,			ID];
		var mask		= grid[# sceneryParams.mask,			ID];
		
		// correct all values after decoding
		type		= real(type);
		spr			= correct_string_after_decode(spr);
		mask		= correct_string_after_decode(mask);

		// create the bookcase
		var inst	= instance_create_depth(_x, _y, get_layer_depth(LAYER.collidableTiles), bookcase);
		
		// set object vars
		inst.type			= type;
		inst.spriteID		= spr;
		inst.sprite_index	= mask;
		inst.spriteWidth	= sprite_get_width(spr);
		inst.spriteHeight	= sprite_get_height(spr);
		inst.x				= _x;
		inst.y				= _y;
		inst.depth			= scenery_get_depth(_y);
		inst.bookcaseNum	= bn;
		
		// increment i
		i++;
	}
}