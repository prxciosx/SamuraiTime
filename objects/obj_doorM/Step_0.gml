// define destino baseado de onde veio
switch (room) {
    case Room2: sala = Room5; depth = -15999; break;
	case Room5: sala = Room2; depth = -16001; break;
    case Room3: sala = Room10; depth = -16001; break;
	case Room10: sala = Room3; depth = -16001; break;
    case Room7: sala = Room11; depth = -16001; break;
	case Room11: sala = Room7; depth = -16001; break;
}

// interação
if (global.inm >= global.inm_max){
	if (place_meeting(x,y,obj_player) && keyboard_check_pressed(ord("X")) && !abrindo) {
		entrada = room;
		
		sprite_index = spr_doorMOpen;
        image_index = 0;
        image_speed = 1;
        abrindo = true;
		audio_play_sound(sou_VFX2, 2, false);
	}
}
if (abrindo && image_index >= image_number - 1) {
	audio_stop_sound(sou_VFX2);
	room_goto(sala);
}
#region HUD
mostrar_texto = place_meeting(x, y, obj_player);
#endregion