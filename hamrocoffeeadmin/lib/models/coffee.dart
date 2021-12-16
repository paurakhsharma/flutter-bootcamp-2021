import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Coffee {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<Size> sizes;
  Coffee({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.sizes,
  });

  Coffee copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    List<Size>? sizes,
  }) {
    return Coffee(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      sizes: sizes ?? this.sizes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'sizes': sizes.map((x) => x.toMap()).toList(),
    };
  }

  factory Coffee.fromMap(Map<String, dynamic> map) {
    return Coffee(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      sizes: List<Size>.from(map['sizes']?.map((x) => Size.fromMap(x))),
    );
  }

  factory Coffee.fromSnapshot(QueryDocumentSnapshot<Object?> snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    data['id'] = snapshot.id;
    return Coffee.fromMap(data);
  }

  String toJson() => json.encode(toMap());

  factory Coffee.fromJson(String source) => Coffee.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Coffee(id: $id, name: $name, description: $description, imageUrl: $imageUrl, sizes: $sizes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Coffee &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.imageUrl == imageUrl &&
        listEquals(other.sizes, sizes);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        imageUrl.hashCode ^
        sizes.hashCode;
  }
}

class Size {
  final String name;
  final int price;
  Size({
    required this.name,
    required this.price,
  });

  Size copyWith({
    String? name,
    int? price,
  }) {
    return Size(
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
    };
  }

  factory Size.fromMap(Map<String, dynamic> map) {
    return Size(
      name: map['name'] ?? '',
      price: map['price'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Size.fromJson(String source) => Size.fromMap(json.decode(source));

  @override
  String toString() => 'Size(name: $name, price: $price)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Size && other.name == name && other.price == price;
  }

  @override
  int get hashCode => name.hashCode ^ price.hashCode;
}
