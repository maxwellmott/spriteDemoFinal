// check if rectangleSurface doesn't exist
if !(surface_exists(cubeMenuSurface)) {
	// create rectangleSurface
	cubeMenuSurface = surface_create(surfaceWidth, surfaceHeight);	
}

// draw cubeMenuSurface
draw_surface(cubeMenuSurface, surfaceX, surfaceY);