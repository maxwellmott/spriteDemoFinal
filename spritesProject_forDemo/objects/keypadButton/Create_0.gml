/// @desc create button functions and initialize vars

numberID	= instance_number(keypadButton) - 1;

switch (numberID) {
	case 0:		sprite_index = spr_keypadZeroButton;	func = addZero;		break;
	case 1:		sprite_index = spr_keypadOneButton;		func = addOne;		break;
	case 2:		sprite_index = spr_keypadTwoButton;		func = addTwo;		break;
	case 3:		sprite_index = spr_keypadThreeButton;	func = addThree;	break;
	case 4:		sprite_index = spr_keypadFourButton;	func = addFour;		break;
	case 5:		sprite_index = spr_keypadFiveButton;	func = addFive;		break;
	case 6:		sprite_index = spr_keypadSixButton;		func = addSix;		break;
	case 7:		sprite_index = spr_keypadSevenButton;	func = addSeven;	break;
	case 8:		sprite_index = spr_keypadEightButton;	func = addEight;	break;
	case 9:		sprite_index = spr_keypadNineButton;	func = addNine;		break;
	case 10:	sprite_index = spr_keypadCheckButton;	func = checkAnswer;	break;
	case 11:	sprite_index = spr_keypadCancelButton;	func = closeKeypad;	break;
}

visible = true;

