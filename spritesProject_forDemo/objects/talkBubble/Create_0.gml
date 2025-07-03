speaker = global.speaker;

global.speaker = -1;

speaker.facing = player.facing + 2;

if (speaker.facing > 3) {
	speaker.facing -= 4;	
}

talkingSpeed = speaker.talkingSpeed;
voice = speaker.voice;
vocalRange = speaker.vocalRange;

sx = speaker.x;
sy = speaker.y;

roomWidth = overworld.locationWidth;
roomHeight = overworld.locationHeight;

dialogueGrid	= global.dialogueGrid;
dialogueRow		= global.dialogueRow;
dialogueColumn	= global.dialogueColumn;

dialogueKey		= global.dialogueKey;

global.dialogueGrid		= -1;
global.dialogueRow		= -1;
global.dialogueColumn	= -1;
global.dialogueKey		= -1;

bubbleX			= -1;
bubbleY			= -1;
textX			= -1;
textY			= -1;
bubbleFrame		= -1;

bubbleSprite	= spr_talkBubble;
bubbleWidth		= sprite_get_width(bubbleSprite);
bubbleHeight	= sprite_get_height(bubbleSprite);

textWidth = bubbleWidth - 8;
textHeight = bubbleHeight - 8;

// check if speaker is in the left half of the room
if (sx < roomWidth / 2) {
	// set bubbleX for left half frames
	bubbleX = sx + (bubbleWidth / 2);
	
	// check if the speaker is in the top half of the room
	if (sy < roomHeight / 2) {
		// set bubbleY for top half frames
		bubbleY = sy + (bubbleHeight / 2);
		
		// set bubbleFrame to top left normal
		bubbleFrame = TALK_BUBBLE_TYPES.TOP_LEFT_NORMAL;
		
		// set textX and textY for top left normal
		textX = sx + 3;
		textY = sy + 11;
		
		// check if the speaker is facing south (this means the player is below the speaker)
		if (speaker.facing == directions.south) {
			// reset the bubbleFrame to avoid the player
			bubbleFrame = TALK_BUBBLE_TYPES.TOP_LEFT_FIXED;
			
			// set textX and textY for top left fixed
			textX = sx + 10;
			textY = sy + 3;
		}
	}
	
	// check if the speaker is in the bottom half of the room
	if (sy >= roomHeight / 2) {
		// set bubbleY for bottom half frames
		bubbleY = sy - (bubbleHeight / 2);
		
		// set bubbleFrame to bottom left normal
		bubbleFrame = TALK_BUBBLE_TYPES.BOTTOM_LEFT_NORMAL;
		
		// set textX and textY for bottom left normal
		textX = sx + 3;
		textY = sy - 46;
		
		// check if the speaker is facing south (this means the player is above the speaker)
		if (speaker.facing == directions.north) {
			// reset the bubbleFrame to avoid the player
			bubbleFrame = TALK_BUBBLE_TYPES.BOTTOM_LEFT_FIXED;
			
			// set textX and textY for bottom left fixed
			textX = sx + 10;
			textY = sy - 38;
		}
	}
}

// check if the speaker is in the right half of the room
if (sx >= roomWidth / 2) {
	// set bubbleX for right half frames
	bubbleX = sx + (bubbleWidth / 2);
	
	// check if the speaker is in the top half of the room
	if (sy < roomHeight / 2) {
		// set bubbleY for top half frames
		bubbleY = sy + (bubbleHeight / 2);
		
		// set bubbleFrame to top right normal
		bubbleFrame = TALK_BUBBLE_TYPES.TOP_RIGHT_NORMAL;
		
		// set textX and textY for top right normal
		textX = sx - 117;
		textY = sy + 11;
		
		// check if the speaker is facing south (this means the player is below the speaker)
		if (speaker.facing == directions.south) {
			// reset the bubbleFrame to avoid the player
			bubbleFrame = TALK_BUBBLE_TYPES.TOP_RIGHT_FIXED;
			
			// set textX and textY for top right fixed
			textX = sx - 124;
			textY = sy + 3;
		}
	}
	
	// check if the speaker is in the bottom half of the room
	if (sy >= roomHeight / 2) {
		// set bubbleY for bottom half frames
		bubbleY = sy - (bubbleHeight / 2);
		
		// set bubbleFrame to bottom right normal
		bubbleFrame = TALK_BUBBLE_TYPES.BOTTOM_RIGHT_NORMAL;
		
		// set textX and textY for bottom right normal
		textX = sx - 117;
		textY = sy - 46;
		
		// check if the speaker is facing north (this means the player is above the speaker)
		if (speaker.facing == directions.north) {
			// reset the bubbleFrame to avoid the player
			bubbleFrame = TALK_BUBBLE_TYPES.BOTTOM_RIGHT_FIXED;
			
			// set textX and textY for bottom right fixed
			textX = sx - 124;
			textY = sy - 38;
		}
	}
}

text = dialogueGrid[# dialogueColumn, dialogueRow];

pages = ds_list_create();

// grids to store any emojis, paths, or talking speeds 
emoGrid			= ds_grid_create(4, 0);
pathGrid		= ds_grid_create(4, 0);
speedGrid		= ds_grid_create(3, 0);
dialogueQueue	= ds_list_create();

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

// variable used to navigate pages
pageIndex = 0;

// initialize the beginSpar and presentGift variables
beginSpar = false;
presentGift = false;

// build text
talk_bubble_build_dialogue();

// create currentText variable
currentText = "";