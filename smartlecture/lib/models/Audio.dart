class Audio {
  Audio({
    this.url,
  });

  String url;

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        url: json["_Url"],
      );

  Map<String, dynamic> toJson() => {
        "_Url": url,
      };
}
