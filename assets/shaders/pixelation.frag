#version 460 core

precision highp float;

#include <flutter/runtime_effect.glsl>

uniform vec2 uResolution;
uniform vec2 uPixelSize;
uniform sampler2D uTexture;

out vec4 fragColor;

void main() {
    vec2 uv = FlutterFragCoord().xy / uResolution;
    vec2 uv2 = round(uv * uPixelSize) / uPixelSize;
    fragColor = texture(uTexture, uv2);
}