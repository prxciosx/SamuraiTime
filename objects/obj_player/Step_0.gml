#region INPUT
var move = keyboard_check(ord("D")) - keyboard_check(ord("A"));
#endregion
#region TIME STOP
var tp_old = tp;

if (keyboard_check(ord("U")) && global.tsu > 0) {
    tp = true;
    global.ts = true;
} else {
    tp = false;
    global.ts = false;
}
// saiu do time stop → zera velocidade (EVITA BUG NA PAREDE)
if (tp_old && !tp) {
    hspd = 0;
    vspd = 0;
}
#endregion
#region DIREÇÃO
if (move != 0 && !ataque) {
    image_xscale = move;
    dash_dir = move;
}
#endregion
#region TIME SCALE (AFETA VELOCIDADE, NÃO POSIÇÃO)
var ts = 1;
if (global.time_scale != undefined) {
    ts = global.time_scale;
}
#endregion
#region MOVIMENTO BASE
if (!tp) {
    hspd = move * spd;
    vspd += grv;
} else {
    hspd = 0;
    vspd = 0;
}
#endregion
#region VELOCIDADE FINAL (COM TIME SCALE)
var h_final = hspd * ts; // slow só no horizontal
var v_final = vspd;      // vertical NORMAL (sem slow)
#endregion
#region COLISÃO HORIZONTAL
if (place_meeting(x + h_final, y, obj_block)) {
    while (!place_meeting(x + sign(h_final), y, obj_block)) {
        x += sign(h_final);
    }
    h_final = 0;
}
x += h_final;
#endregion
#region PULO
if (!tp && keyboard_check_pressed(vk_space) && jump > 0) {
    vspd = jspd;
    jump--;
}
#endregion
#region COLISÃO VERTICAL
// só trava no chão se estiver caindo
if (vspd > 0 && place_meeting(x, y + vspd, obj_block)) {
    
    while (!place_meeting(x, y + 1, obj_block)) {
        y += 1;
    }

    vspd = 0;
    jump = 2;
    dash_available = 1;
}

// colisão no teto (subindo)
if (vspd < 0 && place_meeting(x, y + vspd, obj_block)) {

    while (!place_meeting(x, y - 1, obj_block)) {
        y -= 1;
    }

    vspd = 0;
}
y += vspd;
#endregion
#region DASH
if (!tp && keyboard_check_pressed(ord("Q")) && dash_available > 0) {
    if (!place_meeting(x + dash_power * dash_dir, y, obj_block)) {
        x += dash_power * dash_dir;
        dash_available--;
    }
}
#endregion
#region ATAQUE NORMAL
if (attack_cooldown > 0) attack_cooldown--;

if (!tp && mouse_check_button_pressed(mb_left) && attack_cooldown <= 0) {

    ataque = true;

    var atk = instance_create_depth(x * 16, y - 50, depth - 1, obj_atk);
    atk.image_xscale = image_xscale;

    attack_cooldown = attack_delay;
}
#endregion
#region SLASH (AFETA BOSS)
if (tp && mouse_check_button_pressed(mb_left)) {

    var x1 = x;
    var y1 = y - 64;

    var x2 = mouse_x;
    var y2 = mouse_y;

    var dir = point_direction(x1, y1, x2, y2);
    var dist = point_distance(x1, y1, x2, y2);

    var final_x = x1;
    var final_y = y1;

    for (var i = 0; i < dist; i += 4) {

        var px = x1 + lengthdir_x(i, dir);
        var py = y1 + lengthdir_y(i, dir);

        if (place_meeting(px, py, obj_block)) break;

        final_x = px;
        final_y = py;

        var inimigo = instance_place(px, py, obj_ghost);
        if (inimigo != noone) inimigo.vida = 0;

        var boss = instance_place(px, py, obj_boss);
        if (boss != noone) boss.vida -= global.dano * 2;
    }

    x = final_x;
    y = final_y;

    tp = false;
    global.ts = false;
    global.tsu -= 1;
}
#endregion
#region DANO + STUN
if ((place_meeting(x,y,obj_inm) || place_meeting(x,y,obj_ghost) || place_meeting(x,y,obj_boss)) && !stun) {
    vida -= 1;
    stun = true;
    alarm[0] = 30;
    image_blend = c_red;
}

if (vida <= 0) {
    room_goto(MenuI);
    instance_destroy();
}
#endregion
#region RESET
if (keyboard_check_pressed(ord("R"))) {
    room_restart();
}
#endregion
#region EFEITO KC
if (global.kc_ativo && irandom(2) == 0) {
    var ghost = instance_create_layer(x, y, "Instances", obj_playerghost);
    ghost.image_xscale = image_xscale;
    ghost.sprite_index = sprite_index;
    ghost.image_index = image_index;
}
#endregion
#region ANIMAÇÃO POR STATE

var no_chao = place_meeting(x, y+1, obj_block);

// DEFINE STATE
if (!no_chao || vspd != 0){
	state = "J";
} else {
	switch (move){
		case -1: state = "WL"; break;
		case 0: state = "Idle"; break;
		case 1: state = "WR"; break;
	}
}

// APLICA ANIMAÇÃO
switch (state){

	case "Idle":
		image_index = 0;
		image_speed = 0;
	break;

	case "WL":
		sprite_index = spr_playerWL;
		image_speed = 1;
	break;

	case "WR":
		sprite_index = spr_playerWR;
		image_speed = 1;
	break;

	case "J":
		image_speed=0;
		// mantém frame até realmente estabilizar
		if (!no_chao){
			image_index = 1; // subindo
		}else {
			image_index = 0; // caindo
		}
	break;
}

#endregion