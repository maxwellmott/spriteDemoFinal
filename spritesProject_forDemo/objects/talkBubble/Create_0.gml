sx = global.speaker.x;
sy = global.speaker.y;

bubbleSprite	= -1;
bubbleX			= -1;
bubbleY			= -1;
bubbleWidth		= -1;
bubbleHeight	= -1;
textX			= -1;
textY			= -1;
textWidth		= -1;

// check if speaker is left of the player
if (sx < player.x) {
	// check if there is room to draw the bubble to the left of the speaker
	if (sx >= 140) {
		// draw to the left of the speaker
		bubbleSprite	= spr_talkBubbleLeft;
		bubbleX			= sx - 12;
		bubbleY			= sy;
		
		bubbleWidth		= sprite_get_width(bubbleSprite);
		bubbleHeight	= sprite_get_height(bubbleSprite);
		
		textX			= bubbleX - bubbleWidth + 2;
		textY			= bubbleY - (bubbleHeight / 2) + 2;
		
		textWidth		= bubbleWidth - 10;
	}
}
else {	
// if speaker is right of the player
	// check if there is room to draw the bubble to the right of the speaker
	if (sx <= overworld.locationWidth - 140) {
		// draw to the right of the speaker
		bubbleSprite	= spr_talkBubbleRight;
		bubbleX			= sx + 12;
		bubbleY			= sy;
		
		bubbleWidth		= sprite_get_width(bubbleSprite);
		bubbleHeight	= sprite_get_height(bubbleSprite);
		
		textX			= bubbleX + 11;
		textY			= bubbleY - (bubbleHeight / 2) - 3;
		
		textWidth		= bubbleWidth - 2;
	}
}

// check if bubbleSprite has not yet been set
if (bubbleSprite == -1) {
	// check if the speaker is above the player
	if (sy >= player.y) {	
		// draw above the speaker
		bubbleSprite	= spr_talkBubbleUp;
		bubbleX			= sx;
		bubbleY			= sy - 21;
		
		bubbleWidth		= sprite_get_width(bubbleSprite);
		bubbleHeight	= sprite_get_height(bubbleSprite);
		
		textX			= bubbleX - (bubbleWidth / 2) + 2;
		textY			= bubbleY - bubbleHeight - 8;
		
		textWidth		= bubbleWidth - 2;
	}
	else {
	// if the speaker is below the player
		// draw below the speaker
		bubbleSprite	= spr_talkBubbleDown;	
		bubbleX			= sx;
		bubbleY			= sy + 21;
		
		bubbleWidth		= sprite_get_width(bubbleSprite);
		bubbleHeight	= sprite_get_height(bubbleSprite);
		
		textX			= bubbleX - (bubbleWidth / 2) + 2;
		textY			= bubbleY + bubbleHeight - 8;
		
		textWidth		= bubbleWidth - 2;
		
		// check if there is no room for the right half of the talk bubble
		if (sx > overworld.locationWidth - ((bubbleWidth / 2) + 8)) {
			bubbleSprite	= spr_talkBubbleSqueezeRight;
			
			textX			= bubbleX - 120;
			textY			= bubbleY - 40;		
		}
		
		// check if there is no room for the left half of the talk bubble
		if (sx < (bubbleWidth / 2) + 8) {
			bubbleSprite	= spr_talkBubbleSqueezeLeft;	
			
			textX			= bubbleX - 4;
			textY			= bubbleY + 8;
		}
	}
}

text = global.dialogueGrid[# 0, 0];

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
count = 1;

// variables to track the number of paths/emotes/speeds
pathCount	= 0;
emoCount	= 0;
speedCount	= 0;

// initialize waitForInput (boolean variable that tells the code if it should 
// wait for the player to click enter before moving to the next page of dialogue)
waitForInput = true;

// variable to store the active talkingSpeed
talkingSpeed = 1;

// variable used to navigate pages
pageIndex = 0;

// build text
talk_bubble_build_dialogue();

// create currentText variable
currentText = "";