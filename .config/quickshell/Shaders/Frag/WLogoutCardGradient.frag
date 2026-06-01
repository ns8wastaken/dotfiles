#version 440

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;

    vec4 colorTop;
    vec4 colorBottom;
    float angle;
    float hovered;

    vec2 cardSize;
    float cornerRadius;
};

layout(binding = 1) uniform sampler2D source;

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

float sdRoundedBox(vec2 p, vec2 b, float r) {
    vec2 q = abs(p) - b + vec2(r);
    return min(max(q.x, q.y), 0.0) + length(max(q, 0.0)) - r;
}

void main() {
    vec2 uv = qt_TexCoord0;

    vec2 p = (uv - vec2(0.5)) * cardSize;
    vec2 halfSize = cardSize * 0.5;

    float distanceToEdge = sdRoundedBox(p, halfSize, cornerRadius);

    float pixSize = fwidth(distanceToEdge);
    float edgeSmoothing = 1.0 - smoothstep(-pixSize, 0.0, distanceToEdge);

    float distInside = abs(min(distanceToEdge, 0.0));
    float glowWidth = 12.0; // Width of the glass highlight in pixels

    float rimLight = 1.0 - clamp(distInside / glowWidth, 0.0, 1.0);
    rimLight = pow(rimLight, 3.0); // Sharpen the curve for a glass look

    vec2 axis = vec2(cos(angle), sin(angle));
    float t = dot(uv - vec2(0.5), axis) + 0.5;
    t = clamp(t, 0.0, 1.0);

    vec4 base = mix(colorTop, colorBottom, t);
    vec4 finalColor = base + vec4(vec3(hovered * 0.08), 0.0);

    float rimIntensity = 0.35 + (hovered * 0.15);
    finalColor.rgb += vec3(rimLight * rimIntensity);

    vec4 textureColor = texture(source, uv);

    float finalAlpha = textureColor.a * edgeSmoothing * qt_Opacity;

    fragColor = finalColor * finalAlpha;
}
