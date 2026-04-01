// define lado da porta
if (x > 700) {
    image_xscale = 1;
    direcao = 1;
} else {
    image_xscale = -1;
    direcao = -1;
}

// interação
if (place_meeting(x,y,obj_player) && keyboard_check_pressed(ord("X"))) {
    sprite_index = spr_doorOpen;
    image_index = 0;
    image_speed = 1;
    abrindo = true;
}

// fim da animação
if (abrindo && image_index >= image_number - 1) {
    if (direcao == 1) {
        room_goto_next();
    } else {
        room_goto_previous();
    }
}