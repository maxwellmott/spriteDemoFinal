// create temp keyboard list
var charList = ds_list_create();

// build keyboard character list (with shift 
// and no shift options)
ds_list_add(charList,	"a,A",
						"b,B",
						"c,C",
						"d,D",
						"e,E",
						"f,F",
						"g,G",
						"h,H",
						"i,I",
						"j,J",
						"k,K",
						"l,L",
						"m,M",
						"n,N",
						"o,O",
						"p,P",
						"q,Q",
						"r,R",
						"s,S",
						"t,T",
						"u,U",
						"v,V",
						"w,W",
						"x,X",
						"y,Y",
						"z,Z",
						"1,1",
						"2,2",
						"3,3",
						"4,4",
						"5,5",
						"6,6",
						"7,7",
						"8,8",
						"9,9",
						"0,0",
						"-,'",
						"<,>");

// encode the charList
global.keyboardCharacters = encode_list(charList);

// destroy the temp list
ds_list_destroy(charList);