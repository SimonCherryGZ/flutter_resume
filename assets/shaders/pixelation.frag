#version 460 core

precision highp float;

#include <flutter/runtime_effect.glsl>

layout(location = 0) uniform vec2 uResolution;
layout(location = 1) uniform vec2 uPixelSize;
layout(location = 2) uniform sampler2D uTexture;

out vec4 fragColor;

void main() {
    vec2 uv = FlutterFragCoord().xy / uResolution;
    vec2 uv2 = round(uv * uPixelSize) / uPixelSize;
    fragColor = texture(uTexture, uv2);
}