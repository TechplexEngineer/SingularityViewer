/** 
 * @file softenLightF.glsl
 *
 * $LicenseInfo:firstyear=2007&license=viewerlgpl$
 * $/LicenseInfo$
 */
 


uniform vec2 screen_res;

VARYING vec4 vary_light;
VARYING vec2 vary_fragcoord;
void main()
{
	//transform vertex
	gl_Position = ftransform(); 
	
	vec4 pos = gl_ModelViewProjectionMatrix * gl_Vertex;
	vary_fragcoord = (pos.xy*0.5+0.5)*screen_res;
		
	vec4 tex = gl_MultiTexCoord0;
	tex.w = 1.0;
	
	vary_light = gl_MultiTexCoord0;
}
