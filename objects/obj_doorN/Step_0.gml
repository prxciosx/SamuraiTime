// Define se a sala 11 deve inverter as portas
var inverter = (room == Room11);

// define lado da porta baseado na posição e na inversão
if (x > 700) {
    direcao = inverter ? -1 : 1;
} else {
    direcao = inverter ? 1 : -1;
}
image_xscale = direcao;
// interação
// interação
if (global.inm >= global.inm_max){

    if (!abrindo && place_meeting(x, y, obj_player) && keyboard_check_pressed(ord("X"))) {
        
        if (room == Room2 && global.key == false && x>700) {
            texto = "Need a key...";
        } 
        else {
            sprite_index = spr_doorOpen;
            image_index = 0;
            image_speed = 1;
            abrindo = true;

            audio_play_sound(sou_VFX2, 2, false); 

            texto = "Press X";
        }
    }

    // fim da animação
    if (abrindo && image_index >= image_number - 1) {
		audio_stop_sound(sou_VFX2);
        if (direcao == 1) {
            room_goto_next();
        } else {
            room_goto_previous();
        }
    }
}
#region HUD
mostrar_texto = place_meeting(x, y, obj_player);
#endregion