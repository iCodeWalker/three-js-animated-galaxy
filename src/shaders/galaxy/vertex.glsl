// retrieving size uniform here
uniform float uSize;

// retrieving aScale attribute 
attribute float aScale;

void main() {
    vec4 modelPosition = modelMatrix * vec4(position, 1.0);
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

}