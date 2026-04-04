if (instance_exists(obj_player)) {

	var largura = 200;
	var altura = 20;

	var vida_ratio = 0;
	if (obj_player.vida_max > 0) {
		vida_ratio = obj_player.vida / obj_player.vida_max;
	}

	draw_set_color(c_red);
	draw_rectangle(20, 20, 20 + largura, 20 + altura, false);

	draw_set_color(c_green);
	draw_rectangle(20, 20, 20 + (largura * vida_ratio), 20 + altura, false);
}