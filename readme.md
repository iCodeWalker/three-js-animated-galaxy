# Animated galaxy

1.  Replaced "PointsMaterial" with "ShaderMaterial"
2.  add vertexShader property to "ShaderMaterial"
3.  add code to vertex shader:
    void main() {
    vec4 modelPosition = modelMatrix*vec4(position, 1.0);
    vec4 viewPosition = viewMatrix*modelPosition;
    vec4 projectionPosition = projectionMatrix\*viewPosition;

        gl_Position = projectionPosition;

        gl_PointSize = 2.0;

    }

4.  gl_PointSize = 2.0
    using this the particle size is 2x2 fragments size regardless of the distance of the camera

5.  add fragmentShader property to "ShaderMaterial"
    void main() {
    gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
    }

6.  According to Three.js the scale is a value related to the render height, To make things managable we can replace it with 1.0

    bool isPerspective = isPerspectiveMatrix(projectionMatrix);

    if(isPerspective) gl_PointSize\*= (scale / - mvPosition.z);

    mvPosition corresponds to the position of the vertex once the 'modelMatrix' and the 'viewMatrix' have been applied. In our case it 'viewPosition' variable

7.  Drawing particle pattern

    1. We are going to draw a pattern instead of the square particles.
    2. We cannot send the uv as a varying because each vertex is a particle, but we can use gl_PointCoord

8.  Making Disc Pattern :

    1. Get the distance between gl_PointCoord and the center.
    2. Apply a step function to get 0.0, if the distance is below 0.5, and 1.0 if the distance is above 0.5.
    3. Invert the value

9.  Diffuse Point Pattern :

    1. Get the distance between gl_PointCoord and the center.
    2. Multiply it by 2.0, so it reaches 1.0 before touching the edge.
    3. Invert the value.

10. Point Light Pattern :
    1. Get the distance between gl_PointCoord and the center.
    2. Invert the value.
    3. Apply a power on it with a high number.
