//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;   // The texture coordinates

void main()
{
    vec4 color = texture2D(gm_BaseTexture, v_vTexcoord);
    
    // If the pixel is white, turn it black.
    if(color.r == 1.0 && color.g == 1.0 && color.b == 1.0)
    {
        gl_FragColor = vec4(0.0, 0.0, 0.0, color.a);  // Set to black with original alpha
    }
    else
    {
        gl_FragColor = color;  // Retain the original color
    }
}