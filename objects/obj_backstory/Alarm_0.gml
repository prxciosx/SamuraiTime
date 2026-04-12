 // soma tempo real
tempo += delta_time / 1000000;

// CENAS NORMAIS
if (image_index < scene_max) {
    
    if (tempo >= duracao) {
        image_index += 1;
        tempo = 0;
    }
    
    alarm[0] = 1;
}

// ÚLTIMA CENA
else if (image_index == scene_max) {
    
    // NÃO avança automático
    alarm[0] = 1;
    
    // só sai quando apertar
    if (keyboard_check_pressed(ord("X"))) {
        room_goto_next();
    }
}