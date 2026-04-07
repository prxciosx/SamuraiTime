if (distance_to_object(obj_player) < 80 && global.inm >= global.inm_max) {

    var cam = view_camera[0];

    var px = x - camera_get_view_x(cam);
    var py = y - camera_get_view_y(cam) - 140;

    var texto = "Press X";

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    var w = string_width(texto) + 20;
    var h = string_height(texto) + 10;

    draw_set_color(c_black);
    draw_rectangle(px - w/2, py - h/2, px + w/2, py + h/2, false);

    draw_set_color(c_white);
    draw_text(px, py, texto);
}