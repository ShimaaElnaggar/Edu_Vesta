class Category {
  String? id;
  String? name;

  Category({this.id, this.name});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'],
        name: json['name'],
      );
}
