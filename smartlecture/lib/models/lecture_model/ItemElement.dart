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
        id: json["id"],
        mediatype: json["mediatype"],
        mediaurl: json["mediaurl"],
        question: json["question"],
        answer: json["answer"],
        selectedIndex: json["selectedIndex"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mediatype": mediatype,
        "mediaurl": mediaurl,
        "question": question,
        "answer": answer,
        "selectedIndex": selectedIndex,
      };
}
