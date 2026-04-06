image_index = 0;
image_speed = 0;

// movimento
hspd = 0;
vspd = 0;

spd = 3;
grv = 0.3;
jspd = -8;

// estados
tp = false;
ataque = false;
stun = false;

// pulo / dash
jump = 8;
dash_available = 1;
dash_power = 80;
dash_dir = 1;

// combate
vida = 5;
vida_max=5;
attack_cooldown = 0;
attack_delay = 15;

state = "idle";
state_old = "idle";