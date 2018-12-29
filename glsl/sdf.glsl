
// https://www.iquilezles.org/www/articles/distfunctions/distfunctions.htm


// distance functions
float dot2( in vec2 v ) {
    return dot(v,v);
}
float sdCappedCone( in vec3 p, in float h, in float r1, in float r2 ){
    vec2 q = vec2( length(p.xz), p.y );
    vec2 k1 = vec2(r2,h);
    vec2 k2 = vec2(r2-r1,2.0*h);
    vec2 ca = vec2(q.x-min(q.x,(q.y < 0.0)?r1:r2), abs(q.y)-h);
    vec2 cb = q - k1 + k2*clamp( dot(k1-q,k2)/dot2(k2), 0.0, 1.0 );
    float s = (cb.x < 0.0 && ca.y < 0.0) ? -1.0 : 1.0;
    return s*sqrt( min(dot2(ca),dot2(cb)) );
}

// vertical
float sdCylinder( vec3 p, vec2 h ){
  vec2 d = abs(vec2(length(p.xz),p.y)) - h;
  return min(max(d.x,d.y),0.0) + length(max(d,0.0));
}

float sdSphere( vec3 p, float s ){
    return length(p)-s;
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

float opSmoothU( float d1, float d2, float k ) {
    float h = clamp( 0.5 + 0.5*(d2-d1)/k, 0.0, 1.0 );
    return mix( d2, d1, h ) - k*h*(1.0-h);
}
