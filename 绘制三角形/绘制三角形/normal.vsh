attribute vec4 vPosition;
attribute vec4 color;
varying vec4 fragColor;
void main() {
    fragColor = color;
    gl_Position = vPosition;
}
