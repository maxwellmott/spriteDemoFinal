#macro TILEWIDTH		32
#macro TILEHEIGHT		32

///@desc This function is called when a new location is being built. After getting the
/// proper tile layer, tileset, list of tiles, and number of rows/columns, then the function
/// places all of the tiles in their respective position
function place_all_tiles(_tileLayer, _tileset, _encodedList, _rowCount, _columnCount) {	
	// get vars
	var tileLayer	= _tileLayer;
	var tileset		= real(_tileset);
	var encodedList = _encodedList;
	var rowCount	= real(_rowCount);
	var columnCount	= real(_columnCount);
	
	// create temp list
	var list		= ds_list_create();
	
	// decode the grid
	decode_list(encodedList, list);
	
	// get width and height for tilemap
	var tilemapWidth	= columnCount * TILEWIDTH;
	var tilemapHeight	= rowCount * TILEHEIGHT;
	
	// get tilemap using given layer
	var tilemap = layer_tilemap_create(tileLayer, 0, 0, tileset, tilemapWidth, tilemapHeight);
	
	// use those numbers to find the amount of tiles
	var tileCount	= rowCount * columnCount;
	
	// set all tiles using a repeat loop
	var i = 0; repeat (tileCount) {
		
		// find tile x using modulo
		var tileX = i mod columnCount;
		
		// find tile y using div
		var tileY = i div columnCount;
		
		var rawToken = list[| i];
		var tileID	= list[| i];
		
		tileID	= string_digits(tileID);
		
		if tileID >= 0 {
		// set the tile
			tilemap_set_at_pixel(tilemap, tileID, (tileX * TILEWIDTH) + (TILEWIDTH / 2), (tileY * TILEHEIGHT) + (TILEHEIGHT - 2));
		}

		// increment i
		i++;
	}
	
	// destroy temp list
	ds_list_destroy(list);
	
	return tilemap;
}

///@desc This function can be used to do a pixel perfect check for the given type of tile
function tile_meeting(_x, _y, _tilemap, _checker) {
	// get local vars
	var _tm			= _tilemap;
	
	// create a single tile checker of the given type
	if !(instance_exists(_checker)) {instance_create_depth(0, 0, get_layer_depth(LAYER.uiFront), _checker);}
	
	// get the column and row number of each tile being touched by the player's bbox after the move
	var _x1 = tilemap_get_cell_x_at_pixel(_tm, bbox_left + (_x - x), y);
	var _y1 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_top + (_y - y));
	var _x2 = tilemap_get_cell_x_at_pixel(_tm, bbox_right + (_x - x), y);
	var _y2 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_bottom + (_y - y));
	
	// check for all tiles being touched by the bbox
	for (var tileX = _x1; tileX <= _x2; tileX++) {
		for (var tileY = _y1; tileY <= _y2; tileY++) {
			
			// break if the tile is offscreen
			var rw = overworld.tileColumnCount; var rh = overworld.tileRowCount;
			if (tileX < 0) || (tileY < 0) || (tileX > rw) || (tileY > rh) break;
			
			// check if there is tile data at (tileX, tileY)
			var _tile = tile_get_index(tilemap_get(_tm, tileX, tileY));
			if (_tile) {
				
				// set the checker's x and y to perfectly overlay the tile in question
				_checker.x = tileX * tilemap_get_tile_width(_tm);
				_checker.y = tileY * tilemap_get_tile_height(_tm);
				
				// set the frame to match the tile in question
				_checker.image_index = _tile;
				
				// return true if there is a collision
				if (place_meeting(_x, _y, _checker)) {return true;}
			}
		}
	}
	
	// return false if it gets through without any collisions
	return false;
}