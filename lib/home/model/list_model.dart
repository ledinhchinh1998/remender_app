

class ListModel {
  String color;
  String title;
  int id;
  int count;

  ListModel({this.color, this.title, this.id, this.count});

  factory ListModel.fromMap(Map<String, dynamic> map) {
    return new ListModel(
      color: map['color'] as String,
      title: map['title'] as String,
      id: map['id'] as int,
      count: map['count'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'color': this.color,
      'title': this.title,
      'id': this.id,
      'count': this.count,
    } as Map<String, dynamic>;
  }
}