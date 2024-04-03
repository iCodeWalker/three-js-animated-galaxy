    void main() {
        vec4 modelPosition = modelMatrix * vec4(position, 1.0);
        vec4 viewPosition = viewMatrix * modelPosition;
        vec4 projectionPosition = projectionMatrix * viewPosition;
    
        gl_Position = projectionPosition;
    
        gl_PointSize = 2.0;

        // The paarticle size is 2x2 fragments size regardless of the distance of the camera
    }