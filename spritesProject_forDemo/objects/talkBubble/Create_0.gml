/// @description Insert description here
// You can write your code in this editor

sX = global.speaker.x;
sY = global.speaker.y;

armXScale = 1;
yScale = 1;

bubbleHeight	= sprite_get_height(spr_talkBubble);
var coverHeight		= sprite_get_height(spr_talkBubbleCover);

if (sY >= camera.y) {
	bubbleY			= 0;
	talkArmSprite	= spr_talkBubbleArmDown;
	yScale		= -1;
	
	armY = sY - 14;
	
	coverX = sX;
	coverY = bubbleY + bubbleHeight - coverHeight;
}

if (sY < camera.y) {
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
emoGrid		= ds_grid_create(4, 0);
pathGrid	= ds_grid_create(4, 0);
speedGrid	= ds_grid_create(3, 0);

// variable to store the next path in a decoded list to be ready for use
nextPath	= ds_list_create();

// variable to store the next emotion to display
nextEmotion = -1;

// variable to store the next talkingSpeed
nextSpeed = -1;

// boolean variables to signify whether dialogue should pause during
// the next path/emote
pathPauseBool	= -1;
emotePauseBool	= -1;

// variables to store the count at which to begin the next path/emotion/speed
nextPathCount	= -1;
nextEmoCount	= -1;
nextSpeedCount	= -1;

// variables to store the page on which to begin the next path/emotion/speed
nextPathPage	= -1;
nextEmoPage		= -1;
nextSpeedPage	= -1;

// variable to be increased as each letter is drawn to the screen
count = 0;

// variables to track the number of paths/emotes/speeds
pathCount	= 0;
emoCount	= 0;
speedCount	= 0;

// initialize bubbleWidth
bubbleWidth		= sprite_get_width(spr_talkBubble) - 8;

// initialize waitForInput (boolean variable that tells the code if it should 
// wait for the player to click enter before moving to the next page of dialogue)
waitForInput = true;

// variable to store the active talkingSpeed
talkingSpeed = 1;

// variable used to navigate pages
pageIndex = 0;

// build text
talk_bubble_build_dialogue();