
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
#pragma import glsl/ao.glsl

void main(void) {
	vec3 direction = rayDirection(60.0, resolution);
    mat4 viewToWorld = viewMatrix(eye, vec3(0.0, 0.0, 0.0), vec3(0.0, 1.0, 0.0));
    vec3 worldDir = (viewToWorld * vec4(direction, 0.0)).xyz;
    vec2 dist = castRay(eye, worldDir);
    if (dist.x > 20.) {
        gl_FragColor = vec4(0.9, 0.9, 0.9, 1.0);
    } else {
        vec3 pt = eye + dist.x * worldDir;
        vec3 nor = estimateNormal( pt );
        float occ = ao( pt, nor );
        vec3 color = phong(pt, eye, dist.y)*occ;
        color += color * softShadow( pt, vec3(-0.14, 0.7, -1.6), 0.01, 2.2)*0.7;
        gl_FragColor = vec4(color, 1.0);
    }
}