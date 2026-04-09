#region TIME STOP

var parado = global.ts;

if (parado) {
    image_speed = 0;
} else {
    image_speed = 1;
}

#endregion


#region DANO (SEMPRE FUNCIONA)

var atk = instance_place(x, y, obj_atk);

if (atk != noone) {
    vida -= global.dano;
}

#endregion


#region MOVIMENTO

if (!parado) {

    // aceleração
    hsp = spd * dir;

    // vira na parede
    if (place_meeting(x + hsp, y, obj_block) || place_meeting(x + hsp, y, obj_invisibleblock)) {
        dir *= -1;
        hsp = spd * dir;
    }

    image_xscale = dir;


    #region ATAQUE

    if (place_meeting(x + 50 * dir, y, obj_player)) {

        var p = instance_place(x + 50 * dir, y, obj_player);

        if (p != noone) {

            var knockback_dir = sign(x - p.x);
            var knock = knockback_dir * 5;

            // 🔥 KNOCKBACK PROFISSIONAL (NUNCA ENTRA NA PAREDE)
            if (!place_meeting(x + knock, y, obj_block) 
            && !place_meeting(x + knock, y, obj_invisibleblock)) {

                x += knock;

            } else {

                while (!place_meeting(x + sign(knock), y, obj_block) 
                && !place_meeting(x + sign(knock), y, obj_invisibleblock)) {
                    x += sign(knock);
                }
            }
        }

        // ataque
        if (atk_cooldown <= 0) {
            var atki = instance_create_depth(x + 50 * dir, y - 50, depth - 1, obj_atkinm);
            atki.image_xscale = dir;
            atk_cooldown = 30;
        }

        // animação ataque
        if (sprite_index != spr_inmatk) {
            sprite_index = spr_inmatk;
            image_index = 0;
        }

        image_speed = 0.3;

    } else {

        // animação normal
        if (sprite_index != spr_inm) {
            sprite_index = spr_inm;
            image_index = 0;
        }

        image_speed = 1;
    }

    #endregion


    #region MOVIMENTO HORIZONTAL (COM COLISÃO REAL)

    if (place_meeting(x + hsp, y, obj_block) || place_meeting(x + hsp, y, obj_invisibleblock)) {

        while (!place_meeting(x + sign(hsp), y, obj_block) 
        && !place_meeting(x + sign(hsp), y, obj_invisibleblock)) {
            x += sign(hsp);
        }

        hsp = 0;
    }

    x += hsp;

    #endregion


    // cooldown
    if (atk_cooldown > 0) atk_cooldown--;

}

#endregion


#region DANO DO PLAYER (HITBOX MELHOR)

var atk = collision_rectangle(
    bbox_left, bbox_top,
    bbox_right, bbox_bottom,
    obj_atk, false, true
);

if (atk != noone) {
    vida -= global.dano;
}

#endregion


#region MORTE

if (vida <= 0) {
    global.inm += 1;
    instance_destroy();
}

#endregion