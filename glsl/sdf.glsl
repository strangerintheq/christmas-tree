
// https://www.iquilezles.org/www/articles/distfunctions/distfunctions.htm


// distance functions

float sdSphere( vec3 p, float s ){
    return length(p)-s;
}

float sdBox( vec3 p, vec3 b ){
    vec3 d = abs(p) - b;
    return min(max(d.x,max(d.y,d.z)),0.0) + length(max(d,0.0));
}

float sdEllipsoid( in vec3 p, in vec3 r ) {
    float k0 = length(p/r);
    float k1 = length(p/(r*r));
    return k0*(k0-1.0)/k1;
}

float sdRoundBox( in vec3 p, in vec3 b, in float r ) {
    vec3 q = abs(p) - b;
    return min(max(q.x,max(q.y,q.z)),0.0) + length(max(q,0.0)) - r;
}

float sdTorus( vec3 p, vec2 t ){
    return length( vec2(length(p.xz)-t.x,p.y) )-t.y;
}

float sdPlane( vec3 p , float down){
	return p.y - down;
}


// distance functions operations

float opS( float d1, float d2 ){
    return max(-d2,d1);
}

vec2 opU( vec2 d1, vec2 d2 ){
	return (d1.x<d2.x) ? d1 : d2;
}

vec3 opRep( vec3 p, vec3 c ){
    return mod(p,c)-0.5*c;
}

vec3 opTwist( vec3 p ){
    float  c = cos(10.0*p.y+10.0);
    float  s = sin(10.0*p.y+10.0);
    mat2   m = mat2(c,-s,s,c);
    return vec3(m*p.xz,p.y);
}