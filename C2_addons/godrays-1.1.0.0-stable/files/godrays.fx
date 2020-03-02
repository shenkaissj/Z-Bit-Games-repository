precision mediump float;

uniform lowp float decay;
uniform lowp float exposure;
uniform lowp float density;
uniform lowp float weight;
uniform lowp float light0X;
uniform lowp float light0Y;
uniform lowp float spread;

/////////////////////////////////////////////////////////
// GodRays

//The current foreground texture co-ordinate
varying mediump vec2 vTex;
//The foreground texture sampler, to be sampled at vTex
uniform lowp sampler2D samplerFront;
//The background texture sampler used for background - blending effects
uniform lowp sampler2D samplerBack;
//The current background rectangle being rendered to, in texture co-ordinates, for background-blending effects
uniform mediump vec2 destStart;
uniform mediump vec2 destEnd;

#define NUM_SAMPLES 100

void main()
{
    vec2 tc = vTex;

    vec2 deltaTexCoord = tc - vec2(light0X, 1.0-light0Y);
    deltaTexCoord *= 1.0 / float(NUM_SAMPLES) * density;
    
    float illuminationDecay = 1.0;
    vec4 color =texture2D(samplerFront, vTex)*0.4;
    for(int i=0; i < NUM_SAMPLES ; i++)
    {
       tc -= deltaTexCoord*spread;
       tc = clamp(tc,0.0,1.0);
       vec4 sample = texture2D(samplerFront, tc)*0.4;
       sample *= illuminationDecay * weight;
       color += sample;
       illuminationDecay *= decay;
    }
    vec4 realColor = texture2D(samplerBack, mix(destStart, destEnd, vTex));
    // gl_FragColor = color + realColor;
    /// This will "smooth" the rays and render more realistic
    gl_FragColor = ((vec4((vec3(color.r, color.g, color.b) * exposure), 1)) + (realColor*(1.1)));
}