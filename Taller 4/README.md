# Taller de shaders

## Propósito

Estudiar los [patrones de diseño de shaders](http://visualcomputing.github.io/Shaders/#/4).

## Tarea

1. Hacer un _benchmark_ entre la implementación por software y la de shaders de varias máscaras de convolución aplicadas a imágenes y video.
2. Implementar un modelo de iluminación que combine luz ambiental con varias fuentes puntuales de luz especular y difusa. Tener presente _factores de atenuación_ para las fuentes de iluminación puntuales.
3. (grupos de dos o más) Implementar el [bump mapping](https://en.wikipedia.org/wiki/Bump_mapping).


## Integrantes

|   Integrante   | github nick |
|----------------|-------------|
| Federico Gómez |  federgolo  |
| Jonathan Campo |  joacampora |


## Informe

* Al momento de aplicar las máscaras, creamos varios archivos .glsl con diferentes matrices de convolución (representadas como una suma de productos entre los valores de la matriz y los componentes rgb del fragColor) este filtro se le aplica a la imagen en su totalidad, haciendo uso de un shader.
* Para la fusión de fuentes de luces se dividió la tarea entre fragmentShader y vertexShades para poder apreciar como varían, el punto desde el que se emite la luz es controlado con la posición de mouse y la "combinación de luces" es controlada con el click.

