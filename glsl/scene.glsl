
vec2 mapGround(vec3 pos){
    return vec2( sdPlane( pos, -1.7), .900 );
}

vec2 mapTree(vec3 pos) {

    float d = 1e11;
    float k = .1;
    d = opSmoothU(d, sdCappedCone(  pos - vec3(.0,.9,.0),  1.0, 0.45, .0), k);
    d = opSmoothU(d, sdCappedCone(  pos - vec3(.0,.5,.0),  1.0, 0.55, .0), k);
    d = opSmoothU(d, sdCappedCone(  pos - vec3(.0,.1,.0),  1.0, 0.65, .0), k);
    return vec2( d, 0.711 );
}

vec2 map(vec3 pos) {
    vec2 res = vec2(1e10, -1);

//    res = opU( res, mapGround(pos) );
    res = opU( res, mapTree(pos) );
    return res;
}