class Appear {
  Appear({
    this.id,
    this.name,
    this.direction,
    this.start,
    this.speed,
    this.repeat,
    this.index,
  });

  int id;
  String name;
  String direction;
  String start;
  String speed;
  String repeat;
  String index;

  factory Appear.fromJson(Map<String, dynamic> json) => Appear(
        id: json["_id"],
        name: json["_name"],
        direction: json["_direction"],
        start: json["_start"],
        speed: json["_speed"],
        repeat: json["_repeat"],
        index: json["_index"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "_name": name,
        "_direction": direction,
        "_start": start,
        "_speed": speed,
        "_repeat": repeat,
        "_index": index,
      };
}
