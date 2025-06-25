global.shd_texture_handles = {
    sprite_scroll: shader_get_uniform(shd_texture, "u_vScroll"),
    sprite_zoom: shader_get_uniform(shd_texture, "u_vZoom"),
    
    mask_sampler: shader_get_sampler_index(shd_texture, "u_sMask"),
    mask_position: shader_get_uniform(shd_texture, "u_vMaskPos"),
    mask_scale: shader_get_uniform(shd_texture, "u_vMaskScale"),
    mask_alpha: shader_get_uniform(shd_texture, "u_fMaskAlpha"),
    mask_inverse: shader_get_uniform(shd_texture, "u_bMaskInverse"),
    mask_show: shader_get_uniform(shd_texture, "u_bShowMask")
}