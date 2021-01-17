attribute vec4 vPosition;
attribute vec4 color;
varying vec4 fragColor;
uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrix;
void main() {
    fragColor = color;
    gl_Position = projectionMatrix * modelViewMatrix * vPosition;
}
