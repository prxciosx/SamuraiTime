global.inm = 0;
global.inm_max = 0;

global.key = false;
global.ts = false;
global.dano = 25;
global.tsu = 1;
global.time_scale = 2;

// HUD / efeitos
global.kc_ativo = false;
global.kc_timer = 0;
global.kc_duracao = 20;

// screen shake
global.shake = 0;

// ========== TIME STOP EFFECT ==========

// Cores
timestop_color = c_gray;
color_alpha = 0;

// Efeito de deslocamento RGB
rgb_shift = 0;

// Sistema de partículas
part_sys = part_system_create();
part_spark = part_type_create();

part_type_shape(part_spark, pt_shape_spark);
part_type_size(part_spark, 0.5, 1.2, 0, 0);
part_type_color2(part_spark, c_yellow, c_orange);
part_type_alpha2(part_spark, 1, 0);
part_type_life(part_spark, 10, 25);
part_type_speed(part_spark, 0.5, 1.5, 0, 0);
part_type_direction(part_spark, 0, 360, 0, 0);

// Controle
effect_active = false;
shake = 0;

frame = 0;

audio_master_gain(1);
musica_atual = -1;

global.inimigo_atacando = noone;

global.ghost = 0;
global.tutorial = false;
global.ghost = 0;

creditos = false;

global.save = Room1;