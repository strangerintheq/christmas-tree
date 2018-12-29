
const vec3 K_a = vec3(0.3, 0.2, 0.2);
const vec3 K_d = vec3(0.2, 0.4, 0.7);
const vec3 K_s = vec3(1.0, 1.0, 1.0);

const float shininess = 10.0;

const vec3 light1Pos = vec3(-20.0, -20.0, -20.0);
const vec3 light1Intensity = vec3(0.4, 0.4, 0.4);

const vec3 light2Pos = vec3(20.0, 20.0, 20.0);
const vec3 light2Intensity = vec3(0.4, 0.4, 0.4);

/**
 * Lighting contribution of a single point light source via Phong illumination.
 *
 * The vec3 returned is the RGB color of the light's contribution.
 *
 * k_a: Ambient color
 * k_d: Diffuse color
 * k_s: Specular color
 * alpha: Shininess coefficient
 * p: position of point being lit
 * eye: the position of the camera
 * lightPos: the position of the light
 * lightIntensity: color/intensity of the light
 *
 * See https://en.wikipedia.org/wiki/Phong_reflection_model#Description
 */
vec3 phongContribForLight(vec3 k_d, vec3 k_s, float alpha, vec3 p, vec3 eye,
                          vec3 lightPos, vec3 lightIntensity) {

    vec3 N = estimateNormal(p);
    vec3 L = normalize(lightPos - p);
    vec3 V = normalize(eye - p);
    vec3 R = normalize(reflect(-L, N));

    float dotLN = dot(L, N);
    float dotRV = dot(R, V);


    if (dotLN < 0.0) {
        // Light not visible from this point on the surface
        return vec3(0.0, 0.0, 0.0);
    }

    if (dotRV < 0.0) {
        // Light reflection in opposite direction as viewer, apply only diffuse
        // component
        return lightIntensity * (k_d * dotLN);
    }

    return lightIntensity * (k_d * dotLN + k_s * pow(dotRV, alpha));
}

/**
 * Lighting via Phong illumination.
 *
 * The vec3 returned is the RGB color of that point after lighting is applied.
 * k_a: Ambient color
 * k_d: Diffuse color
 * k_s: Specular color
 * alpha: Shininess coefficient
 * p: position of point being lit
 * eye: the position of the camera
 *
 * See https://en.wikipedia.org/wiki/Phong_reflection_model#Description
 */
vec3 phongIllumination(vec3 k_a, vec3 k_d, vec3 k_s, float alpha, vec3 p, vec3 eye, vec3 materialColor) {

    vec3 color = materialColor * k_a;
    color += phongContribForLight(k_d, k_s, alpha, p, eye, light1Pos, light1Intensity);
    color += phongContribForLight(k_d, k_s, alpha, p, eye, light2Pos, light2Intensity);

    return color;
}


vec3 decodeMaterialColor(float material) {

    float r = material * 10.;
    r = r - fract(r);
    r = r/10.;

    float g = material * 100. - r * 100.;
    g = g - fract(g);
    g = g/10.;

    float b = material * 1000. - r * 1000. - g * 100.;
    b = b - fract(b);
    b = b/10.;

    return vec3(r, g, b);
}

vec3 phong(vec3 p, vec3 eye, float material) {

    vec3 materialColor = decodeMaterialColor(material);
    return phongIllumination(K_a, K_d, K_s, shininess, p, eye, materialColor);
}
