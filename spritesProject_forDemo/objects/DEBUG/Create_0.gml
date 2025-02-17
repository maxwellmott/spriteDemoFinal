initial_grid = ds_grid_create(2, 6);

ds_grid_add(initial_grid, 0, 0, "one");
ds_grid_add(initial_grid, 0, 1, "two");
ds_grid_add(initial_grid, 0, 2, "three");
ds_grid_add(initial_grid, 0, 3, "four");
ds_grid_add(initial_grid, 0, 4, "five");
ds_grid_add(initial_grid, 0, 5, "six");

ds_grid_add(initial_grid, 1, 0, "red");
ds_grid_add(initial_grid, 1, 1, "LOGROT_ORANGE");
ds_grid_add(initial_grid, 1, 2, "yellow");
ds_grid_add(initial_grid, 1, 3, "green");
ds_grid_add(initial_grid, 1, 4, "blue");
ds_grid_add(initial_grid, 1, 5, "purple");

decoded_map = ds_map_create();

/*
ds_map_add(decoded_map, "one",	"red");
ds_map_add(decoded_map, "two",	"LOGROT_ORANGE");
ds_map_add(decoded_map, "three",	"yellow");
ds_map_add(decoded_map, "four",	"green");
ds_map_add(decoded_map, "five",	"blue");
ds_map_add(decoded_map, "six",	"purple");
*/

convert_grid_to_map(initial_grid, decoded_map);

encoded_map = encode_map(decoded_map);

ds_map_destroy(decoded_map);

encoded = true;