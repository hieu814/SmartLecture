class Appear {
  Appear({
    this.id = "NoId",
    this.name = "None",
    this.direction = "None",
    this.start = "Auto",
    this.speed = "0",
    this.repeat = "false",
    this.index = "0",
  });

  String id;
  String name;
  String direction;
  String start;
  String speed;
  String repeat;
  String index;
//----
  factory Appear.fromJson(Map<String, dynamic> json) {
    print("------appear: " + json.toString());
    return json == null
        ? Appear()
        : Appear(
            id: json["id"] ?? "NoId",
            name: json["name"],
            direction: json["direction"],
            start: json["start"],
            speed: json["speed"],
            repeat: json["repeat"],
            index: json["index"],
          );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "direction": direction,
        "start": start,
        "speed": speed,
        "repeat": repeat,
        "index": index,
      };
}
