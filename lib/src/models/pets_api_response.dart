// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:pet_shop/src/models/pet_model.dart';

class PetsApiResponse {
  bool success;
  String message;
  List<PetModel> data;
  PetsApiResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  PetsApiResponse copyWith({
    bool? success,
    String? message,
    List<PetModel>? data,
  }) {
    return PetsApiResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'message': message,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory PetsApiResponse.fromMap(Map<String, dynamic> map) {
    return PetsApiResponse(
      success: map['success'] as bool,
      message: map['message'] as String,
      data: List<PetModel>.from(
        (map['data'] as List<int>).map<PetModel>(
          (x) => PetModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PetsApiResponse.fromJson(String source) =>
      PetsApiResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PetsApiResponse(success: $success, message: $message, data: $data)';

  @override
  bool operator ==(covariant PetsApiResponse other) {
    if (identical(this, other)) return true;

    return other.success == success &&
        other.message == message &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => success.hashCode ^ message.hashCode ^ data.hashCode;
}
