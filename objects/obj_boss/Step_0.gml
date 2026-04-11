#region TIME STOP (boss ignora slow)
var ts = 1;

if (global.time_scale != undefined) {
    ts = global.time_scale;
}

if (global.ts){
	image_speed = 0;
	image_index = 0;
	exit;
}
#endregion

#region FOLLOW PLAYER
var p = instance_nearest(x, y, obj_player);

if (p != noone) {
    dir = sign(p.x - x); // IMPORTANTE: sem var
    hsp += dir * 0.1;
}
#endregion

#region MOVIMENTO + FÍSICA

// GRAVIDADE
if (!place_meeting(x, y + 1, obj_block)) {
    vsp += grav;
} else {
    vsp = 0;
}

// COLISÃO HORIZONTAL
if (place_meeting(x + hsp, y, obj_block)) {
    while (!place_meeting(x + sign(hsp), y, obj_block)) {
        x += sign(hsp);
    }
    hsp = 0;
}

x += hsp;

// DIREÇÃO DO SPRITE
image_xscale = dir;

// COLISÃO VERTICAL
if (place_meeting(x, y + vsp, obj_block)) {
    while (!place_meeting(x, y + sign(vsp), obj_block)) {
        y += sign(vsp);
    }
    vsp = 0;
}

y += vsp;

#endregion

#region ATAQUE

var player_na_frente = (p != noone && sign(p.x - x) == dir);
var dist = (p != noone) ? point_distance(x, y, p.x, p.y) : 9999;

if (player_na_frente && dist < 200) {

    if (atk_cooldown <= 0) {

        show_debug_message("ATAQUE CRIADO"); // DEBUG

        var atki = instance_create_depth(x + 60 * dir, y - 32, depth - 1, obj_atkboss);
        atki.image_xscale = dir;

        atk_cooldown = 30;
    }

    // animação
    if (sprite_index != spr_bossatk) {
        sprite_index = spr_bossatk;
        image_index = 0;
    }

    image_speed = 0.3;

} else {

    if (sprite_index != spr_boss) {
        sprite_index = spr_boss;
        image_index = 0;
    }

    image_speed = 1;
}

// cooldown
if (atk_cooldown > 0) atk_cooldown--;

#endregion

#region DANO (com cooldown)

if (hit_cooldown > 0) hit_cooldown--;

var atk = instance_place(x, y, obj_atk);

if (atk != noone && hit_cooldown <= 0) {
    vida -= global.dano;
    hit_cooldown = 10;
}

#endregion

#region MORTE
if (vida <= 0) {
    instance_destroy();
}
#endregion

#region PODER (SLOW GLOBAL)

tempo_poder++;

if (tempo_poder >= cooldown_poder && !slow_ativo) {
    tempo_poder = 0;
    slow_ativo = true;

    global.time_scale = 0.3;

    global.kc_ativo = true;
    global.kc_timer = global.kc_duracao;

    global.shake = 10;

    alarm[0] = room_speed * 2;
}

#endregion