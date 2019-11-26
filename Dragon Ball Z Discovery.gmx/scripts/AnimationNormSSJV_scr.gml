if super = 1 {
    // Animations
    if (!place_meeting(x + sign(hsp), y - 3, barrier_obj)) {
        if (sign(hsp) > 0){
            sprite_index = SPR_Vegeta_WSSJ;
            image_speed = 0.25;
            image_xscale = 1;
            punched = 0;
        }
        else if (sign(hsp) < 0){
            sprite_index = SPR_Vegeta_WSSJ;
            image_speed = 0.25;
            image_xscale = -1;
            punched = 0;
        }
        if ((sign(hsp)) = 0) and (punched = 0) and (grounded = true) and (charging = 0)  {sprite_index = SPR_Goku_ISSJ;}
    }
    
    if (!place_meeting(x, y + 3, barrier_obj)) {
        if (sign(vsp) > 0) and (vanim = true){
            sprite_index = SPR_Goku_JPSSJ;
            image_speed = 0;
            image_index = 1;
        } 
        else if (sign(vsp < 0)) and (vanim = true){
            sprite_index = SPR_Goku_JPSSJ;
            image_speed = 0;
            image_index = 0;
        }
        else if (sign(vsp < 0)) or (sign(vsp > 0)) and (vanim = false){
            sprite_index = SPR_Goku_PunchSSJ;
            image_speed = 0;
        }
    }
}
