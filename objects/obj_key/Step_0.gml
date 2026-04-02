if global.key == false{
	if (place_meeting(x,y,obj_player) && keyboard_check(ord("X"))){
		global.key = true;
		show_message("Você pegou a chave");	
	}
} else{
	instance_destroy();
}