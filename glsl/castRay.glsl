
// ro - ray origin
// rd - ray direction

vec2 castRay( in vec3 ro, in vec3 rd ) {

    float tmin = 0.2;
    float tmax = 44.0;
    float t = tmin;
    float m = -1.0;

    for ( int i=0; i<128; i++ ) {
	    float precis = 0.0001*t;
	    vec2 res = map( ro+rd*t );
        if ( res.x<precis || t>tmax )
            break;
        t += res.x;
	    m = res.y;
    }

    if ( t>tmax )
        m=-1.0;

    return vec2( t, m );
}