// retrieving size uniform here
uniform float uSize;

// retrieving aScale attribute 
attribute float aScale;
// retrieving color attribute 
// attribute vec3 color;

// Add vColor varying to send color to fragment shader
varying vec3 vColor; 

// retrieve uTime for animation
uniform float uTime;


void main() {
    vec4 modelPosition = modelMatrix * vec4(position, 1.0);

    // animating the galaxy
    // As the galaxy looks flat, we can rotate the vertices only on the x and z.
    // Retrieve angle of particle (Spin Angle)
       float angle = atan(modelPosition.x, modelPosition.y);
    // Retrieve particle distance from center 
        float distanceToCenter = length(modelPosition.xz);
    // Calculate the offset angle
        float angleOffset = (1.0 / distanceToCenter)*uTime*0.2;

        angle += angleOffset;

        modelPosition.x = cos(angle) * distanceToCenter;
        modelPosition.z = sin(angle) * distanceToCenter;

    vec4 viewPosition = viewMatrix * modelPosition;
    vec4 projectionPosition = projectionMatrix * viewPosition;
    
    gl_Position = projectionPosition;
    
    // gl_PointSize = 2.0;
    // The paarticle size is 2x2 fragments size regardless of the distance of the camera
    // gl_PointSize = uSize;

    // Multiply the uSize by aScale  to have random sizes of particles
    gl_PointSize = uSize * aScale;

    // For size attenuation
    gl_PointSize *= (1.0 / -viewPosition.z);

    // Assign color value to vColor
    vColor = color;

}