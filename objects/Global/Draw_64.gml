#region HUD VIDA
// Colocar no DRAW GUI Event do obj_global

var p = instance_find(obj_player, 0);
	
if (p != noone) {
    var largura = 200;
    var altura = 30;
    var x_barra = 73;
    var y_barra = 20;
    
    var vida_ratio = 0;
    if (p.vida_max > 0) {
        vida_ratio = p.vida / p.vida_max;
    }
    
    // Moldura estilo pergaminho/samurai
    draw_set_color(c_black);
    draw_rectangle(x_barra - 2, y_barra - 2, x_barra + largura + 2, y_barra + altura + 2, false);
    
    // Fundo da barra (vermelho escuro)
    draw_set_color(make_color_rgb(80, 20, 20));
    draw_rectangle(x_barra, y_barra, x_barra + largura, y_barra + altura, false);
    
    // Vida atual (gradiente de vermelho para dourado)
    if (vida_ratio > 0.6) {
        draw_set_color(make_color_rgb(255, 200, 50)); // dourado
    } else if (vida_ratio > 0.3) {
        draw_set_color(make_color_rgb(255, 100, 30)); // laranja
    } else {
        draw_set_color(make_color_rgb(180, 30, 30)); // vermelho sangue
    }
    
    draw_rectangle(x_barra, y_barra, x_barra + (largura * vida_ratio), y_barra + altura, false);
    
    // Bordas internas (efeito "sulco")
    draw_set_color(c_black);
    draw_rectangle(x_barra, y_barra, x_barra + largura, y_barra + 2, false); // borda superior
    draw_rectangle(x_barra, y_barra + altura - 2, x_barra + largura, y_barra + altura, false); // borda inferior
}
#endregion
#region HUD TIME STOP

var x_pos = 30;
var y_pos = 35;
var tamanho = 50;
var usos = global.tsu;
var usos_max = 3;

var ratio = usos / usos_max;

// Fundo escuro
draw_set_color(c_black);
draw_set_alpha(0.7);
draw_circle(x_pos, y_pos, tamanho/2, false);
draw_set_alpha(1);

// Borda que muda de cor
if (ratio > 0.6) {
    draw_set_color(make_color_rgb(100, 200, 150));
} else if (ratio > 0.3) {
    draw_set_color(make_color_rgb(220, 180, 80));
} else {
    draw_set_color(make_color_rgb(200, 50, 50));
}
draw_circle(x_pos, y_pos, tamanho/2, true);

// Preenchimento interno que diminui
draw_set_color(c_black);
draw_circle(x_pos, y_pos, (tamanho/2 - 4) * ratio, false);

// Rachaduras (aparecem quando baixo)
if (ratio < 0.6) {
    draw_set_color(make_color_rgb(200, 100, 50));
    draw_set_alpha(0.8);
    draw_line(x_pos - 8, y_pos - 5, x_pos + 3, y_pos + 6);
    draw_line(x_pos + 9, y_pos - 3, x_pos + 14, y_pos + 2);
    if (ratio < 0.3) {
        draw_line(x_pos - 12, y_pos + 3, x_pos - 4, y_pos + 9);
        draw_line(x_pos + 5, y_pos + 8, x_pos + 11, y_pos + 14);
        draw_line(x_pos - 2, y_pos - 12, x_pos + 4, y_pos - 4);
    }
    draw_set_alpha(1);
}

// Número centralizado
draw_set_color(c_white);
if (ratio < 0.3) {
    draw_set_color(make_color_rgb(255, 100, 100));
}

// Centraliza o texto
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Desenha no centro da bolha
draw_text(x_pos, y_pos, string(usos) + "/" + string(usos_max));

// Volta ao normal (opcional, evita bugs em outros draws)
draw_set_halign(fa_left);
draw_set_valign(fa_top);

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
    
    // Partículas ao ativar
    for (var i = 0; i < 60; i++) {
        var xx = camera_get_view_x(view_camera[0]) + random(camera_get_view_width(view_camera[0]));
        var yy = camera_get_view_y(view_camera[0]) + random(camera_get_view_height(view_camera[0]));
        part_particles_create(part_sys, xx, yy, part_spark, 1);
    }
    
    shake = 8;
    color_alpha = 0.6;
}

if (global.ts == false && effect_active) {
    effect_active = false;
    
    // Partículas ao desativar
    for (var i = 0; i < 40; i++) {
        var xx = camera_get_view_x(view_camera[0]) + random(camera_get_view_width(view_camera[0]));
        var yy = camera_get_view_y(view_camera[0]) + random(camera_get_view_height(view_camera[0]));
        part_particles_create(part_sys, xx, yy, part_spark, 1);
    }
    
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
    
    // Partículas flutuantes
    if (irandom(10) == 0) {
        var xx = camera_get_view_x(view_camera[0]) + random(camera_get_view_width(view_camera[0]));
        var yy = camera_get_view_y(view_camera[0]) + random(camera_get_view_height(view_camera[0]));
        part_particles_create(part_sys, xx, yy, part_spark, 1);
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