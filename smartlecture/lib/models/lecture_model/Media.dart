class Media {
  Media({
    this.mediaUrl,
    this.mediaType,
    this.mediaSourceType,
  });

  String mediaUrl;
  String mediaType;
  String mediaSourceType;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        mediaUrl: json["MediaUrl"],
        mediaType: json["MediaType"],
        mediaSourceType: json["MediaSourceType"],
      );

  Map<String, dynamic> toJson() => {
        "MediaUrl": mediaUrl,
        "MediaType": mediaType,
        "MediaSourceType": mediaSourceType,
      };
}
