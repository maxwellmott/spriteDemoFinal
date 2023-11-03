/// @desc

depth = get_layer_depth(LAYER.ui);

global.overworld = false;
instance_create_depth(x, y, get_layer_depth(LAYER.mouse), mouse);

x = player.x;
y = player.y;

textStartX = x + 59;
textStartY = y - 75;

correctAnswer = player.currentDoor.keypadCode;

currentAnswer = "";

#region create all buttons
var leftRowX		= x - 64;
var midRowX			= x - 16;
var rightRowX		= x + 32;

var topRowY			= y - 46;
var topMidRowY		= y - 14;
var bottomMidRowY	= y + 18;
var bottomRowY		= y + 50;

instance_create_depth(midRowX,		bottomRowY,		get_layer_depth(LAYER.uiFront),	keypadButton);
instance_create_depth(leftRowX,		topRowY,		get_layer_depth(LAYER.uiFront),	keypadButton);
instance_create_depth(midRowX,		topRowY,		get_layer_depth(LAYER.uiFront),	keypadButton);
instance_create_depth(rightRowX,	topRowY,		get_layer_depth(LAYER.uiFront),	keypadButton);
instance_create_depth(leftRowX,		topMidRowY,		get_layer_depth(LAYER.uiFront),	keypadButton);
instance_create_depth(midRowX,		topMidRowY,		get_layer_depth(LAYER.uiFront),	keypadButton);
instance_create_depth(rightRowX,	topMidRowY,		get_layer_depth(LAYER.uiFront),	keypadButton);
instance_create_depth(leftRowX,		bottomMidRowY,	get_layer_depth(LAYER.uiFront),	keypadButton);
instance_create_depth(midRowX,		bottomMidRowY,	get_layer_depth(LAYER.uiFront),	keypadButton);
instance_create_depth(rightRowX,	bottomMidRowY,	get_layer_depth(LAYER.uiFront),	keypadButton);
instance_create_depth(leftRowX,		bottomRowY,		get_layer_depth(LAYER.uiFront),	keypadButton);
instance_create_depth(rightRowX,	bottomRowY,		get_layer_depth(LAYER.uiFront),	keypadButton);
#endregion