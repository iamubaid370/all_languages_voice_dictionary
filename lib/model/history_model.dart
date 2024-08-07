class HistoryModel {
  int? id;
  String text;

  HistoryModel({ this.id, required this.text});

  factory HistoryModel.fromMap(Map<String, dynamic> json) => HistoryModel(
    id: json["id"],
    text: json["text"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "text": text,
  };

}


