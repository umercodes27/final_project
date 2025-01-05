import 'dart:convert';

class Meal {
  int? id;
  String title;
  double price;

  Meal({
    this.id,
    required this.title,
    required this.price,
  });

  // Map → Meal
  factory Meal.fromMap(Map<String, dynamic> map) {
    if (!map.containsKey('title') || !map.containsKey('price')) {
      throw ArgumentError('Invalid map: Missing required keys');
    }
    return Meal(
      id: map['id'] as int?,
      title: map['title'] as String,
      price: (map['price'] as num).toDouble(),
    );
  }

  // Meal → Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
    };
  }

  // JSON → Meal
  factory Meal.fromJson(String jsonStr) {
    Map<String, dynamic> map = json.decode(jsonStr);
    return Meal.fromMap(map);
  }

  // Meal → JSON
  String toJson() {
    return json.encode(toMap());
  }
}
