// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PetModel {
  String id;
  String name;
  String gender;
  String image;
  String type;
  String description;
  String breed;
  int age;
  int price;
  DateTime createdAt;
  DateTime updatedAt;
  PetModel({
    required this.id,
    required this.name,
    required this.gender,
    required this.image,
    required this.type,
    required this.description,
    required this.breed,
    required this.age,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  PetModel copyWith({
    String? id,
    String? name,
    String? gender,
    String? image,
    String? type,
    String? description,
    String? breed,
    int? age,
    int? price,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PetModel(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      type: type ?? this.type,
      description: description ?? this.description,
      breed: breed ?? this.breed,
      age: age ?? this.age,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'gender': gender,
      'image': image,
      'type': type,
      'description': description,
      'breed': breed,
      'age': age,
      'price': price,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory PetModel.fromMap(Map<String, dynamic> map) {
    return PetModel(
      id: map['id'] as String,
      name: map['name'] as String,
      gender: map['gender'] as String,
      image: map['image'] as String,
      type: map['type'] as String,
      description: map['description'] as String,
      breed: map['breed'] as String,
      age: map['age'] as int,
      price: map['price'] as int,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory PetModel.fromJson(String source) =>
      PetModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PetModel(id: $id, name: $name, gender: $gender, image: $image, type: $type, description: $description, breed: $breed, age: $age, price: $price, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant PetModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.gender == gender &&
        other.image == image &&
        other.type == type &&
        other.description == description &&
        other.breed == breed &&
        other.age == age &&
        other.price == price &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        gender.hashCode ^
        image.hashCode ^
        type.hashCode ^
        description.hashCode ^
        breed.hashCode ^
        age.hashCode ^
        price.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
