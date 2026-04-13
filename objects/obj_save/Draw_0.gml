draw_self();
if (texto) {

    // posição baseada na câmera + posição da porta
    var px = camera_get_view_x(view_camera[0]) + x;

    // altura dinâmica (baseada no tamanho da sprite)
    var py = camera_get_view_y(view_camera[0]) + y - sprite_height - 16;

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);


    // tamanho da caixa
    var w = string_width(txt) + 20;
    var h = string_height(txt) + 10;

    // fundo (com leve transparência)
    draw_set_alpha(0.7);
    draw_set_color(c_black);
    draw_rectangle(px - w/2, py - h/2, px + w/2, py + h/2, false);

    // texto
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_text(px, py, txt);
}