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
        mediaUrl: json["_MediaUrl"],
        mediaType: json["_MediaType"],
        mediaSourceType: json["_MediaSourceType"],
      );

  Map<String, dynamic> toJson() => {
        "_MediaUrl": mediaUrl,
        "_MediaType": mediaType,
        "_MediaSourceType": mediaSourceType,
      };
}
