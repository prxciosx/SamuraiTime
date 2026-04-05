if ((mostrar_texto) && (global.inm >= global.inm_max)) {
    
    var px = camera_get_view_x(view_camera[0]) + x;
    var py = camera_get_view_y(view_camera[0]) + y - 90;

    var texto = "Press X";

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    // tamanho da caixa baseado no texto
    var w = string_width(texto) + 20;
    var h = string_height(texto) + 10;

    // caixa preta
    draw_set_color(c_black);
    draw_rectangle(px - w/2, py - h/2, px + w/2, py + h/2, false);

    // texto branco
    draw_set_color(c_white);
    draw_text(px, py, texto);
}