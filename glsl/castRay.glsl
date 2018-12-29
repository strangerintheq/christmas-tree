
//

vec2 castRay( in vec3 ro, in vec3 rd ) {

    float tmin = 1.0;
    float tmax = 20.0;
    float t = tmin;
    float m = -1.0;

    for ( int i=0; i<64; i++ ) {
	    float precis = 0.0004*t;
	    vec2 res = scene( ro+rd*t );
        if ( res.x<precis || t>tmax )
            break;
        t += res.x;
	    m = res.y;
    }

    if ( t>tmax )
        m=-1.0;

    return vec2( t, m );
}