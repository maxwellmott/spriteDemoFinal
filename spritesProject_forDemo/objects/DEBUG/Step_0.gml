if (encoded) {
	if (global.select) {
		decoded_map = ds_map_create();
		decode_map(encoded_map, decoded_map);
		
		encoded_map = "";
		
		encoded = false;
	}
}

if !(encoded) {
	if (global.select) {
		encoded_map = encode_map(decoded_map);
		
		encoded = true;
	}
}