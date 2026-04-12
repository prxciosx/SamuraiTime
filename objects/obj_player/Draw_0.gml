draw_self();
if (tp) {
    draw_set_color(c_red);
    draw_line(x, y - 64, mouse_x, mouse_y);
}
if (global.ghost > 0 && global.tsu == 0){

    draw_set_color(c_black);
	var txt = "Press R if you're stuck";

	// posição acima do personagem
	var tx = x;
	var ty = y - sprite_height;

	// centraliza o texto
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);

	// desenha
	draw_text(tx, ty, txt);
}