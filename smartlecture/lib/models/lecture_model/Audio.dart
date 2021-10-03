class Audio {
  Audio({
    this.url = "",
  });

  String url;

  factory Audio.fromJson(Map<String, dynamic> json) {
    return json == null
        ? Audio()
        : Audio(
            url: json["Url"],
          );
  }

  Map<String, dynamic> toJson() => {
        "Url": url,
      };
}
