#include ./libs/2d;

precision highp float;

uniform mat4 modelMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform vec3 cameraPosition;

uniform float size;
uniform float time;
uniform float ang;
uniform vec3 move;

attribute vec3 position;
attribute vec3 info;
attribute vec3 color;

varying vec3 vColor;

float map(float value, float beforeMin, float beforeMax, float afterMin, float afterMax) {
  return afterMin + (afterMax - afterMin) * ((value - beforeMin) / (beforeMax - beforeMin));
}

vec3 rotate(vec3 p, float angle, vec3 axis){
    vec3 a = normalize(axis);
    float s = sin(angle);
    float c = cos(angle);
    float r = 1.0 - c;
    mat3 m = mat3(
        a.x * a.x * r + c,
        a.y * a.x * r + a.z * s,
        a.z * a.x * r - a.y * s,
        a.x * a.y * r - a.z * s,
        a.y * a.y * r + c,
        a.z * a.y * r + a.x * s,
        a.x * a.z * r + a.y * s,
        a.y * a.z * r - a.x * s,
        a.z * a.z * r + c
    );
    return m * p;
}

void main(){


  vec3 p = position;
  // p = rotate(p, ang * info.y * 0.01, vec3(1.0, 0.0, 0.0));

  vec2 t = (position.xy + time * 0.0) * 0.005;
  float n1 = snoise(t) * 300.0;
  // // float n2 = snoise(position.yy * 0.01 +time info.x) * 10.0;
  // p.x += (n1) * move.x;
  // p.y += abs(n1) * move.y;
  p.z += (n1) * move.x;

  p = rotate(p, (move.x * 0.2) * info.y * 0.01, vec3(0.0, 0.0, 1.0));

  vec4 mvPosition = modelViewMatrix * vec4(p, 1.0);

  gl_Position = projectionMatrix * mvPosition;
  gl_PointSize = size;

  vColor = color;
}
