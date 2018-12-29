
// christmas tree
// by stranger in the q
// at 2018-dec-29

#pragma import glsl/sdf.glsl

vec2 scene(vec3 pos) {
    vec2 res = opU( vec2( sdPlane(     pos, -1.), .900 ),
                    vec2( sdSphere(    pos-vec3( 0.0, 0.25, 0.0), 0.25 ), 0.090 ) );
    res = opU( res, vec2( sdBox(       pos-vec3( 1.0, 0.25, 0.0), vec3(0.25) ), 0.009) );
    res = opU( res, vec2( sdRoundBox(  pos-vec3( 1.0, 0.25, 1.0), vec3(0.15), 0.1 ), 0.711 ) );

    return res;
}

#pragma import glsl/rayDirection.glsl
#pragma import glsl/viewMatrix.glsl
#pragma import glsl/castRay.glsl
#pragma import glsl/normal.glsl
#pragma import glsl/phong.glsl

uniform vec2 resolution;
uniform vec3 eye;

void main(void) {
	vec3 direction = rayDirection(60.0, resolution);
    mat4 viewToWorld = viewMatrix(eye, vec3(0.0, 0.0, 0.0), vec3(0.0, 1.0, 0.0));
    vec3 worldDir = (viewToWorld * vec4(direction, 0.0)).xyz;
    vec2 dist = castRay(eye, worldDir);
    if (dist.x > 20.) {
        gl_FragColor = vec4(0.1, 0.4, 0.1, 1.0);
    } else {
        vec3 pt = eye + dist.x * worldDir;
        vec3 color = phong(pt, eye, dist.y);
        gl_FragColor = vec4(color, 1.0);
    }
}