# Taller ilusiones visuales

## Propósito

Comprender algunos aspectos fundamentales de la [inferencia inconsciente](https://github.com/VisualComputing/Cognitive) de la percepción visual humana.

## Tareas

Implementar al menos 6 ilusiones de tres tipos distintos (paradójicas, geométricas, ambiguas, etc.), al menos dos con movimiento y dos con interactividad.

## Integrantes

|   Integrante   | github nick |
|----------------|-------------|
| Federico Gómez |  federgolo  |
| Jonathan Campo |  joacampora |

## Discusión

1. Complete la tabla

|   Ilusión                 | Categoria                 | Referencia                                            | Tipo de interactividad (si aplica) | URL código base (si aplica) |
|---------------------------|---------------------------|-------------------------------------------------------|------------------------------------|-----------------------------|
|     Stepping Feet         |         De movimiento     |   https://michaelbach.de/ot/mot-feetLin/index.html    |  MouseWheel(); MouseClicked();    |                             |
|     Moiré Patterns        |    Geométrico/Matemático  |   https://michaelbach.de/ot/lum-moire1/index.html     |       KeyPressed(ArrowKeys)       |                             |
|  Color Assimilation      |   Asimilación Ficticia    |   https://michaelbach.de/ot/col-assim/index.html      |     MousePosition();              |                             |
|     Oblique Lines         |  Geométrica/De distorsión |  https://michaelbach.de/ot/ang-SkyeGrating/index.html |           KeyPressed(s, c)                     |                             |
| Stereokinetic Effect (SKE)|  Percepción de profundiad por movimiento |      https://michaelbach.de/ot/mot-ske/index.html     |      KeyPressed(1-2)              |                             |
|       White Xmas          |     Percepción de Color   |   https://michaelbach.de/ot/col-whiteXmas/index.html  |        KeyPressed();              |                             |

2. Describa brevememente las referencias estudiadas y los posibles temas en los que le gustaría profundizar

### Stepping Feet:

Consiste en una serie de lineas verticales, con cierto grosor y distancia entre ellas, sobre las cuales se mueven dos rectángulos de colores(Amarillo y Azul) de forma horizontal.
La ilusión consiste en que, aunque ambas figuras se mueven al mismo tiempo y de manera continua, se percibe que una de las figuras se mueve más rápido que la otra o que en algunos puntos las figuras hacen pequeñas pausas. 
    
### Moiré Patterns:
Un patrón de muaré es un patrón de interferencia que se forma cuando se superponen dos rejillas de líneas, ya sean rectas o curvas, con un cierto ángulo o cuando tales rejillas tienen tamaños ligeramente diferentes. 

### Color assimilation:
Este fenómeno se conoce como "asimilación", ya que los colores de los cuadrados se vuelven similares a la [síntesis aditiva de color](https://es.wikipedia.org/wiki/S%C3%ADntesis_aditiva_de_color) de la rejilla que los cubre. Por eso, el cuadrado cubierto por las frnajas azules y rojas se ve magenta, etc.

### Oblique Lines:
Esta ilusión está inspirada en el trabajo de [Victoria Skye](http://www.victoriaskye.com/illusionart.html) una maga norteamericana que construye ilusiones ópticas y objetos imposibles. El efecto como tal, se debe a las pequeñas marcas ajedrezadas presentes en la intersección de colores. Esto data de aproximadamente 2002, cuando fue demostrado por [Akiyoshi Kitaoka](http://www.ritsumei.ac.jp/%7Eakitaoka/cushione.html)

### Stereokinetic Effect (SKE):
La rotación de las figuras correctas crea una ilusión tridimensional. Este efecto está relacionado con el más conocido [efecto de profundidad cinética](https://en.wikipedia.org/wiki/Kinetic_depth_effect) (Kinetic depth effect, en inglés).

Personalmente, el ejemplo del sketch tiene un efecto adicional diferente de la ilusión tridimensional, cuando el "crater" se desactiva, la figura pareciera girar más rápido.

### White X-Mas:
Esta ilusión está basada en la ilusión de [Munker-White](http://demonstrations.wolfram.com/MunkerWhiteIllusion/), una combinación de dos ilusiones similares, y el efecto de [Bezold](https://en.wikipedia.org/wiki/Bezold_effect), bautizado tras el meteórologo Alemán que lo descubrió. La ilusión de Munker-White ilustra el hecho de que la misma [luminancia](https://es.wikipedia.org/wiki/Luminancia) puede provocar diferentes percepciones de brillo en diferentes contextos. Mientras que el efrecto de Bezold dicta que un color puede parecer diferente dependiendo de su relación con los colores adyacentes.

## Posibles temas para profundizar:
[Kinetic Depth Effect](https://www.youtube.com/watch?v=mkhY5lANs-k) (i.e. Efecto de la bailarina)
Estudiar la razón detrás de la ambigüedad en el movimiento de ciertas figuras. ¿Cuáles son las condiciones para que una figura sea apta? ¿Es posible replicarlo en el eje Y?

