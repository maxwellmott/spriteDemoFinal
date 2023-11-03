move_layer("Background", LAYER.background);

cliffSpriteHeight	= sprite_get_height(spr_titleScreenCliffs);
cliffSpriteWidth	= sprite_get_width(spr_titleScreenCliffs);

cliffDrawX			= 0;
cliffDrawY			= screenHeight;

waveSpriteHeight	= sprite_get_height(spr_titleScreenWaves);
waveDrawX			= 0;
waveDrawY			= screenHeight - cliffSpriteHeight - waveSpriteHeight;

waveDrawWidth		= screenWidth;
waveDrawHeight		= waveSpriteHeight;

var colorID		= colors.scarlet;
var colorList	= ds_list_create();
decode_list(global.allColors, colorList);
backgroundColor	= colorList[| colorID];

#region CREATE BUTTONS
buttonX				= cliffDrawX + 144;
firstButtonY		= 159;
buttonSpriteHeight	= sprite_get_height(spr_titleScreenButton);
secondButtonY		= firstButtonY + buttonSpriteHeight;
thirdButtonY		= secondButtonY + buttonSpriteHeight;

continueButton	= instance_create_depth(buttonX, firstButtonY,	get_layer_depth(LAYER.uiFront),	buttonParent);
newGameButton	= instance_create_depth(buttonX, secondButtonY,	get_layer_depth(LAYER.uiFront),	buttonParent);
optionsButton	= instance_create_depth(buttonX, thirdButtonY,	get_layer_depth(LAYER.uiFront),	buttonParent);

continueButton.func = new_game;	continueButton.sprite_index	= spr_titleScreenButton;
newGameButton.func	= new_game;	newGameButton.sprite_index	= spr_titleScreenButton;
optionsButton.func	= new_game;	optionsButton.sprite_index	= spr_titleScreenButton;

#endregion

instance_create_depth(waveDrawX, waveDrawY, get_layer_depth(LAYER.mouse), mouse);