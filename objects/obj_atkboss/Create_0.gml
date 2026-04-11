life = 20;

image_speed = 1;

var dir = sign(image_xscale);

if (instance_exists(other)) {
	dir = sign(other.image_xscale);
}

x = x; // já nasce no lugar certo (NÃO precisa recalcular)

// dano
damage = global.dano;

// controle
hit = false;

// dono (quem criou)
owner = other; // MUITO importante