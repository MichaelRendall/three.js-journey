attribute vec4 tangent;

#include ../includes/simplexNoise4d.glsl

float getWobble(vec3 position) {
    return simplexNoise4d(vec4(position, // XYZ
    0.0 // W
    ));
}

void main() {
    vec3 bitangent = cross(normal, tangent.xyz);

    // Neighbours positions
    float shift = 0.01;
    vec3 positionA = csm_Position + tangent.xyz * shift;
    vec3 positionB = csm_Position + bitangent * shift;

    // Wobbble
    float wobble = getWobble(csm_Position);
    csm_Position += wobble * normal;
    positionA += getWobble(positionA) * normal;
    positionB += getWobble(positionB) * normal;

    // Compute nornmal
    vec3 toA = normalize(positionA - csm_Position);
    vec3 toB = normalize(positionB - csm_Position);
    csm_Normal = cross(toA, toB);
}