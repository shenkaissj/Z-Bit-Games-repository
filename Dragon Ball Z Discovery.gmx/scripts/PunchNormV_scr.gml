if super = 0 {
    // Punching
    if (punch_press) and (grounded = true) {
        punched = 1;
        airpunch = 0;
        alarm[1] = room_speed * 0.5;
        sprite_index = SPR_Vegeta_Punch;
        image_speed = 0;
        image_index = image_index + 1;
    }
    if (punched = 1) {
        hsp = 0;
    }
    if (punch_press) and (grounded = false) {
        airpunch = 1;
        punched = 0;
        alarm[1] = room_speed * 0.5;
        image_index = image_index + 1;
        vanim = false;
    }
}
