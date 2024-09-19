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

global.roomBuilt = false;