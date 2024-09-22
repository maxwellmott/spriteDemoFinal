/// @desc

depth = LAYER.mouse;

alpha = 0.0;

enum transitionStates {
	fadingIn,
	transitioning,
	fadingOut,
	height
}

state = transitionStates.fadingIn;

newBGM = global.newBGM;

global.roomBuilt = false;