void setup() {
  size(1000, 1000);
  colorMode(HSB);
}

void draw() {
  noLoop();
  loadPixels();
  ComplexNumber[] roots = {new ComplexNumber(-1.3247, 0), new ComplexNumber(0, 1), new ComplexNumber(0, -1),
                           new ComplexNumber(0.66236, -0.56228), new ComplexNumber(0.66236, 0.56228)};
  for(int i = 0; i < pixels.length; i++) {
    pixels[i] = setColor(closestRoot(roots, nRoot(new float[] {1, 0, 0, 1, -1, 1}, new ComplexNumber(map(i%width, 0, width, -2, 2), map(i/height, 0, height, -2, 2)), 2)));
  }
  updatePixels();
 // saveFrame("blackandwhite2.png");
}

//map to color palette  
// ints to floats for all the coefs

color setColor (int n) {
  //return color(30*n + 100, 150, 200);
  return color(map(n, 0, 4, 25, 225));
}

ComplexNumber nRoot(float[] poly, ComplexNumber z, int depth) {
  if(depth > 0) {
    return nRoot(poly, difference(z, divide(p(poly, z), p(derivative(poly), z))), depth-1);
  } else {
    return z;
  }
}

ComplexNumber p (float[] poly, ComplexNumber z) {
  ComplexNumber cur = new ComplexNumber(1, 0);
  for(int i = 0; i < poly.length; i++) {
    cur = sum(cur, product(new ComplexNumber(poly[i], 0), power(z, poly.length - i)));
  }
  return cur;
}


//starts with the highest power
float[] derivative(float[] coefs) {
  float[] result = new float[coefs.length - 1];
  for(int i = 0; i < result.length; i++) {
    result[i] = (result.length - i)*coefs[i];
  }
  return result;
}

int closestRoot (ComplexNumber[] roots, ComplexNumber z) {
  ComplexNumber closest = roots[0];
  int index = 0;
  double leastDistance = Double.MAX_VALUE;
  for(int i = 0; i < roots.length; i++) {
    if(modulus(difference(z, roots[i])) < leastDistance) {
      closest = roots[i];
      leastDistance = modulus(difference(z, roots[i]));
      index = i;
    }
  }
  //return closest;
  //OR
  return index;
}


ComplexNumber sum(ComplexNumber z, ComplexNumber w) {
    return new ComplexNumber(z.a+w.a, z.b+w.b);
  }
  
  ComplexNumber difference(ComplexNumber z, ComplexNumber w) {
    return new ComplexNumber(z.a-w.a, z.b-w.b);
  }
  
  ComplexNumber product(ComplexNumber z, ComplexNumber w) {
    return new ComplexNumber(z.a*w.a - z.b*w.b, z.a*w.b + z.b*w.a);
  }
  
  ComplexNumber power(ComplexNumber z, int p) {
    if(p==0) {return new ComplexNumber(1, 0);}
    else if (p == 1) {return z;}
    ComplexNumber cur = new ComplexNumber(1, 0);
    for(int i = 0; i < p; i++) {
      cur = product(cur, z);
    }
    return cur;
  }
  
  ComplexNumber divide(ComplexNumber z, ComplexNumber w) {
    return new ComplexNumber((z.a*w.a + z.b*w.b)/(Math.pow(w.a, 2) + Math.pow(w.b, 2)), (z.b*w.a - z.a*w.b)/(Math.pow(w.a, 2) + Math.pow(w.b, 2)));
  }
  
  ComplexNumber conjugate(ComplexNumber z) {
    return new ComplexNumber(z.a, -(z.b));
  }
  
  double modulus(ComplexNumber z) {
    return Math.pow((Math.pow(z.a, 2) + Math.pow(z.b, 2)), 0.5);
  }
  
  
