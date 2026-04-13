if (instance_exists(obj_player)){
if (effect_active) {
    
    
    // NÃO desenha a surface novamente!
    // Apenas aplica o filtro por cima do que já foi desenhado
    
    // Sombra escura/cinza na tela (só isso)
    draw_set_color(timestop_color);
    draw_set_alpha(color_alpha);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1);
    
    // Linhas de distorção temporal
    draw_set_color(c_yellow);
    draw_set_alpha(0.3);
    for (var i = 0; i < 8; i++) {
        var y_pos = room_height * (sin(current_time * 0.008 + i) * 0.3 + 0.5);
        draw_line(0, y_pos, room_width, y_pos);
    }
    draw_set_alpha(1);
    
   
}
}