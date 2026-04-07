#region TIME STOP (boss ignora slow)
var ts = 1;

if (global.time_scale != undefined) {
    ts = global.time_scale;
}
if (global.ts){
	exit;
}
#endregion
#region FOLLOW PLAYER
var p = instance_nearest(x, y, obj_player);

if (p != noone) {
    var dir = sign(p.x - x);
    hsp += dir * 0.1;
}
#endregion
#region MOVIMENTO + FÍSICA
// GRAVIDADE (só se não estiver no chão)
if (!place_meeting(x, y + 1, obj_block)) {
    vsp += grav;
} else {
    vsp = 0;
}

// MOVIMENTO HORIZONTAL
if (place_meeting(x + hsp, y, obj_block)) {
    while (!place_meeting(x + sign(hsp), y, obj_block)) {
        x += sign(hsp);
    }
    hsp = 0;
}
x += hsp;
image_xscale = dir;
// MOVIMENTO VERTICAL
if (place_meeting(x, y + vsp, obj_block)) {
    while (!place_meeting(x, y + sign(vsp), obj_block)) {
        y += sign(vsp);
    }
    vsp = 0;
}
y += vsp;
#endregion
#region DANO (com cooldown)

if (hit_cooldown > 0){hit_cooldown--;}

var atk = instance_place(x, y, obj_atk);

if (atk != noone && hit_cooldown <= 0) {
    vida -= global.dano;
    hit_cooldown = 10; // evita dano por frame
}

#endregion
#region MORTE

if (vida <= 0) {
    instance_destroy();
}

#endregion
#region PODER (SLOW GLOBAL)

// contador
tempo_poder++;

// ativa slow
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