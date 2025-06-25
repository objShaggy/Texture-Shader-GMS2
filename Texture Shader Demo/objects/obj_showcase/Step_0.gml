show_index += (-keyboard_check_pressed(vk_up) + keyboard_check_pressed(vk_down));
show_index = clamp(show_index, 0, 2);

var show_titlemap = ["FG, BG and Mask", "FG Only", "BG Only"];
showing_title = show_titlemap[show_index];

with (circle_mask)
{
    update();
    
    motion_index += (-keyboard_check_pressed(vk_left) + keyboard_check_pressed(vk_right))
    motion_index = clamp(motion_index, 0, array_length(motions) - 1);
    
    movement_func = motions[motion_index]
    movement_func();
    
    if (keyboard_check_pressed(vk_space))
    { 
        anim_speed = (is_circle) ? -0.4 : 0.4;
        is_circle = !is_circle;
    }
    
    if ( (floor(frame) == sprite_get_number(sprite) - 1 && is_circle) || (floor(frame) == 0 && !is_circle))
        anim_speed = 0;
}

with (background)
{
    x += xspeed;
    y += yspeed;
    
    if (--randomize_xspeed_cooldown <= 0)
    {
        xspeed += irandom_range(-8, 8);
        xspeed = clamp(xspeed, -5, 5);
        
        randomize_xspeed_cooldown = irandom_range(60, 180);
    }
    
    if (--random_yoffset_cooldown <= 0)
    {
        y += irandom_range(-54, 153);
        
        yspeed = (random_range(0.2, 1.4) * irandom_range(-1, 1)) * (irandom_range(0, 100) <= 20);
        random_yoffset_cooldown = irandom_range(30, 270);
    }
    
    if (--random_scale_cooldown <= 0)
    {
        scale = random_range(0.75, 1.25);
        random_scale_cooldown = irandom_range(120, 380)
    }
}
