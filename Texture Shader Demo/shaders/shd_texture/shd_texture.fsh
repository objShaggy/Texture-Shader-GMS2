varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D u_sMask;

uniform vec2 u_vScroll;
uniform vec2 u_vZoom;
uniform vec2 u_vMaskPos;
uniform vec2 u_vMaskScale;

uniform float u_fMaskAlpha;

uniform bool u_bMaskInverse;
uniform bool u_bShowMask;

void main()
{
    vec2 v_Texcoord = v_vTexcoord;
    vec2 v_Maskcoord = (v_vTexcoord - u_vMaskPos) / u_vMaskScale;
    
    v_Texcoord.x += u_vScroll.x;
    v_Texcoord.y += u_vScroll.y;
    
    v_Texcoord /= u_vZoom;
    v_Texcoord = mod(v_Texcoord, 1.);

    vec4 v_FragColor = v_vColour * texture2D(gm_BaseTexture, v_Texcoord);
    vec4 v_MaskColor = v_vColour * texture2D(u_sMask, v_Maskcoord);
    
    v_MaskColor.a *= u_fMaskAlpha;
    if (u_bMaskInverse)
        v_MaskColor.a = 1. - v_MaskColor.a;
        
    v_FragColor.a -= v_MaskColor.a;

    if (u_bShowMask)   
        gl_FragColor = v_FragColor + v_MaskColor;
    else
        gl_FragColor = v_FragColor;    
}