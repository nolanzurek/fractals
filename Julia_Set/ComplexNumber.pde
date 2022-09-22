class ComplexNumber {
  
  // a + bi
  
  public double a;
  public double b;
  
  ComplexNumber(double a, double b) {
    this.a = a;
    this.b = b;
  }
  
  double modulus(ComplexNumber z) {
    return Math.pow((Math.pow(z.a, 2) + Math.pow(z.b, 2)), 0.5);
  }
  
  String toString() {
    return "" + a + " + " + b + "i";
  }
  
}
