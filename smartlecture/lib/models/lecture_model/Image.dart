class Image {
  Image({
    this.url,
  });

  String url;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json["_url"],
      );

  Map<String, dynamic> toJson() => {
        "_url": url,
      };
}
