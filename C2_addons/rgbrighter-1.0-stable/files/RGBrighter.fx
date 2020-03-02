/////////////////////////////////////////////////////////
// RGBrighter effect
varying mediump vec2 vTex;
uniform lowp sampler2D samplerFront;
uniform lowp float red;
uniform lowp float green;
uniform lowp float blue;

void main(void)
{
	lowp vec4 front = texture2D(samplerFront, vTex);
	lowp float a = texture2D(samplerFront, vTex).a;
	
	gl_FragColor = front + vec4(vec3(red/255.0, green/255.0, blue/255.0) * a, 0);
}
