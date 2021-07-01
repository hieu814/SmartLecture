class ExtendDragEInfo {
  ExtendDragEInfo({
    this.data,
  });

  String data;

  factory ExtendDragEInfo.fromJson(Map<String, dynamic> json) =>
      ExtendDragEInfo(
        data: json["_Data"],
      );

  Map<String, dynamic> toJson() => {
        "_Data": data,
      };
}
