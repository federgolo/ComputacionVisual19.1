# Taller de shaders

## Propósito

Estudiar los [patrones de diseño de shaders](http://visualcomputing.github.io/Shaders/#/4).

## Integrantes

|   Integrante   | github nick |
|----------------|-------------|
| Federico Gómez |  federgolo  |
| Jonathan Campo |  joacampora |


## Informe

* Al momento de aplicar las máscaras, creamos varios archivos .glsl con diferentes matrices de convolución (representadas como una suma de productos entre los valores de la matriz y los componentes rgb del fragColor) este filtro se le aplica a la imagen en su totalidad jaciendo uso de un shader.
* Para la fusión de funetes de luces se dividió entre fragmentShader y vertexShades para poder apreciar como varían, el punto desde el que se emite la luz es controlado con la posición de mouse y la "combinación de luces" es controlada con el click.

