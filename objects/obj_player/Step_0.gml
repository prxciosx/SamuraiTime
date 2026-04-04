#region INPUT
// pega input horizontal: D = 1, A = -1
var move = keyboard_check(ord("D")) - keyboard_check(ord("A"));
#endregion
#region TIME STOP (SEGURAR TECLA)

// se estiver segurando U → ativa tempo parado
if (keyboard_check(ord("U")) and (global.tsu > 0)) {
    tp = true;           // modo de mira / tempo parado
    global.ts = true;    // variável global (usada pelos inimigos)
	
} else {
    tp = false;
    global.ts = false;
}
// quando soltar u -> perde 1 carga de time stop
if (keyboard_check_released(ord("U"))){
	global.tsu-=1;
	}

#endregion
#region MOVIMENTO

if (!tp) { // se NÃO estiver no tempo parado

    // movimento horizontal normal
    hspd = move * spd;

    // aplica gravidade
    vspd += grv;

} else {

    // congela completamente o player no ar
    hspd = 0;
    vspd = 0;
}

#endregion
#region DIREÇÃO SPRITE

// vira o personagem conforme anda
if (move != 0 && !ataque) {
    image_xscale = move; // 1 = direita, -1 = esquerda
    dash_dir = move;     // salva direção pro dash
}

#endregion
#region COLISAO HORIZONTAL

// verifica colisão na horizontal
if (place_meeting(x + hspd, y, obj_block)) {

    // anda pixel por pixel até encostar na parede
    while (!place_meeting(x + sign(hspd), y, obj_block)) {
        x += sign(hspd);
    }

    hspd = 0;           // para movimento
    dash_available = 1; // reseta dash ao bater no chão/parede
}

// aplica movimento horizontal
x += hspd;

#endregion
#region PULO

// só pode pular se NÃO estiver com tempo parado
if (!tp && keyboard_check_pressed(vk_space) && jump > 0) {
    vspd = jspd; // força do pulo
    jump--;      // reduz quantidade de pulos
}

#endregion
#region COLISAO VERTICAL

// verifica colisão vertical
if (place_meeting(x, y + vspd, obj_block)) {

    // anda pixel por pixel até encostar no chão/teto
    while (!place_meeting(x, y + sign(vspd), obj_block)) {
        y += sign(vspd);
    }

    vspd = 0;     // para queda
    jump = 2;     // reseta pulo duplo
    dash_available = 1;
}

// aplica movimento vertical
y += vspd;

#endregion
#region DASH

// dash só funciona fora do tempo parado
if (!tp && keyboard_check_pressed(ord("Q")) && dash_available > 0) {
	if (!place_meeting(x+(dash_power * dash_dir),y,obj_block)){
    x += dash_power * dash_dir; // move rapidamente
    dash_available--;           // consome dash
	}
}

#endregion
#region ATAQUE NORMAL

// ataque comum (tecla Enter)
if (!tp && mouse_check_button(1) && !ataque) {
    ataque = true;
	
    // cria objeto de ataque
    var atk = instance_create_depth(x, y, depth - 1, obj_atk);

    // define direção do ataque
    atk.image_xscale = image_xscale;
}

#endregion
#region SLASH (TEMPO PARADO)

// só funciona se tempo estiver parado
if (tp && mouse_check_button_pressed(mb_left)) {

    // posição inicial (player)
    var x1 = x;
    var y1 = y;

    // posição do mouse
    var x2 = mouse_x;
    var y2 = mouse_y;

    // direção e distância
    var dir = point_direction(x1, y1, x2, y2);
    var dist = point_distance(x1, y1, x2, y2);

    // posição final válida (pra não atravessar parede)
    var final_x = x1;
    var final_y = y1;

    // percorre a linha do corte
    for (var i = 0; i < dist; i += 4) {

        var px = x1 + lengthdir_x(i, dir);
        var py = y1 + lengthdir_y(i, dir);

        // se bater em parede, para o corte
        if (place_meeting(px, py, obj_block)) {
            break;
        }

        // salva última posição válida
        final_x = px;
        final_y = py;

        // verifica inimigo
        var inimigo = instance_place(px, py, obj_ghost);

        if (inimigo != noone) {
            inimigo.vida = 0;
        }
		
    }


    // move o player até onde o corte chegou
    x = final_x;
    y = final_y;

    // desativa tempo parado
    tp = false;
	global.tsu -= 1;
    global.ts = false;
}
#endregion
#region DANO DO INIMIGO E STUN
if ((place_meeting(x,y, obj_inm) or place_meeting(x,y,obj_ghost)) and (!stun)){
	vida -= 1;
	stun = true;
	alarm[0] = 30;
	image_blend = c_red;
}
if (vida<=0){
	instance_destroy();
	room_goto(MenuI);
}
#endregion
#region RESET

// reinicia a sala
if (keyboard_check_pressed(ord("R"))) {
    room_restart();
}

#endregion