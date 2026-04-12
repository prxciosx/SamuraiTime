#region HUD VIDA

var p = instance_find(obj_player, 0);
	
if (p != noone) {

    // POSIÇÃO DO SPRITE (BASE)
    var x_barra = 73 + 30;
    var y_barra = 20;

    // TAMANHO DO SPRITE
    var spr_w = 360;
    var spr_h = 47;

    // BARRA INTERNA (PROPORCIONAL)
    var largura = 313;
    var altura = 22;

    //  OFFSET
    var bx = x_barra + 47;
    var by = y_barra + (spr_h - altura) / 2;

    var vida_ratio = 0;
    if (p.vida_max > 0) {
        vida_ratio = p.vida / p.vida_max;
    }

    // Fundo
    draw_set_color(make_color_rgb(80, 20, 20));
    draw_rectangle(bx, by, bx + largura, by + altura, false);
    
    // Vida
    if (vida_ratio > 0.6) {
        draw_set_color(make_color_rgb(255, 200, 50));
    } else if (vida_ratio > 0.3) {
        draw_set_color(make_color_rgb(255, 100, 30));
    } else {
        draw_set_color(make_color_rgb(180, 30, 30));
    }
    
    draw_rectangle(bx, by, bx + (largura * vida_ratio), by + altura, false);

    // SPRITE POR CIMA (overlay)
    draw_sprite(spr_LifeBar, 0, x_barra, y_barra);
}

#endregion
#region HUD TS
if (p != noone){
	switch (global.tsu) {
		case 3: frame = 0; break;
		case 2: frame = 1; break;
		case 1: frame = 2; break;
		case 0: frame = 3; break;
	}
	draw_sprite(spr_ts, frame, 35, 10 );
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
#region EFEITO THE WORLD
// Ativar/desativar efeito
if (global.ts == true && !effect_active) {
    effect_active = true;   
    shake = 8;
    color_alpha = 0.6;
}

if (global.ts == false && effect_active) {
    effect_active = false;    
    color_alpha = 0;
}

// Efeitos visuais quando ativo
if (effect_active) {
    // Deslocamento RGB
    rgb_shift = sin(current_time * 0.02) * 2.5;
    
    // Pisca levemente
    if (irandom(30) == 0) {
        color_alpha = 0.7;
        alarm[0] = 5;
    }   
    
    // Tremor na câmera
    if (shake > 0) {
        shake -= 0.5;
        var _cam = view_camera[0];
        camera_set_view_pos(_cam, 
            camera_get_view_x(_cam) + random_range(-shake, shake),
            camera_get_view_y(_cam) + random_range(-shake, shake));
    }
}
#endregion
#region TUTORIAL
if (global.tutorial){
	draw_set_colour(c_black);
	var txt = "Press C to stop the time";
	
	// posição acima do personagem
	var tx = obj_player.x;
	var ty = obj_player.y - obj_player.sprite_height;

	// centraliza o texto
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);

	// desenha
	draw_text(tx, ty, txt);
}
#endregion