if (!abrindo && place_meeting(x, y, obj_player) && keyboard_check_pressed(ord("X"))) {

    sprite_index = spr_doorOpen;
    image_index = 0;
    image_speed = 1;
    abrindo = true;

    audio_play_sound(sou_VFX2, 2, false); 

    texto = "Press X";
}

    // fim da animação
if (abrindo && image_index >= image_number - 1) {
	audio_stop_sound(sou_VFX2);
    room_goto(GameEnd);
}
#region HUD
mostrar_texto = place_meeting(x, y, obj_player);
#endregion