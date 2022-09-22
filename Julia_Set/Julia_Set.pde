void setup() {
  size(800, 800);
  colorMode(HSB);
}

void draw() {
  //ComplexNumber C = new ComplexNumber(map(mouseX, 0, width, 2, -2), map(mouseY, 0, height, 2, -2));
 // ComplexNumber C = new ComplexNumber(cos((float)frameCount/100), sin((float)frameCount/100));
 ComplexNumber C = new ComplexNumber(0.35, 0.40);
  loadPixels();
  for(int i = 0; i < pixels.length; i++) {
    pixels[i] = color(map((float)(applyJulia(C, new ComplexNumber(map(i%width, 0, width, -2, 2), map(i/height, 0, height, -2, 2)), 10)), 0, 10, 0, 255));
    //println(pixels[i]);
  }
  updatePixels();
}

//map to color palette
// ints to floats for all the coefs

int applyJulia (ComplexNumber C, ComplexNumber Z, int depth) {
  ComplexNumber acc = Z;
  for(int i = 0; i < depth; i++) {
    if(modulus(acc) > 2) {
      return i;
    }
    acc = sum(C, product(acc, acc));
  }
  return depth;
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
