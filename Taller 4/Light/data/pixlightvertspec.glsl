uniform mat4 modelview;
uniform mat4 transform;
uniform mat3 normalMatrix;
uniform vec4 lightPosition;

attribute vec4 position;
attribute vec4 color;
attribute vec3 normal;

varying vec4 vertColor;

void main() {
  gl_Position = transform * position;    
  vec3 ecPosition1 = vec3(modelview * position);
  vec3 ecPosition2 = vec3(modelview * -position);
  vec3 ecNormal = normalize(normalMatrix * normal);
  
  vec3 lightDirection1 = normalize(lightPosition.xyz - ecPosition1);
  vec3 lightDirection2 = normalize(lightPosition.xyz - ecPosition2);
  vec3 cameraDirection = normalize(0 - ecPosition2);
  vec3 lightDirectionReflected1 = reflect(-lightDirection1, ecNormal);
  vec3 lightDirectionReflected2 = reflect(-lightDirection2, ecNormal);
  float intensitySpec = pow(max(0.0, dot(lightDirectionReflected1, cameraDirection)), 8);
  vec4 vertColorSpec = vec4(intensitySpec, intensitySpec, intensitySpec, 1); 

  float ambientStrength = 0.1;
  vec4 vertColorAmb = vec4(ambientStrength, ambientStrength, ambientStrength, 1);

  vec3 direction = normalize(lightPosition.xyz - ecPosition1);    
  float intensityDif = max(0.0, dot(direction, ecNormal));
  vec4 vertColorDif = vec4(intensityDif, intensityDif, intensityDif, 1); 

  vertColor = (vertColorSpec) * color ;
}
