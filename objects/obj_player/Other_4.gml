global.tsu = 3;
vida = 5;
// direita → vai pra esquerda
if (x > 920) {
    x = 110;
} 
// esquerda → vai pra direita
else if (x < 380) {
    x = 1260;
} 
// meio → usa porta do meio
else {
    var door = instance_find(obj_doorM, 0);

    if (door != noone) {
        x = door.x;
        y = door.y;
    }
}