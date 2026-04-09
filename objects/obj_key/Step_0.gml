if (global.key == false){

	if (place_meeting(x,y,obj_player) && keyboard_check_pressed(ord("X"))){
		global.key = true;
		audio_play_sound(sou_VFX1, 2, false);
		instance_destroy();
		show_debug_message("PEGOU");
	}
}else{
	instance_destroy();
}
#region HUD
mostrar_texto = place_meeting(x, y, obj_player);
#endregion