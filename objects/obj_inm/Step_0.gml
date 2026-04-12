#region TIME STOP

if (global.ts) {
    image_speed = 0;
    exit;
} else {
    image_speed = 1;
}

#endregion
#region VARIÁVEIS BASE

// garante que existem (evita bug)
if (!variable_instance_exists(id, "atk_cooldown")) atk_cooldown = 0;
if (!variable_instance_exists(id, "range_ataque")) range_ataque = irandom_range(60, 100);
if (!variable_instance_exists(id, "delay_reacao")) delay_reacao = irandom_range(0, 20);

#endregion
#region PLAYER

var p = instance_nearest(x, y, obj_player);
var dist = noone;

if (p != noone) {
    dist = point_distance(x, y, p.x, p.y);
}

#endregion
#region MOVIMENTO

var hsp = spd * dir;

// vira ao bater na parede
if (place_meeting(x + hsp, y, obj_block) || place_meeting(x + hsp, y, obj_invisibleblock)) {
    dir *= -1;
    hsp = spd * dir;
}

// aplica movimento com colisão real
if (place_meeting(x + hsp, y, obj_block) || place_meeting(x + hsp, y, obj_invisibleblock)) {

    while (!place_meeting(x + sign(hsp), y, obj_block) 
    && !place_meeting(x + sign(hsp), y, obj_invisibleblock)) {
        x += sign(hsp);
    }

    hsp = 0;
}

x += hsp;

// direção do sprite
image_xscale = dir;

#endregion
#region ATAQUE (INDEPENDENTE)

if (p != noone) {
    
    delay_reacao--;

    var na_frente = sign(p.x - x) == dir;
    var pode_atacar = (dist < range_ataque && na_frente);

    if (delay_reacao <= 0 && pode_atacar && atk_cooldown <= 0) {
    
    if (random(1) < 0.7) { // 70% chance de atacar
        
        var atki = instance_create_depth(x + 40 * dir, y - 50, depth - 1, obj_atkinm);
		audio_play_sound(sou_atackVFX, 2, false)
        atki.owner = id;
        atki.image_xscale = dir;

        p.vida -= 1;

        var knockback_dir = sign(p.x - x);
        p.x += knockback_dir * 5;

        atk_cooldown = irandom_range(25, 45);
    }

    delay_reacao = irandom_range(10, 25);
}
}

// cooldown decrementa sozinho
if (atk_cooldown > 0) atk_cooldown--;

#endregion
#region ANIMAÇÃO

if (p != noone && dist < range_ataque && atk_cooldown > 0) {

    if (sprite_index != spr_inmatk) {
        sprite_index = spr_inmatk;
        image_index = 0;
    }

    image_speed = 0.3;

} else {

    if (sprite_index != spr_inm) {
        sprite_index = spr_inm;
        image_index = 0;
    }

    image_speed = 1;
}

#endregion
#region DANO DO PLAYER

var atk_player = collision_rectangle(
    bbox_left, bbox_top,
    bbox_right, bbox_bottom,
    obj_atk, false, true
);

if (atk_player != noone) {
    vida -= global.dano;
}

#endregion
#region MORTE

if (vida <= 0) {
    global.inm += 1;
	if (global.tsu<3){
		global.tsu +=1;
	}
    instance_destroy();
}

#endregion