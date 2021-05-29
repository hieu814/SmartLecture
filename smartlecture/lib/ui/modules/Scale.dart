class ScalePage {
  double width = 1.0;
  double height = 1.0;
  void setScalse(double width, double height) {
    this.width = width;
    this.height = height;
    print("scale----------------- ($width:$height)");
  }

  ScalePage({
    this.width = 1.0,
    this.height = 1.0,
  });
}
