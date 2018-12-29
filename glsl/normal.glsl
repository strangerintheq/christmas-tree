
// estimate normal at point

const float NORMAL_EPSILON = 0.0005;

float map(vec3 p){
    return scene(p).x;
}

vec3 estimateNormal(vec3 p) {
    return normalize(vec3(
        map(vec3(p.x + NORMAL_EPSILON, p.y, p.z)) - map(vec3(p.x - NORMAL_EPSILON, p.y, p.z)),
        map(vec3(p.x, p.y + NORMAL_EPSILON, p.z)) - map(vec3(p.x, p.y - NORMAL_EPSILON, p.z)),
        map(vec3(p.x, p.y, p.z + NORMAL_EPSILON)) - map(vec3(p.x, p.y, p.z - NORMAL_EPSILON))
    ));
}
