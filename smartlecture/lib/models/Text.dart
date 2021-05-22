class Text {
  Text({
    this.text,
    this.font,
    this.size,
    this.color,
    this.bold,
    this.align,
    this.leading,
    this.italic,
    this.underline,
    this.leftMargin,
    this.bullet,
  });

  String text;
  String font;
  String size;
  String color;
  String bold;
  String align;
  String leading;
  String italic;
  String underline;
  String leftMargin;
  String bullet;

  factory Text.fromJson(Map<String, dynamic> json) => Text(
        text: json["_text"],
        font: json["_font"],
        size: json["_size"],
        color: json["_color"],
        bold: json["_bold"],
        align: json["_align"],
        leading: json["_leading"],
        italic: json["_italic"],
        underline: json["_underline"],
        leftMargin: json["_leftMargin"],
        bullet: json["_bullet"],
      );

  Map<String, dynamic> toJson() => {
        "_text": text,
        "_font": font,
        "_size": size,
        "_color": color,
        "_bold": bold,
        "_align": align,
        "_leading": leading,
        "_italic": italic,
        "_underline": underline,
        "_leftMargin": leftMargin,
        "_bullet": bullet,
      };
}
