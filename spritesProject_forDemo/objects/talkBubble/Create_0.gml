/// @description Insert description here
// You can write your code in this editor

sX = global.speaker.x;
sY = global.speaker.y;

armXScale = 1;
yScale = 1;

var bubbleHeight	= sprite_get_height(spr_talkBubble);
var coverHeight		= sprite_get_height(spr_talkBubbleCover);

if (sY >= 112) {
	bubbleY			= 0;
	talkArmSprite	= spr_talkBubbleArmDown;
	yScale		= -1;
	
	armY = sY - 14;
	
	coverX = sX;
	coverY = bubbleY + bubbleHeight - coverHeight;
}

if (sY < 112) {
	bubbleY			= 224 - sprite_get_height(spr_talkBubble);
	talkArmSprite	= spr_talkBubbleArmDown;
	yScale			= 1;
	
	armY = sY + 14;
	
	coverX = sX - 16;
	coverY = bubbleY;
}

bubbleSprite	= spr_talkBubble;
coverSprite		= spr_talkBubbleCover;

if (sX >= 128) {
	armXScale = -1;
}

if (sX < 128) {
	armXScale = 1;
}

armX = sX;

bubbleX = 0;

text = global.dialogue;
pages = ds_list_create();

// grids to store any emojis 
emojiGrid	= ds_grid_create(0, 0);
pathGrid	= ds_grid_create(3, 0);

// variable to store the next path in a decoded list to be ready for use
nextPath	= ds_list_create();

// variable to store the point at which to begin the next path
nextPathCount = -1;

// variable to be increased as each letter is drawn to the screen
count = 0;

// variable to track the number of paths
pathCount = 0;