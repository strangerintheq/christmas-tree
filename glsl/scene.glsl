
vec2 rotate(vec2 p, float ang) {
    float c = cos(ang), s = sin(ang);
    return vec2(p.x*c - p.y*s, p.x*s + p.y*c);
}

vec2 repeatAng(vec2 p, float n) {
    float ang = 2.0*3.14/n;
    float sector = floor(atan(p.x, p.y)/ang + 0.5);
    p = rotate(p, sector*ang);
    return p;
}

vec2 star(vec3 p) {
    p.y -=1.5;
    p.xy = repeatAng(p.xy, 5.0);            // 3. Clone five cornders radially about Z axis
    p.xz = abs(p.xz);                       // 2. Symmetrical about XoY and ZoY
    vec3 n = vec3(0.5, 0.25, 0.8);
    float d = plane(p, normalize(n), 0.1);  // 1. A plane cutting the corner of X+Y+Z+
    return vec2(d, .900 );
}

///

vec2 ground(vec3 pos){
    float d = -0.99 ;
    d += noise(pos)*0.44;
    return vec2( sdPlane( pos, d), .999 );
}

///

vec2 tree(vec3 pos) {
    float d = 1e11;
    float k = .12;

    d = opSmoothU(d, sdCappedCone(  pos - vec3(.0, .99,.0), .4, 0.45, .0), k);
    d = opSmoothU(d, sdCappedCone(  pos - vec3(.0, .55,.0), .5, 0.55, .0), k);
    d = opSmoothU(d, sdCappedCone(  pos - vec3(.0, .11,.0), .6, 0.65, .0), k);

    return vec2( d, 0.090 );
}

///

vec2 trunk(vec3 pos) {
    float d = 1e11;
    d = sdCylinder(pos-vec3(.0, -.5,.0), vec2(0.1, 0.6));
    return vec2( d, 0.000 );
}

vec2 toy(vec3 pos, float col) {
    float d = 1e11;
    d = sdSphere(pos, 0.1);
    return vec2( d, col );
}

//

vec2 map(vec3 pos) {
    vec2 res = vec2(1e10, -1);

    res = opU( res, ground(pos) );
    res = opU( res, star(pos) );
    res = opU( res, tree(pos) );
    res = opU( res, trunk(pos) );

    float r = .42;
    float h = -0.57;
    res = opU( res, toy(pos-vec3(-r, h, -r), 0.990) );
    res = opU( res, toy(pos-vec3(-r, h,  r), 0.099) );
    res = opU( res, toy(pos-vec3( r, h, -r), 0.999) );
    res = opU( res, toy(pos-vec3( r, h,  r), 0.555) );

    r = .3;
    h = 0.5;
    res = opU( res, toy(pos-vec3(-r, h, -r), 0.990) );
    res = opU( res, toy(pos-vec3(-r, h,  r), 0.099) );
    res = opU( res, toy(pos-vec3( r, h, -r), 0.999) );
    res = opU( res, toy(pos-vec3( r, h,  r), 0.555) );

    r = .5;
    h = -0.05;
    res = opU( res, toy(pos-vec3(-r, h, 0.), 0.990) );
    res = opU( res, toy(pos-vec3( 0, h, -r), 0.099) );
    res = opU( res, toy(pos-vec3( r, h, 0.), 0.999) );
    res = opU( res, toy(pos-vec3( 0, h, r), 0.555) );
    return res;
}