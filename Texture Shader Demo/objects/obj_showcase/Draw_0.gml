shader_set(shd_texture);

if (show_index != 1)
{
    with (background)
    {
        set_texture_shader_info(sprite, 0, x, y, scale, scale)
        draw_sprite(sprite, 0, 0, 0);
    }
}

if (show_index != 2)
{
    var mask = (show_index == 1) ? new Mask(spr_null, 0, 0) : circle_mask;

    set_texture_shader_info(sprite_index, image_index, 0, 0, 1, 1, mask);
    draw_self();
}

shader_reset();

draw_set_font(fnt_default);

draw_set_valign(fa_top)
draw_text(10, 10, "Masking Motion: " + circle_mask.title + "\nLeft and right arrow keys to change\nSpace to change shape");

draw_set_valign(fa_bottom)
draw_text(10, room_height - 10, "Down and up arrow keys to change\nShowing: " + showing_title)
