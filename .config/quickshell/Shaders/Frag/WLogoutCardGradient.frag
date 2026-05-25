#version 440

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;

    vec4 colorTop;
    vec4 colorBottom;
    float angle;
    float hovered;
};

layout(binding = 1) uniform sampler2D source;

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

void main() {
    vec2 uv = qt_TexCoord0;

    vec2 uvDeriv = fwidth(uv);
    vec2 edgeDist = min(uv, 1.0 - uv);
    vec2 pixelDist = edgeDist / uvDeriv;

    float edgeSmoothing = clamp(min(pixelDist.x, pixelDist.y), 0.0, 1.0);

    vec4 textureColor = texture(source, uv);

    vec2 axis = vec2(cos(angle), sin(angle));
    float t = dot(uv - vec2(0.5), axis) + 0.5;
    t = clamp(t, 0.0, 1.0);

    vec4 base = mix(colorTop, colorBottom, t);

    vec4 finalColor = base + vec4(vec3(hovered * 0.08), 0.0);

    float finalAlpha = textureColor.a * edgeSmoothing * qt_Opacity;

    fragColor = finalColor * finalAlpha;
}
