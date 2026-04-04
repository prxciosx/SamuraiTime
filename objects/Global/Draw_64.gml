
#region HUD VIDA

var p = instance_find(obj_player, 0);

if (p != noone) {

	var largura = 200;
	var altura = 20;

	var vida_ratio = 0;
	if (p.vida_max > 0) {
		vida_ratio = p.vida / p.vida_max;
	}

	// fundo
	draw_set_color(c_red);
	draw_rectangle(20, 20, 20 + largura, 20 + altura, false);

	// vida atual
	draw_set_color(c_green);
	draw_rectangle(20, 20, 20 + (largura * vida_ratio), 20 + altura, false);
}

#endregion


#region EFEITO KING CRIMSON

if (global.kc_ativo) {

    var alpha = global.kc_timer / global.kc_duracao;

    // overlay vermelho escuro
    draw_set_color(c_maroon);
    draw_set_alpha(0.4 * alpha);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);

    // flash branco
    draw_set_color(c_white);
    draw_set_alpha(0.2 * alpha);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);

    draw_set_alpha(1);
}

#endregion