# Taller de análisis de imágenes por software

## Propósito

Introducir el análisis de imágenes/video en el lenguaje de [Processing](https://processing.org/).

## Tareas

Implementar las siguientes operaciones de análisis para imágenes/video:

* Conversión a escala de grises.
* Aplicación de algunas [máscaras de convolución](https://en.wikipedia.org/wiki/Kernel_(image_processing)).
* (solo para imágenes) Despliegue del histograma.
* (solo para imágenes) Segmentación de la imagen a partir del histograma.
* (solo para video) Medición de la [eficiencia computacional](https://processing.org/reference/frameRate.html) para las operaciones realizadas.

Emplear dos [canvas](https://processing.org/reference/PGraphics.html), uno para desplegar la imagen/video original y el otro para el resultado del análisis.

## Integrantes

Complete la tabla:

|   Integrante   | github nick |
|----------------|-------------|
| Federico Gómez |  federgolo  |
| Jonathan Campo |  joacampora |

## Discusión
* Para la conversión a escala de grises, inicialmente, se tomaron lor valores (r, g, b) de cada pixel en la imagen/video y se calculó el promedio entre los tres componentes para cada pixel y se sobreescribió el color de los pixeles con dichos promedios, obteniendo así la escala de grises en todo el canvas. Después se complementó la actividad en canvas adicionales, mediante la aplicación de diferentes [fórmulas](https://en.wikipedia.org/wiki/Grayscale#Luma_coding_in_video_systems) para obtener diferentes escalas.
* Al momento de aplicar las máscaras, creamos un arreglo con diferentes matrices de convolución, este filtro se le aplica a la imagen/video en un segmento o en su totalidad, haciendo recorrer la matriz sobre el canvas y aplicando la convolución sobre cada pixel.
* El histograma es obtenido tomando el canvas de la imagen convertida a escala de grises (por el método de los promedios), recorriendo el arreglo de pixeles y llevando la cuenta de cuantas veces se repite cada tono (entre 0 y 255), para depués poder graficar con que frecuencia aparece cada uno en un canvas del mismo tamaño que la imagen, de modo que el valor más repetido se representa con la barra más alta, y esta es del mismo alto que la imagen.
* Ya teniendo el histograma, diseñamos un sistema de scroll para marcar un rango en el histograma, cuando este rango es cambiado, la imagen es segmentada: Muestra los pixeles cuyo tono se encuentre dentro del rango seleccionado, mientras que los demás pixeles permanecen "apagados".
* Finalmente, calculamos el framerate y por medio de los métodos de PGraphics, este es "dibujado" en cada frame del video. Debido a nuestra decisión de capturar el vídeo por medio de webcam, esta métrica oscila alrededor de los 14 cuadros por segundo, ya que de ser más alto, se refrescaría la imagen demasiado rápido y no se apreciarían de forma adecuada las transformaciones hehcas al video.
