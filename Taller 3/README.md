# Taller raster

## Propósito

Comprender algunos aspectos fundamentales del paradigma de rasterización.

## Tareas

Emplee coordenadas baricéntricas para:

1. Rasterizar un triángulo.
2. Sombrear su superficie a partir de los colores de sus vértices.
3. (opcional para grupos menores de dos) Implementar un [algoritmo de anti-aliasing](https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-practical-implementation) para sus aristas.

Referencias:

* [The barycentric conspiracy](https://fgiesen.wordpress.com/2013/02/06/the-barycentric-conspirac/)
* [Rasterization stage](https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-stage)

Implemente la función ```triangleRaster()``` del sketch adjunto para tal efecto, requiere la librería [nub](https://github.com/nakednous/nub/releases).

## Integrantes

|   Integrante   | github nick |
|----------------|-------------|
| Federico Gómez |  federgolo  |
| Jonathan Campo |  joacampora |

## Discusión

Para rasterizar los tirángulos se emplearon dos funciones: ```boolean inside(...)``` y ```float edgeFunction(...)``` cuya implementación estuvo inspirada en la lecturas propuestas con la formulación de este taller.

La estrategia de rasterización consiste en recorrer el canvas "pixel por pixel" usando los valores _low_ y _high_, y determinando en cada punto si este hace parte del interior del triángulo usando la función inside, que a su vez llega a esta conclusión por medio de **coordenadas baricéntricas**.

Después de determinar que un punto hace parte del triángulo, se aplica ```float edgeFunction(...)``` para determinar la distancia del punto a los vértices del triángulo y dependiendo de estas "cercanías" se le asigan valores RGB para colorearlos, de modo que el pixel más cercano al vértice v1 va a tener una tonalidad predominante roja, el pixel más cercano a v2 una tonalidad predominante verde y el más cercano a v3 una tonalidad predominante azul. Esto a su vez, creará un efecro de degradé en el interior del triángulo.

* Antialiasing: 

Si bien no se alcanzó a implementar un algoritmo de antialiasing, se consultaron diferentes fuentes al respecto, y se desea resaltar el [artículo del profesor Gabriel Mañana](https://revistas.unal.edu.co/index.php/ingeinv/article/view/20815/21733) en la materia publicado en el año 1993, en la edición de la revista de Ingeniería e Investigación de la Universidad Nacional en la que se conmemoran los 15 años del programa de Ingeniería de Sistemas en nuestra alma mater.


## Entrega

* Plazo: 4/6/19 a las 24h.
