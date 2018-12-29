// generic raymarch algorithm

const int MAX_MARCHING_STEPS = 256;
const float RAYMARCH_EPSILON = 5e-4;
const float start = 0.1;
const float end = 100.0;

vec2 trace(vec3 eye, vec3 marchingDirection) {
    float depth = start;
    vec2 dist = vec2(1e10, 0.);
    for (int i = 0; i < MAX_MARCHING_STEPS; i++) {
        vec3 ray = depth * marchingDirection;
        vec2 dist = scene(eye + ray);
        if (dist.x < RAYMARCH_EPSILON * length(ray)) {
			return dist;
        }
        depth += dist.x;
        if (depth >= end) {
            return dist;
        }
    }
    return dist;
}
