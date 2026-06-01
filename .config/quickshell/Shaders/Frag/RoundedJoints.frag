#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

#define RECT_COUNT 4

layout(std140, binding = 0) uniform buf {
    mat4  qt_Matrix;
    float qt_Opacity;

    vec4  shapeColor;
    vec2  resolution;
    float radius;
    float jointRadius;
    int   rectCount;

    // Flatten the array into distinct, individually named vec4 uniforms
    vec4 rect0;
    vec4 rect1;
    vec4 rect2;
    vec4 rect3;
};

// Polynomial smooth minimum.
float smin(float a, float b, float k) {
    float h = clamp(0.5 + 0.5 * (b - a) / k, 0.0, 1.0);
    return mix(b, a, h) - k * h * (1.0 - h);
}

// Signed distance field for a rounded rectangle.
float sdRoundedBox(vec2 p, vec2 b, float r) {
    vec2 d = abs(p) - b + vec2(r);
    return min(max(d.x, d.y), 0.0) + length(max(d, 0.0)) - r;
}

void main() {
    vec2 pixelPos = qt_TexCoord0 * resolution;
    float finalDistance = 1e5;

    // Create a local array inside main
    vec4 rects[RECT_COUNT];
    rects[0] = rect0;
    rects[1] = rect1;
    rects[2] = rect2;
    rects[3] = rect3;

    for (int i = 0; i < RECT_COUNT; i++) {
        if (i >= rectCount) break;

        vec2 center   = rects[i].xy;
        vec2 halfSize = rects[i].zw;

        vec2  localP = pixelPos - center;
        float dist   = sdRoundedBox(localP, halfSize, radius);

        if (i == 0) {
            finalDistance = dist;
        } else {
            finalDistance = smin(finalDistance, dist, jointRadius);
        }
    }

    // Screen-space derivative anti-aliasing
    float afwidth   = length(vec2(dFdx(finalDistance), dFdy(finalDistance))) * 0.70710678;
    float edgeAlpha = 1.0 - smoothstep(-afwidth, afwidth, finalDistance);

    fragColor = shapeColor * edgeAlpha * qt_Opacity;
}
