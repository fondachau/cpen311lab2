module keyboardint(kbd, D,E,B,F,R){
	input [7:0] kbd;
	
	output D,E,B,F,R;
	
	//ANDing the keyboard input with the ASCII representation of the characters
	//Then using unary reduction to see if input == specified character
	//and update at every keyboard press
	always_ff @(posedge kbd){
		D <= &(character_D & kdb)| &(character_d & kbd)
		E <= &(character_E & kdb)| &(character_e & kbd)
		B <= &(character_B & kdb)| &(character_b & kbd)
		F <= &(character_F & kdb)| &(character_f & kbd)
		R <= &(character_R & kdb)| &(character_r & kbd)
	}
}
