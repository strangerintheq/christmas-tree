
// christmas tree
// by stranger in the q
// at 2018-dec-29

uniform vec2 resolution;
uniform vec3 eye;

#pragma import glsl/sdf.glsl
#pragma import glsl/scene.glsl

#pragma import glsl/rayDirection.glsl
#pragma import glsl/viewMatrix.glsl
#pragma import glsl/castRay.glsl
#pragma import glsl/normal.glsl
#pragma import glsl/phong.glsl
#pragma import glsl/softShadow.glsl


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
        color *= softShadow( pt, vec3(-0.4, 0.7, -0.6), 0.02, 2.5 );
        gl_FragColor = vec4(color, 1.0);
    }
}