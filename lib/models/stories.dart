

class Story{

  String? by;
  int? id;
  List? kids;
  int? parent;
  String? title;
  String? type;
  String? url;


  Story({
    required this.title,
    required this.id,
    required this.url,
    required this.by,
    required this.kids,
    required this.parent,
    required this.type
});

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
        title: json['title'],
        id: json['id'],
        url: json['url'],
        by: json['by'],
        kids: json['kids'],
        parent: json['parent'],
        type: json['type']
    );
  }


}