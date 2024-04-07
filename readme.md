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

11. Handling Color :

    1. To retrieve color attribute we need to access it in vertex shader.
       attribute vec3 color;

12. Animate :

    1. Create a uTime uniform in uniforms.
    2. Update the uTime in the tick function.
    3. Retrieve it in the vertex shader.
    4. As our galaxy looks flat, we can rotate the vertices only on the x and z.

       1. We calculate the particle angle and its distance to the center.
       2. We increase that angle according to the 'uTime' and the distance.
       3. We update the position according to the new angle.

       4. Retrieve angle using atan(...) function. atan => arc tangent.
          float angle = atan(modelPosition.x, modelPosition.y);
       5. Retrieve the distance using length(..)
          float distanceToCenter = length(modelPosition.xz);
       6. Calculate offset angle : according to the time and distance how much the particle should spin.
          float angleOffset = (1.0 / distanceToCenter)*uTime*0.2;

13. Fix Randomness of particle :

    1. Remove the randomness from the 'position' attribute, save it in a new attribute named aRandomness, apply it after rotating the stars in the vertex shader.
