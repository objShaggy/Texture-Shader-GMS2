/// @function Mask(sprite_index, image_index, image_speed)
/// @description This constructor creates a new mask struct that can be passed into the function set_texture_shader_info().
/// @parameter {Asset.GMSprite|Id.Surface} sprite_index The sprite index or surface of the mask.
/// @parameter {real} image_index The starting image index (frame) of the mask.
/// @parameter {real|undefined} image_speed The animation speed of the mask, if this is not set, the mask will use the animation speed of the sprite it's using instead.
function Mask(sprite_index, image_index, image_speed) constructor
{
    sprite = sprite_index;
    frame = image_index;
    anim_speed = (is_undefined(image_speed)) ? sprite_get_speed(sprite) : image_speed;
    
    if (sprite_get_info(sprite).frame_type == spritespeed_framespersecond) 
        anim_speed /= game_get_speed(gamespeed_fps)
    
    x = 0;
    y = 0;
    
    x_scale = 1;
    y_scale = 1;
    
    alpha = 1;
    
    inverse = false;
    show = false;

    /// @function change_sprite(sprite_index, image_index, image_speed)
    /// @description This function lets you change the sprite of the mask as well as related info.
    /// @parameter {Asset.GMSprite} sprite_index The sprite index of the mask.
    /// @parameter {real} image_index The starting image index (frame) of the mask.
    /// @parameter {real|undefined} image_speed The animation speed of the mask, if this is not set, the mask will use the animation speed of the sprite it's using instead.
    static change_sprite = function(sprite_index, image_index, image_speed)
    {
        self.sprite = sprite_index;
        self.frame = image_index;
        
        self.anim_speed = (is_undefined(image_speed)) ? sprite_get_speed(sprite) : 0;
    }
    
    /// @function set_details(x_multiplier, y_multiplier, x_scale, y_scale, alpha, inverse)
    /// @description This function lets you set all of the other details about the mask that can be changed.
    /// @parameter {real} x The x position of the mask on the sprite it's applying to.
    /// @parameter {real} y The y position of the mask on the sprite it's applying to.
    /// @parameter {real} x_scale The x scale of the mask. (As a multiplier).
    /// @parameter {real} y_scale The y scale of the mask. (As a multiplier).
    /// @parameter {real} alpha The alpha of the mask, in other words how much it'll reduce the alpha of the sprite it's masking.
    /// @parameter {bool} inverse Whether or not to inverse the reduction for each pixel.
    static set_details = function(x, y, x_scale = 1, y_scale = 1, alpha = 1, inverse = false)
    {
        self.x = x;
        self.y = y;
        
        self.x_scale = x_scale;
        self.y_scale = y_scale;
        
        self.alpha = alpha;
    }
    
    /// @function update()
    /// @description This function will update specific parts about the mask.
    static update = function()
    {
        self.frame += self.anim_speed;
    }
}
