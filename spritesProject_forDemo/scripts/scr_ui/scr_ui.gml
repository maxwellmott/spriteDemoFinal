#macro	guiWidth	256
#macro	guiHeight	224

function overworld_yesNoPrompt(_function) constructor {
	sprite			= spr_overworld_ynPrompt;
	yesButtonX		= player.x + 108;
	yesButtonY		= player.y - 16;
	noButtonX		= player.x + 108;
	noButtonY		= player.y + 16;
	
	func			= _function;
	
	yesButtonFrame	= 0;
	noButtonFrame	= 0;
	selectorFrame	= 0;
	selectorX		= yesButtonX;
	selectorY		= yesButtonY;
	index			= 0;
	
	method_step = function() {
		index -= global.menu_up;
		index += global.menu_down;
		
		if (index > 1) index = 0;
		if (index < 0) index = 1;
		
		if !(index) {selectorX = yesButtonX;	selectorY = yesButtonY;}
		if (index)	{selectorX = noButtonX;		selectorY = noButtonY;}
		
		if (global.select) {
			if (index == 0) {
				yesButtonFrame = 1;
				selectorFrame = 1;
				overworldAlert.visible = false;
				ds_list_delete(overworld.alertStack, 0);
				execute(func);
				instance_destroy(overworldAlert);
			}
			
			if (index == 1) {
				noButtonFrame = 1;
				selectorFrame = 1;
				overworldAlert.visible = false;
				ds_list_delete(overworld.alertStack, 0);
				instance_destroy(overworldAlert);
			}
		}
	}
	
	method_draw = function() {
		draw_sprite(sprite, yesButtonFrame, yesButtonX, yesButtonY);
		draw_sprite(sprite, noButtonFrame, noButtonX, noButtonY);
		draw_set_color(c_white);
		draw_text(yesButtonX, yesButtonY, "yes");
		draw_text(noButtonX, noButtonY, "no");
		draw_set_color(c_black);
		draw_text(yesButtonX, yesButtonY, "yes");
		draw_text(noButtonX, noButtonY, "no");
		draw_sprite(spr_ynSelector, selectorFrame, selectorX, selectorY);
	}
}

#region keypad button functions
function addZero() {
	keypad.currentAnswer += "0";
}

function addOne() {
	keypad.currentAnswer += "1";	
}

function addTwo() {
	keypad.currentAnswer += "2";
}

function addThree() {
	keypad.currentAnswer += "3";
}

function addFour() {
	keypad.currentAnswer += "4";
}

function addFive() {
	keypad.currentAnswer += "5";
}

function addSix() {
	keypad.currentAnswer += "6";
}

function addSeven() {
	keypad.currentAnswer += "7";
}

function addEight() {
	keypad.currentAnswer += "8";
}

function addNine() {
	keypad.currentAnswer += "9";
}

function checkAnswer() {
	if (keypad.currentAnswer == keypad.correctAnswer) {
		keypad.visible = false;
		ds_list_push(overworld.alertStack, overworldAlerts.keypadSuccess);
		ds_list_push(overworld.alertStack, overworldAlerts.doorUnlocked);
		door_unlock(player.currentDoor);
		instance_destroy(keypad);
	}
	else if (keypad.currentAnswer != keypad.correctAnswer) {
		keypad.visible = false;
		ds_list_push(overworld.alertStack, overworldAlerts.keypadFailure);
		instance_destroy(keypad);
	}
}

function closeKeypad() {
	instance_destroy(keypad);
}
#endregion