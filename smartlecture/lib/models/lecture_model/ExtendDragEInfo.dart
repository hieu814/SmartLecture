class ExtendDragEInfo {
  ExtendDragEInfo({
    this.data,
  });

  String data;

  factory ExtendDragEInfo.fromJson(Map<String, dynamic> json) =>
      ExtendDragEInfo(
        data: json["Data"],
      );

  Map<String, dynamic> toJson() => {
        "Data": data,
      };
}
