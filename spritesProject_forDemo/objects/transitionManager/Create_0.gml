/// @desc
destroy_if_possible(overworld);
destroy_if_possible(overworldDraw);

depth = LAYER.mouse;

alpha = 0.0;

enum transitionStates {
	fadingIn,
	transitioning,
	fadingOut,
	height
}

state = transitionStates.fadingIn;