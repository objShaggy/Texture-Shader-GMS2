# Usage
Here's an example how you would use the shader to apply scrolling, scaling and a mask to an object.
```gml
/// Create

texture = {
    x_scroll: 0,
    y_scroll: 0,
    
    x_scale: 0,
    y_scale: 0,
}

mask = new Mask(spr_animated_mask, 0, 0);
mask.set_details(room_width / 2, room_height / 2);

/// Step

with (texture)
{
    y_scroll += (-keyboard_check(vk_left) + keyboard_check(vk_right)) * 4;
    x_scroll += (-keyboard_check(vk_up) + keyboard_check(vk_down)) * 4;
    
    var zoom = (mouse_button_check_pressed(mb_left) - mouse_button_check_pressed(mb_right)) / 3;
    x_scale += zoom;
    y_scale += zoom;
}

/// Draw

shader_set(shd_texture);
set_texture_shader_info(sprite_index, image_index, texture.x_scroll, texture.y_scroll, texture.x_scale, texture.y_scale, mask);
draw_self();
shader_reset();
```

# Limitations
* For now, when masking, the sprite being masked and the mask will have to have **Seperate Texture Page** under **Texture Settings** enabled.
* The mask has to be a sprite, it can't be a shape like a rectangle or circle.
* Only one mask can be applied to a sprite at a time.