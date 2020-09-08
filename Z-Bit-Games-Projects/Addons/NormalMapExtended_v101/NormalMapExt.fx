// Effect made by Donelwero and Edited by Matriax, based on: https://github.com/mattdesl/lwjgl-basics/wiki/ShaderLesson6

// Matriax: Passed all the variables to adjust in C2 , how the light X/Y is applied to set down the point desired and allowing to use normal maps with alpha channels.



// Note: if possible don't use 'precision highp float'!  This will
// unnecessarily reduce performance on mobile devices.  Prefer to
// always specify an appropriate precision level.  As a guide, use:
// lowp - for color and alpha values returned by samplers
// mediump - for texture co-ordinates
// highp - only where increased precision is necessary to calculate the correct value

// The current texture co-ordinates (required).  Note these are normalised to [0, 1] float range, so
// (1, 1) is always the bottom right corner and (0.5, 0.5) is always the middle.


// The sampler to retrieve pixels from the foreground texture (required)


// Optional: for sampling the background.  Uncomment all three if background
// sampling is required, and set 'blends-background' to 'true' in the XML file.


// Optional parameters.  Uncomment any lines and they will automatically
// receive the correct values from the runtime.  Be sure not to accidentally
// uncomment any parameters you do not really need - doing so can reduce performance.
// uniform mediump float pixelWidth;			// width of a pixel in texture co-ordinates
// uniform mediump float pixelHeight;		// height of a pixel in texture co-ordinates
// uniform mediump float layerScale;			// scale of the current layer
// uniform mediump float seconds;			// number of seconds elapsed since start of game

// Add any custom parameters below as uniform floats, e.g.
// uniform mediump float exampleParam;
// where 'exampleParam' is specified as the 'uniform' for a parameter
// in the XML file.
precision highp float;

// Dynamic Light
varying mediump vec2 vTex;
uniform lowp sampler2D samplerFront;
uniform lowp sampler2D samplerBack;
uniform mediump vec2 destStart;
uniform mediump vec2 destEnd;

// Light 1
uniform float posX;
uniform float posY;
uniform float posZ;
uniform float colorR;
uniform float colorG;
uniform float colorB;
uniform float lightLum;
uniform float ambientR;
uniform float ambientG;
uniform float ambientB;
uniform float ambientLum;
uniform float falloffV1;
uniform float falloffV2;
uniform float falloffV3;

// Light 2
uniform float posXb;
uniform float posYb;
uniform float posZb;
uniform float colorRb;
uniform float colorGb;
uniform float colorBb;
uniform float lightLumb;
uniform float ambientRb;
uniform float ambientGb;
uniform float ambientBb;
uniform float ambientLumb;
uniform float falloffV1b;
uniform float falloffV2b;
uniform float falloffV3b;

// Light 3
uniform float posXc;
uniform float posYc;
uniform float posZc;
uniform float colorRc;
uniform float colorGc;
uniform float colorBc;
uniform float lightLumc;
uniform float ambientRc;
uniform float ambientGc;
uniform float ambientBc;
uniform float ambientLumc;
uniform float falloffV1c;
uniform float falloffV2c;
uniform float falloffV3c;

// Resolution
uniform float windowX;
uniform float windowY;
vec2 Resolution;

// Trying the SpotLights 
uniform float coneAngle; // new
vec3 coneDirection; // new
// Seems this have a lot of variables and needs too much changes to add :S, still i leave this here to try it another time.


// Used to detect if the light is enabled or disabled
uniform float light2v;
uniform float light3v;





// Light 1 Constants
vec3 LightPos; 
vec4 LightColor = vec4(colorR,colorG,colorB,lightLum); 
vec4 AmbientColor = vec4(ambientR,ambientG,ambientB,ambientLum); 
vec3 Falloff = vec3(falloffV1,falloffV2,falloffV3);

// Light 2 Constants
vec3 LightPosB; 
vec4 LightColorB = vec4(colorRb,colorGb,colorBb,lightLumb); 
vec4 AmbientColorB = vec4(ambientRb,ambientGb,ambientBb,ambientLumb); 
vec3 FalloffB = vec3(falloffV1b,falloffV2b,falloffV3b);

/*
vec4 LightColorB = (vec4(colorRb,colorGb,colorBb,lightLumb))*light2v; 
vec4 AmbientColorB = (vec4(ambientRb,ambientGb,ambientBb,ambientLumb))*light2v; 
vec3 FalloffB = (vec3(falloffV1b,falloffV2b,falloffV3b))*light2v;

vec4 LightColorB = vec4(colorRb,colorGb,colorBb,lightLumb); 
vec4 AmbientColorB = vec4(ambientRb,ambientGb,ambientBb,ambientLumb); 
vec3 FalloffB = vec3(falloffV1b,falloffV2b,falloffV3b);

*/


// Light 3 Constants
vec3 LightPosC; 
vec4 LightColorC = vec4(colorRc,colorGc,colorBc,lightLumc); 
vec4 AmbientColorC = vec4(ambientRc,ambientGc,ambientBc,ambientLumc); 
vec3 FalloffC = vec3(falloffV1c,falloffV2c,falloffV3c);

/*
vec4 LightColorC = (vec4(colorRc,colorGc,colorBc,lightLumc))*light3v; 
vec4 AmbientColorC = (vec4(ambientRc,ambientGc,ambientBc,ambientLumc))*light3v; 
vec3 FalloffC = (vec3(falloffV1c,falloffV2c,falloffV3c))*light3v;

vec4 LightColorC = vec4(colorRc,colorGc,colorBc,lightLumc); 
vec4 AmbientColorC = vec4(ambientRc,ambientGc,ambientBc,ambientLumc); 
vec3 FalloffC = vec3(falloffV1c,falloffV2c,falloffV3c);
*/

// The light2v/light3v multiplier is to enable/disable from C2 using 0=Off 1= ON


void main(void)
{

	// Retrieve front and back pixels
	lowp vec4 front = texture2D(samplerFront, vTex);
	lowp vec4 back = texture2D(samplerBack, mix(destStart, destEnd, vTex));

	lowp vec4 DiffuseColor  = texture2D(samplerBack, mix(destStart, destEnd, vTex));
  mediump vec3 NormalMap  = texture2D(samplerFront, vTex).rgb;
  
  lowp vec4 DiffuseColorB  = texture2D(samplerBack, mix(destStart, destEnd, vTex));
  mediump vec3 NormalMapB  = texture2D(samplerFront, vTex).rgb;

  lowp vec4 DiffuseColorC  = texture2D(samplerBack, mix(destStart, destEnd, vTex));
  mediump vec3 NormalMapC  = texture2D(samplerFront, vTex).rgb;


vec3 Sum = vec3(0.0);
	
	/*
vec3 Sum = vec3(0.0);
for (... each light ...) {
    ... calculate light using our illumination model ...
    Sum += FinalColor;
}
gl_FragColor = vec4(Sum, DiffuseColor.a);
*/

	
// (int i = 0; i < 5; i++)
//LightPos; LightPosB; int i = 2; 
//
//


// *************************************************************************************************************
// Start - LIGHT 1 *********************************************************************************************
// *************************************************************************************************************


for (int i = 0; i < 1; i++) 
{

	//Delta position of Light
	LightPos.x = posX;
	LightPos.y = posY;
	LightPos.y = 1.0 - LightPos.y;
	LightPos.z = posZ;
	Resolution.x = windowX;
	Resolution.y = windowY;
	vec3 LightDir = vec3(LightPos.xy - (gl_FragCoord.xy / Resolution.xy), LightPos.z);
  
	//Correct for aspect ratio
	LightDir.x *= Resolution.x / Resolution.y;

	//Determine distance (used for attenuation) BEFORE we normalize our LightDir
	float D = length(LightDir);
	
	//normalize our vectors
	vec3 N = normalize(NormalMap * 2.0 - 1.0);
	vec3 L = normalize(LightDir);

	//Pre-multiply light color with intensity
	//Then perform "N dot L" to determine our diffuse term
	vec3 Diffuse = (LightColor.rgb * LightColor.a) * max(dot(N, L), 0.0);

	//pre-multiply ambient color with intensity
	vec3 Ambient = AmbientColor.rgb * AmbientColor.a;
	
	//calculate attenuation
	float Attenuation = 1.0 / ( Falloff.x + (Falloff.y*D) + (Falloff.z*D*D) );
	vec4 colors = vec4(1.0,1.0,1.0,1.0);
	
	//the calculation which brings it all together
	vec3 Intensity = Ambient + Diffuse * Attenuation;
	vec3 FinalColor = DiffuseColor.rgb * Intensity;
	gl_FragColor =  (colors * vec4(FinalColor, DiffuseColor.a) * front.a );

  Sum += FinalColor;
  
}







// *************************************************************************************************************
// Start - LIGHT 2 *********************************************************************************************
// *************************************************************************************************************





for (int i = 0; i < 1; i++) 
{
	
	//Delta position of Light
	LightPosB.x = posXb;
	LightPosB.y = posYb;
	LightPosB.y = 1.0 - LightPosB.y;
	LightPosB.z = posZb;
	Resolution.x = windowX;
	Resolution.y = windowY;
	vec3 LightDirB = vec3(LightPosB.xy - (gl_FragCoord.xy / Resolution.xy), LightPosB.z);

  	//Correct for aspect ratio
	LightDirB.x *= Resolution.x / Resolution.y;

	//Determine distance (used for attenuation) BEFORE we normalize our LightDir
	float D = length(LightDirB);
	
	//normalize our vectors
	vec3 N = normalize(NormalMapB * 2.0 - 1.0);
	vec3 L = normalize(LightDirB);

	//Pre-multiply light color with intensity
	//Then perform "N dot L" to determine our diffuse term
	vec3 DiffuseB = (LightColorB.rgb * LightColorB.a) * max(dot(N, L), 0.0);

	//pre-multiply ambient color with intensity
	vec3 AmbientB = AmbientColorB.rgb * AmbientColorB.a;
	
	//calculate attenuation
	float AttenuationB = 1.0 / ( FalloffB.x + (FalloffB.y*D) + (FalloffB.z*D*D) );
	vec4 colorsB = vec4(1.0,1.0,1.0,1.0);
	
	//the calculation which brings it all together
	vec3 IntensityB = AmbientB + DiffuseB * AttenuationB;
	vec3 FinalColorB = DiffuseColorB.rgb * IntensityB;
	gl_FragColor =  (colorsB * vec4(FinalColorB, DiffuseColorB.a) * front.a );

  Sum += FinalColorB * light2v;
  
}





// *************************************************************************************************************
// Start - LIGHT 3 *********************************************************************************************
// *************************************************************************************************************


for (int i = 0; i < 1; i++) 
{
	
	//Delta position of Light
	LightPosC.x = posXc;
	LightPosC.y = posYc;
	LightPosC.y = 1.0 - LightPosC.y;
	LightPosC.z = posZc;
	Resolution.x = windowX;
	Resolution.y = windowY;
	vec3 LightDirC = vec3(LightPosC.xy - (gl_FragCoord.xy / Resolution.xy), LightPosC.z);

  	//Correct for aspect ratio
	LightDirC.x *= Resolution.x / Resolution.y;


	//Determine distance (used for attenuation) BEFORE we normalize our LightDir
	float D = length(LightDirC);
	
	//normalize our vectors
	vec3 N = normalize(NormalMapC * 2.0 - 1.0);
	vec3 L = normalize(LightDirC);

	//Pre-multiply light color with intensity
	//Then perform "N dot L" to determine our diffuse term
	vec3 DiffuseC = (LightColorC.rgb * LightColorC.a) * max(dot(N, L), 0.0);

	//pre-multiply ambient color with intensity
	vec3 AmbientC = AmbientColorC.rgb * AmbientColorC.a;
	
	//calculate attenuation
	float AttenuationC = 1.0 / ( FalloffC.x + (FalloffC.y*D) + (FalloffC.z*D*D) );
	vec4 colorsC = vec4(1.0,1.0,1.0,1.0);
	
	
	//the calculation which brings it all together
	vec3 IntensityC = AmbientC + DiffuseC * AttenuationC;
	vec3 FinalColorC = DiffuseColorC.rgb * IntensityC;
	gl_FragColor =  (colorsC * vec4(FinalColorC, DiffuseColorC.a) * front.a );


  Sum += FinalColorC * light3v;
  
}








// *************************************************************************************************************
// RESERVED FOR EXPERIMENTS ************************************************************************************
// *************************************************************************************************************


// *************************************************************************************************************












// *************************************************************************************************************
// SHADER OUTPUT ***********************************************************************************************
// *************************************************************************************************************
	
	
	
	
	// Light1
	// gl_FragColor =  (colors * vec4(FinalColor, DiffuseColor.a) * front.a );
	
	//Multiple Lights
  gl_FragColor = (vec4(Sum, DiffuseColor.a)) * front.a;
	// "* front.a" at the end to use NormalMaps with alpha and avoid some glitches
	
	
	
}



