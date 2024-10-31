/// @description Insert description here
// You can write your code in this editor

sprite			= spr_overworld_ynPrompt;
spriteWidth		= sprite_get_width(sprite);
spriteHeight	= sprite_get_height(sprite);
yesButtonX		= guiWidth - spriteWidth;
noButtonX		= guiWidth - spriteWidth;

yesColor		= c_black;
noColor			= c_black;

if instance_exists(talkBubble) {
	// check if talk bubble is on the bottom of the screen
	if (talkBubble.y == guiHeight - talkBubble.bubbleHeight) {
		yesButtonY	= talkBubble.y - (spriteHeight * 2);
		noButtonY	= talkBubble.y - spriteHeight;
	}
	
	// else its on the top of the screen
	else {
		yesButtonY	= talkBubble.y;
		noButtonY	= talkBubble.y + spriteHeight;
	}
	
	// avoid talk arm
	if (talkBubble.x > guiWidth / 2) {
		yesButtonX	= 0;
		noButtonX	= 0;
	}
	
	caller = talkBubble;
}

if instance_exists(overworldAlert) {
	noButtonY	= guiHeight - talkBubble.bubbleHeight;
	yesButtonY	= noButtonY - spriteHeight;
	
	caller = overworldAlert;
}

func			= global.ynFunction;

yesButtonFrame	= 0;
noButtonFrame	= 0;

index			= 0;