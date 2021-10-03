class Text {
  Text({
    this.text = "",
    this.font = "",
    this.size = 0,
    this.color = "",
    this.bold = "",
    this.align = "",
    this.leading = "",
    this.italic = "",
    this.underline = "",
    this.leftMargin = "",
    this.bullet = "",
  });

  String text;
  String font;
  double size;
  String color;
  String bold;
  String align;
  String leading;
  String italic;
  String underline;
  String leftMargin;
  String bullet;

  factory Text.fromJson(Map<String, dynamic> json) => Text(
        text: json["text"],
        font: json["font"],
        size: json["size"] is double
            ? json["size"]
            : double.parse((json["size"])),
        color: json["color"],
        bold: json["bold"],
        align: json["align"],
        leading: json["leading"],
        italic: json["italic"],
        underline: json["underline"],
        leftMargin: json["leftMargin"],
        bullet: json["bullet"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "font": font,
        "size": size,
        "color": color,
        "bold": bold,
        "align": align,
        "leading": leading,
        "italic": italic,
        "underline": underline,
        "leftMargin": leftMargin,
        "bullet": bullet,
      };
}
