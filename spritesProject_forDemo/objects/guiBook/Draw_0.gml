/// @description Insert description here
// You can write your code in this editor

// this needs to be here or the book (having a sprite index and being set
// to visible) will draw itself in it's x and y position since all of the
// drawing is happening in the draw GUI event and not here.

// since this is here w/o the draw_self() function, the book will not draw
// itself this way. Turning visible to false will keep the Draw GUI event from
// being processed as well. Thanks GMS2 -______-