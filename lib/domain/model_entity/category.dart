import 'package:floor/floor.dart';

@entity
class Category {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String name;

  Category(this.id, this.name);

  factory Category.fromJson(Map json) {
    return Category(
        json['id'],
        json['name']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name
    };
  }
}