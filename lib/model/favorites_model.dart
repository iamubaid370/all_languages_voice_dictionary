class FavoritesModel {
  int? id;
  String text;

  FavoritesModel({this.id, required this.text});

  factory FavoritesModel.fromMap(Map<String, dynamic> json) => FavoritesModel(
    id: json["id"],
    text: json["text"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "text": text,
  };

}