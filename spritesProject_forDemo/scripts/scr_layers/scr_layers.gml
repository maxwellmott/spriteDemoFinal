enum LAYER {
	mouse,
	alerts,
	uiFront,
	ui,
	uiBack,
	sprites,
	upperStoryTiles,
	rugs,
	collidableTiles,
	waterTiles,
	groundTiles,
	background,
	meta,
	height
}

///@desc This function is NOT the built-in function. This is the correct function to call.
/// it will return the number value corresponding to the layer ID you entered as an argument
function get_layer_depth(_layer){
	switch(_layer) {
		case LAYER.mouse:
			return 250;
		break;
		case LAYER.alerts:
			return 300;
		break;
		case LAYER.uiFront:
			return 350;
		break;
		case LAYER.ui:
			return 400;
		break;
		case LAYER.uiBack:
			return 450;
		break;
		case LAYER.sprites:
			return 500;
		break;
		case LAYER.upperStoryTiles:
			return 550;
		break;
		case LAYER.collidableTiles:
			return 1800;
		break;
		case LAYER.waterTiles:
			return 1850;
		break;
		case LAYER.rugs:
			return 1875;
		break;
		case LAYER.groundTiles:
			return 1900;
		break;
		case LAYER.background:
			return 1950;
		break;
		case LAYER.meta:
			return 2000;
		break;
	}
}

///@desc This function can be used to move an existing layer to a different depth value by giving
/// the name of an existing layer and the LAYER id corresponding to the desired depth.
function move_layer(name, _layer) {
	layer_depth(layer_get_id(name), get_layer_depth(_layer));
}

///@desc This function is currently only being used to set the depth of doors when
/// they are not meant to be displayed in front of the frontmost wall while indoors.
/// It just does the math that I'm doing when I create all the other scenery. Maybe
/// you should redo the door object and clean all that up and then rework this somehow)
function object_set_depth() {
	depth = get_layer_depth(LAYER.collidableTiles) - y;
}