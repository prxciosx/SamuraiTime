if global.key == false{
	if (place_meeting(x,y,obj_player) && keyboard_check(ord("X"))){
		global.key = true;
			
	}
} else{
	instance_destroy();
}
#region HUD
mostrar_texto = place_meeting(x, y, obj_player);
#endregion