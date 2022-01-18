import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String id;
  final String coffeeId;
  final String userId;
  final String size;
  final int price;
  Order({
    required this.id,
    required this.coffeeId,
    required this.userId,
    required this.size,
    required this.price,
  });

  Order copyWith({
    String? id,
    String? coffeeId,
    String? userId,
    String? size,
    int? price,
  }) {
    return Order(
      id: id ?? this.id,
      coffeeId: coffeeId ?? this.coffeeId,
      userId: userId ?? this.userId,
      size: size ?? this.size,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'coffeeId': coffeeId,
      'userId': userId,
      'size': size,
      'price': price,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] ?? '',
      coffeeId: map['coffeeId'] ?? '',
      userId: map['userId'] ?? '',
      size: map['size'] ?? '',
      price: map['price']?.toInt() ?? 0,
    );
  }

  factory Order.fromSnapshot(DocumentSnapshot<Object?> snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    data['id'] = snapshot.id;
    return Order.fromMap(data);
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(id: $id, coffeeId: $coffeeId, size: $size, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.id == id &&
        other.coffeeId == coffeeId &&
        other.userId == coffeeId &&
        other.size == size &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        coffeeId.hashCode ^
        userId.hashCode ^
        size.hashCode ^
        price.hashCode;
  }
}
