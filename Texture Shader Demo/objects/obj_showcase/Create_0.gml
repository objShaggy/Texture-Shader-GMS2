circle_mask = new Mask(spr_animated_mask, 0, 0);

showing_title = "Foreground, Background and Mask";
show_index = 0;
hide_text = false;

with (circle_mask)
{
    clicked = false
    title = "Mouse Follow"
    
    sine_angle = 0;
    cosine_angle = 0;
    
    is_circle = false;
    
    xdir = 1;
    ydir = 1;
    
    movement_sine = function()
    {
        title = "Sine";
        
        sine_angle += 0.025;
        cosine_angle += 0.1;
        
        if (sine_angle > 360)
            sine_angle = 0;
        if (cosine_angle > 360)
            cosine_angle = 0;
        
        var room_half_width = (room_width / 2);
        var room_half_height = (room_height / 2);
        
        x = room_half_width + (room_half_width * sin(sine_angle));
        y = room_half_height + (room_half_height * cos(cosine_angle));
        
        x_scale = 1;
        y_scale = 1;
        alpha = 1;
        inverse = false;
    }
    
    movement_dvd = function()
    {
        title = "DVD";
        
        x += xdir * 10;
        y += ydir * 10;
        
        if (x < 0 || x > room_width)
            xdir *= -1;
        if (y < 0 || y > room_height)
            ydir *= -1;
        
        x_scale = 1;
        y_scale = 1;
        alpha = 1;
        inverse = false;
    }
    
    movement_fullcover = function()
    {
        title = "Full Cover"
        
        x_scale += 0.1;
        y_scale += 0.1;
        
        if (x_scale >= 5 && y_scale >= 5)
        {
            inverse = !inverse;
            
            x_scale = 0.1;
            y_scale = 0.1;
        }
        
        x = room_width / 2;
        y = room_height / 2;
        
        alpha = 1;
    }
    
    movement_flicker = function()
    {
        title = "Fade"
        
        x_scale = 1.5;
        y_scale = 1.5;
        
        sine_angle += 0.025; 
        if (sine_angle > 360)
            sine_angle = 0;
        
        alpha = abs(sin(sine_angle)) - 0.1;
        if (alpha <= 0)
        {
          x = irandom(room_width);
          y = irandom(room_height);
        }  
        
        inverse = false;
    }
    
    movement_mouse = function()
    { 
        title = "Mouse Controlled, try your mouse buttons!"
        
        x = mouse_x;
        y = mouse_y;
        
        if (mouse_check_button_pressed(mb_middle))
            inverse = !inverse;
       
        var scaling =  (mouse_wheel_up() - mouse_wheel_down()) / 10
        x_scale += scaling;
        y_scale += scaling;
        
        x_scale = clamp(x_scale, 0.1, 5);
        y_scale = clamp(y_scale, 0.1, 5);
        
        alpha += (mouse_check_button_pressed(mb_left) - mouse_check_button_pressed(mb_right)) / 10;
        alpha = clamp(alpha, 0, 1);
    }
    
    motions = [movement_sine, movement_dvd, movement_fullcover, movement_flicker, movement_mouse];
    motion_index = 0;
    movement_func = movement_sine;
}

background = {
    sprite: spr_background,
    
    x: 0,
    y: 0,
    
    xspeed: -3,
    yspeed: 0,
    
    scale: 1,
    
    randomize_xspeed_cooldown: irandom_range(60, 180),
    random_yoffset_cooldown: irandom_range(30, 270),
    random_scale_cooldown: irandom_range(120, 380)
}