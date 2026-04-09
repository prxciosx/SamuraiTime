#region TIME STOP

var parado = global.ts;

if (parado) {
    image_speed = 0;
} else {
    image_speed = 1;
}

#endregion


#region DANO (SEMPRE FUNCIONA)

// verifica ataque do player
var atk = instance_place(x, y, obj_atk);

if (atk != noone) {
    vida -= global.dano;
}

#endregion


#region MOVIMENTO

// só trava movimento, não o resto
if (!parado) {

    var hspd = spd * dir;

    // colisão com parede
    if (place_meeting(x + hspd, y, obj_block) or place_meeting(x + hspd, y, obj_invisibleblock)) {
        dir *= -1;
        hspd = spd * dir;
    }

    image_xscale = dir;

    // ataque
    if (place_meeting(x + 50 * dir, y, obj_player)) {

        var knockback_dir = sign(x - obj_player.x);
        x += knockback_dir * 5;

        if (atk_cooldown <= 0) {
            var atki = instance_create_depth(x + 50 * dir, y - 50, depth - 1, obj_atkinm);
            atki.image_xscale = dir;
            atk_cooldown = 30;
        }

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

    x += hspd;

    if (atk_cooldown > 0) atk_cooldown--;

}
#region DANO DO PLAYER

// verifica se o player acertou o inimigo
// usa área do inimigo para garantir colisão mesmo com ataques rápidos
var atk = collision_rectangle(
    bbox_left, bbox_top,
    bbox_right, bbox_bottom,
    obj_atk, false, true
);

if (atk != noone) {
    vida -= global.dano;
}


if (vida <= 0) {
	global.inm += 1;
    instance_destroy();
}
#endregion