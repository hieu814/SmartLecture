class ItemElement {
  ItemElement({
    this.id,
    this.mediatype,
    this.mediaurl,
    this.question,
    this.answer,
    this.selectedIndex,
  });

  String id;
  String mediatype;
  String mediaurl;
  String question;
  String answer;
  String selectedIndex;

  factory ItemElement.fromJson(Map<String, dynamic> json) => ItemElement(
        id: json["_id"],
        mediatype: json["_mediatype"],
        mediaurl: json["_mediaurl"],
        question: json["_question"],
        answer: json["_answer"],
        selectedIndex: json["_selectedIndex"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "_mediatype": mediatype,
        "_mediaurl": mediaurl,
        "_question": question,
        "_answer": answer,
        "_selectedIndex": selectedIndex,
      };
}
