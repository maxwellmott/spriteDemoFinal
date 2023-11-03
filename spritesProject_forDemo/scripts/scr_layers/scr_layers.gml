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

function create_layer(_layer) {
	layer_create(get_layer_depth(_layer), string(_layer));
}

function move_layer(name, _layer) {
	layer_depth(layer_get_id(name), get_layer_depth(_layer));
}

function object_set_depth() {
	depth = get_layer_depth(LAYER.collidableTiles) - y;
}