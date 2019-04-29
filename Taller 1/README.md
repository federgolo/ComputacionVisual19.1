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
* Para la conversión a escala de grises, inicialmente, se tomaron lor valores (r, g, b) de cada pixel en la imagen/video y se retornó un promedio entre los tres componentes para cada pixel, obteniendo así la tonalidad gris que representa cada tono en cada pixel. Despues se aplicaron diferentes fórmulas para obtener diferentes escalas.
* Al momento de aplicar las máscaras, creamos un arreglo con diferentes matrices de convolución, este filtro se le aplica a la imagen/video en un segmento o en su totalidad, haciendo recorrer la matriz sobre el canvas y aplicando la convolución sobre cada pixel.
* El histograma es obtenido, en el caaso de la imagen convertida a escala de grises, recorriendo el arreglo de pixeles y llevando la cuenta de cuantas veces se repite cada tono (entre 0 y 255), para depues poder graficar con que frecuencia aparece cada uno(el histograma).
* Ya teniendo el histograma, diseñamos un sistema de scroll para marcar un rango en el histograma, cuando este rango es cambiado, la imagen es segmentada: Muestra los pixeles cuyo tono se envcuentre dentro del rango seleccionado y los demás pixeles son "apagados".
