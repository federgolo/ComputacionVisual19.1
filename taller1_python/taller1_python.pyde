import collections
from itertools import groupby

def setup():
    size(939, 375)
    background(255, 250, 0)
    global pg1, pg2, pg3, myImage, imgWidth, imgHeight, greys, brights, movie
    myImage = loadImage("nba.jpg")
    imgWidth = myImage.width
    imgHeight = myImage.height
    greys, brights = [], []
    pg1 = createGraphics(imgWidth, imgHeight)
    pg2 = createGraphics(imgWidth, imgHeight)
    pg3 = createGraphics(256, imgHeight)
    
def draw():
    # Draw background image on first two canvases.
    pg1.beginDraw()
    pg1.background(myImage)
    pg1.endDraw()
    
    pg2.beginDraw()
    pg2.background(myImage)
    pg2.endDraw()
    
    noLoop()
    pg2.loadPixels()
    for i in range(len(pg2.pixels)):
        # Here we go through every pixel of the image, get their RGB values and then overwrite them with the average of the three
        # values to turn the image to grayscale. 
        avg = int((red(pg2.pixels[i]) + green(pg2.pixels[i]) + blue(pg2.pixels[i])) / 3)
        pg2.pixels[i] = color(avg, avg, avg)
        # As we do this, we also save said "new color values" to the "greys" array, which we will use to create the histogram.
        greys.append(avg)
        
    # Another way to create the histogram would include using the brightness method, as shown below.    
    # for j in range(len(pg2.pixels)):
    #     brights.append(int(brightness(pg2.pixels[j])))
    pg2.updatePixels()
    
    #We sort the array in order to use the "groupby" function which returns the amount of times each value (0-255) appears.
    greys.sort()
    frequency = [len(list(group)) for key, group in groupby(greys)]
    
    histMax = max(frequency)
    pg3.beginDraw()
    for i in range(len(frequency)):
        # On a third canvas, we draw the histogram. To do this, we go through the frequency array and draw a line with a length
        # proportional to its value. Also, as a gimmick, each line's color is equal to the amount of pixels composed of that color.
        y = int(map(frequency[i], 0, histMax, pg3.height, 0))
        pg3.stroke(i)
        pg3.line(i, pg3.height, i, y)
    pg3.endDraw()
    
    textSize(20)
    fill(0)
    text("Original image", 99, 30)
    image(pg1, 15, 45)
    text("Conversion to gray scale", 361, 30)
    image(pg2, imgWidth + 31, 45)
    text("Histogram", 750, 30)
    image(pg3, 2*imgWidth + 66, 45)
    textSize(10)
    text("0", 663, 358)
    text("255", 910, 358)
    
    textSize(15)
    cx = 660
    cy = height/2
    textAlign(CENTER,BOTTOM)
    
    pushMatrix()
    translate(cx,cy)
    rotate(-HALF_PI)
    text("Frequency",0,0)
    popMatrix()
