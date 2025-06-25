/// @function draw_sprite_repeated(sprite, subimg, x, y, x_repeat, y_repeat)
/// @description With this function you can repeatedly draw a sprite on both axis a specified amount of times.
/// @parameter {Asset.GMSprite} sprite The index of the sprite to repeat.
/// @parameter {real} subimg The sub-image (frame) of the sprite to draw.
/// @parameter {real} x The X coordinate of where to start repeating the sprite.
/// @parameter {real} y The Y coordinate of where to start repeating the sprite.
/// @parameter {real} x_repeat How many times to repeat the sprite on the X axis.
/// @parameter {real} y_repeat How many times to repeat the sprite on the Y axis.
function draw_sprite_repeated(sprite, subimg, x, y, x_repeat, y_repeat)
{
    for (var i = 0; i < x_repeat; i++)
    {
        for (var j = 0; j < y_repeat; j++)
        {
            var width = sprite_get_width(sprite);
            var height = sprite_get_height(sprite)
            
            var x_offset = (width * i);
            var y_offset = (height * j);
            
            
            if (y_repeat - j < 1 || x_repeat - i < 1)
            {
                var percent_x = x_repeat - i;
                var percent_y = y_repeat - j;
                
                var x_origin = sprite_get_xoffset(sprite);
                var y_origin = sprite_get_yoffset(sprite);
                
                draw_sprite_part(sprite, subimg, 0, 0, width * percent_x, height * percent_y, x + x_offset + x_origin, y + y_offset + y_origin);
            }
            else
                draw_sprite(sprite, subimg, x + x_offset, y + y_offset)
        }
    }
}

/// @function draw_sprite_repeated(sprite, subimg, x, y, x_repeat, y_repeat)
/// @description With this function you can repeatedly draw a sprite on both axis a specified amount of times.
/// @parameter {Asset.GMSprite} sprite The index of the sprite to repeat.
/// @parameter {real} subimg The sub-image (frame) of the sprite to draw.
/// @parameter {real} x The X coordinate of where to start repeating the sprite.
/// @parameter {real} y The Y coordinate of where to start repeating the sprite.
/// @parameter {real} x_repeat How many times to repeat the sprite on the X axis.
/// @parameter {real} y_repeat How many times to repeat the sprite on the Y axis.
/// @parameter {real} xscale The horizontal scaling of the sprite, as a multiplier.
/// @parameter {real} yscale The vertical scaling of the sprite, as a multiplier.
/// @parameter {Constant.Color} colour The colour with which to blend the sprite.
/// @parameter {real} alpha The alpha of the sprite.
function draw_sprite_repeated_ext(sprite, subimg, x, y, x_repeat, y_repeat, xscale, yscale, colour, alpha)
{
    for (var i = 0; i < x_repeat; i++)
    {
        for (var j = 0; j < y_repeat; j++)
        {
            var width = sprite_get_width(sprite);
            var height = sprite_get_height(sprite)
            
            var x_offset = (width * i);
            var y_offset = (height * j);
            
            
            if (y_repeat - j < 1 || x_repeat - i < 1)
            {
                var percent_x = x_repeat - i;
                var percent_y = y_repeat - j;
                
                var x_origin = sprite_get_xoffset(sprite);
                var y_origin = sprite_get_yoffset(sprite);
                
                draw_sprite_part_ext(sprite, subimg, 0, 0, width * percent_x, height * percent_y, x + x_offset + x_origin, y + y_offset + y_origin, xscale, yscale, colour, alpha);
            }
            else
                draw_sprite_ext(sprite, subimg, x + x_offset, y + y_offset, xscale, yscale, 0, colour, alpha)
        }
    }
}