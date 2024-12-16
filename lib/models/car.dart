class Car {
  final int? id;
  final String name;
  final String imageUrl;
  final double price;
  final String description;
  final String horsepower;
  final String acceleration;
  final String engineType;
  final int maxSpeed;
  bool isFavorite;
  int quantity;

  Car(
      this.name,
      this.imageUrl,
      this.price,
      this.description,
      this.horsepower,
      this.acceleration,
      this.engineType,
      this.maxSpeed, {
        this.id,
        this.isFavorite = false,
        this.quantity = 0,
      });

  factory Car.fromJson(Map<String, dynamic> json) {

    if (json['name'] == null || json['imageUrl'] == null || json['description'] == null) {
      throw ArgumentError('Некоторые обязательные поля отсутствуют');
    }

    return Car(
      json['name'],
      json['imageUrl'],
      (json['price'] as num).toDouble(),
      json['description'],
      json['horsepower'] ?? '',
      json['acceleration'] ?? '',
      json['engineType'] ?? '',
      json['maxSpeed'] != null ? json['maxSpeed'] as int : 0,
      id: json['id'],
      isFavorite: json['isFavorite'] ?? false,
      quantity: json['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'description': description,
      'horsepower': horsepower,
      'acceleration': acceleration,
      'engineType': engineType,
      'maxSpeed': maxSpeed,
      'isFavorite': isFavorite,
      'quantity': quantity,
    };
  }
}
