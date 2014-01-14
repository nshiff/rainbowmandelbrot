
int MAX_ITERATIONS = 100;

void setup() {
  size(900, 500);
}
void draw() {
  // Establish a range of values on the complex plane
  // A different range will allow us to "zoom" in or out on the fractal
  // float xmin = -1.5; float ymin = -.1; float wh = 0.15;
  float xmin = -3;
  float ymin = -1.25;
  float w = 5;
  float h = 2.5;

  

  // x goes from xmin to xmax
  float xmax = xmin + w;
  // y goes from ymin to ymax
  float ymax = ymin + h;

  // Calculate amount we increment x,y for each pixel
  float dx = (xmax - xmin) / (width);
  float dy = (ymax - ymin) / (height);

  // Start y
  float y = ymin;



  background(255);
  loadPixels();

  for (int j = 0; j < height; j++) {
    // Start x
    float x = xmin;
    for (int i = 0;  i < width; i++) {

      // Now we test, as we iterate z = z^2 + cm does z tend towards infinity?
      float a = x;
      float b = y;
      int n = 0;
      while (n < MAX_ITERATIONS) {
        float aa = a * a;
        float bb = b * b;
        float twoab = 2.0 * a * b;
        a = aa - bb + x;
        b = twoab + y;
        // Infinty in our finite world is simple, let's just consider it 16
        if (aa + bb > 16.0) {
          break;  // Bail
        }
        n++;
      }

      // We color each pixel based on how long it takes to get to infinity
      // If we never got there, let's pick the color black
      if (n == MAX_ITERATIONS) {
        pixels[i+j*width] = color(0);
      }
      else {
        // Gosh, we could make fancy colors here if we wanted
        //      int red=n*16 % 255;

        double scaleWidthToColor = 255.0/width;

        int red    = (int)(mouseX * scaleWidthToColor);
        int green  = n*16 % 255;
        int blue   = (int)(mouseY * scaleWidthToColor);

        pixels[i+j*width] = color(red, green, blue);
      }
      x += dx;
    }
    y += dy;
  }


  updatePixels();
}

