/// @function set_texture_shader_info(sprite, x_scroll, y_scroll, mask)
/// @description This function sets important information for the texture shader.
/// @parameter {Asset.GMSprite|Id.Surface} sprite The sprite or surface the shader will be applied to.
/// @parameter {real} frame The frame of the sprite that the shader will be applied to.
/// @parameter {real} x_scroll The X scroll of the shader.
/// @parameter {real} y_scroll The Y scroll of the shader.
/// @parameter {real} x_scale The X scale of the shader.
/// @parameter {real} y_scale The Y scale of the shader.
/// @parameter {struct} mask A struct containing various information for the mask.
function set_texture_shader_info(sprite, frame, x_scroll, y_scroll, x_scale = 1, y_scale = 1, mask = new Mask(spr_null, 0, 0))
{
    if (x_scale == 0) { x_scale = 0.001 };
    if (y_scale == 0) { y_scale = 0.001 };
    
    var width, height, mask_width, mask_height, mask_texture;
    
    if (surface_exists(sprite))
    { 
        width = surface_get_width(sprite);
        height = surface_get_height(sprite);
    }
    else
    { 
        width = sprite_get_width(sprite);
        height = sprite_get_height(sprite);
    }
    
    if (surface_exists(mask.sprite))
    {
        mask_width = surface_get_width(mask.sprite);
        mask_height = surface_get_height(mask.sprite);
        
        mask_texture = surface_get_texture(mask.sprite);
    }
    else
    {    
        mask_width = sprite_get_width(mask.sprite);
        mask_height = sprite_get_height(mask.sprite);
        
        mask_texture = sprite_get_texture(mask.sprite, round(mask.frame));
    }
    
    var mask_xscale = (mask_width / width) * mask.x_scale;
    var mask_yscale = (mask_height / height) * mask.y_scale;
        
    if (mask_xscale == 0) { mask_xscale = 0.001 };
    if (mask_yscale == 0) { mask_yscale = 0.001 };
    
    var mask_xorigin = (sprite_get_xoffset(mask.sprite) * mask.x_scale) / width;
    var mask_yorigin = (sprite_get_yoffset(mask.sprite) * mask.y_scale) / height;
    
    var mask_x = (mask.x / width) - mask_xorigin;
    var mask_y = (mask.y / height) - mask_yorigin;

    shader_set_uniform_f(global.shd_texture_handles.sprite_scroll, x_scroll / width, y_scroll / height);
    shader_set_uniform_f(global.shd_texture_handles.sprite_zoom, x_scale, y_scale);
    
    shader_set_uniform_f(global.shd_texture_handles.mask_position, mask_x, mask_y);
    shader_set_uniform_f(global.shd_texture_handles.mask_scale, mask_xscale, mask_yscale);
    shader_set_uniform_f(global.shd_texture_handles.mask_alpha, mask.alpha);
    shader_set_uniform_f(global.shd_texture_handles.mask_inverse, mask.inverse);
    shader_set_uniform_f(global.shd_texture_handles.mask_show, mask.show);

    texture_set_stage(global.shd_texture_handles.mask_sampler, mask_texture);
}

/// @function generate_sprite(canvas_size, input, x_copy, y_copy, width_copy, height_copy, removeback, smooth, xorig, yorig)
/// @description This function lets you generate a texture using a temporary surface.
/// @parameter {array<real>} canvas_size The size of the temporary surfaces, index 0 is width, index 1 is height.
/// @parameter {function} input The code that your texture consists of.
/// @parameter {real} x_copy The x position to copy from.
/// @parameter {real} y_copy The y position to copy from.
/// @parameter {real} width_copy The width of the area to be copied (from the x position). If it's -1 it will use the canvas width instead.
/// @parameter {real} height_copy The height of the area to be copied (from the y position). If it's -1 it will use the canvas height instead.
/// @parameter {bool} removeback Indicates whether to make all pixels with the background colour (left-bottom pixel) transparent.
/// @parameter {bool} smooth Indicates whether to smooth the edges.
/// @parameter {real} xorig Indicates the x position of the origin in the sprite.
/// @parameter {real} yorig Indicates the y position of the origin in the sprite.
/// @returns {Asset.GMSprite}
/// @pure
function generate_sprite(canvas_size, input, x_copy = 0, y_copy = 0, width_copy = -1, height_copy = -1, removeback = true, smooth = false, xorig = 0, yorig = 0)
{
    var width = canvas_size[0];
    var height = canvas_size[1];
    
    if (width_copy == -1)
        width_copy = width;
    if (height_copy == -1)
        height_copy = height;
    
    var temporary_surface;
    temporary_surface = surface_create(width, height);
    
    surface_set_target(temporary_surface);
    draw_clear_alpha(c_black, 0);
    input();
    surface_reset_target();
    
    var sprite = sprite_create_from_surface(temporary_surface, x_copy, y_copy, width_copy, height_copy, removeback, smooth, xorig, yorig)
    
    surface_free(temporary_surface);
    return sprite;
}