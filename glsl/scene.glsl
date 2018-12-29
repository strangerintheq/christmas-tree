
vec2 mapGround(vec3 pos){
    return vec2( sdPlane( pos, -.8 + sin(pos.x)*0.1 + cos(pos.z)*0.1), .999 );
}

vec2 mapTree(vec3 pos) {
    float d = 1e11;
    float k = .2;
    d = opSmoothU(d, sdCappedCone(  pos - vec3(.0, .99,.0), .4, 0.45, .0), k);
    d = opSmoothU(d, sdCappedCone(  pos - vec3(.0, .55,.0), .5, 0.55, .0), k);
    d = opSmoothU(d, sdCappedCone(  pos - vec3(.0, .11,.0), .6, 0.65, .0), k);
    return vec2( d, 0.090 );
}

vec2 mapTrunk(vec3 pos) {
    float d = 1e11;
    return vec2( d, 0.090 );
}

vec2 map(vec3 pos) {
    vec2 res = vec2(1e10, -1);
    res = opU( res, mapGround(pos) );
    res = opU( res, mapTree(pos) );
    res = opU( res, mapTrunk(pos) );
    return res;
}