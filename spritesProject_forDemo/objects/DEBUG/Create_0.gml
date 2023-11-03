decodedMap = ds_map_create();

ds_map_add(decodedMap, "one",		"red");
ds_map_add(decodedMap, "two",		"orange");
ds_map_add(decodedMap, "three",	"yellow");
ds_map_add(decodedMap, "four",	"green");
ds_map_add(decodedMap, "five",	"blue");
ds_map_add(decodedMap, "six",		"purple");

encodedMap = encode_map(decodedMap);

ds_map_destroy(decodedMap);

encoded = true;