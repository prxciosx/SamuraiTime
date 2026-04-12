global.ghost = instance_number(obj_ghost);
// controla efeito King Crimson
if (global.kc_ativo) {
    global.kc_timer--;

    if (global.kc_timer <= 0) {
        global.kc_ativo = false;
    }
}

// diminui shake
if (global.shake > 0) {
    global.shake--;
}

// aplica shake na câmera
var cam = view_camera[0];

var sx = random_range(-global.shake, global.shake);
var sy = random_range(-global.shake, global.shake);

// posição base da câmera
var cx = camera_get_view_x(cam);
var cy = camera_get_view_y(cam);

// aplica offset
camera_set_view_pos(cam, cx + sx, cy + sy);

if (!instance_exists(obj_boss)){
	global.time_scale = 2;
}
#region TIMESTOP EFFECT
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
var nova_musica = -1;

switch(room){
	case MenuI:
		nova_musica = sou_menu;
	break;
	
	case Room11:
		nova_musica = sou_boss;
	break;
	
	case BackStory:
		nova_musica = sou_backstory;
	break;
	
	case GameEnd:
		nova_musica = sou_GameEnd;
		creditos = true;
	break;
	
	default:
		nova_musica = sou_fase;
	break;
}

if (musica_atual != nova_musica && nova_musica != -1) {
	if (musica_atual != -1) {
		audio_stop_sound(musica_atual);
	}
	
	audio_play_sound(nova_musica, 1, true);
	musica_atual = nova_musica;
}