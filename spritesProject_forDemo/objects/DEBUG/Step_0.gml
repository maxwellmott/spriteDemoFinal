if (encoded) {
	if (global.select) {
		decodedMap = ds_map_create();
		decode_map(encodedMap, decodedMap);
		
		encodedMap = "";
		
		encoded = false;
	}
}

if !(encoded) {
	if (global.select) {
		encodedMap = encode_map(decodedMap);
		
		encoded = true;
	}
}