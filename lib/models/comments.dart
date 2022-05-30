

class Comment{

  String? by;
  int? id;
  List? kids;
  int? parent;
  String? text;
  String? type;

  Comment({
    required this.type,
    required this.parent,
    required this.kids,
    required this.by,
    required this.id,
    required this.text
});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        type: json['type'],
        parent: json['parent'],
        kids: json['kids'],
        by: json['by'],
        id: json['id'],
        text: json['text']
    );
  }


}