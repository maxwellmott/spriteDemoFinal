initialGrid = ds_grid_create(2, 6);

ds_grid_add(initialGrid, 0, 0, "one");
ds_grid_add(initialGrid, 0, 1, "two");
ds_grid_add(initialGrid, 0, 2, "three");
ds_grid_add(initialGrid, 0, 3, "four");
ds_grid_add(initialGrid, 0, 4, "five");
ds_grid_add(initialGrid, 0, 5, "six");

ds_grid_add(initialGrid, 1, 0, "red");
ds_grid_add(initialGrid, 1, 1, "orange");
ds_grid_add(initialGrid, 1, 2, "yellow");
ds_grid_add(initialGrid, 1, 3, "green");
ds_grid_add(initialGrid, 1, 4, "blue");
ds_grid_add(initialGrid, 1, 5, "purple");

decodedMap = ds_map_create();

/*
ds_map_add(decodedMap, "one",	"red");
ds_map_add(decodedMap, "two",	"orange");
ds_map_add(decodedMap, "three",	"yellow");
ds_map_add(decodedMap, "four",	"green");
ds_map_add(decodedMap, "five",	"blue");
ds_map_add(decodedMap, "six",	"purple");
*/

convert_grid_to_map(initialGrid, decodedMap);

encodedMap = encode_map(decodedMap);

ds_map_destroy(decodedMap);

encoded = true;