import 'package:flutter/material.dart';

class CategoryModel {
  CategoryModel({
    List<CategoryData>? data,
    bool? success,
  }) {
    _data = data;
    _success = success;
  }

  CategoryModel.fromJson(dynamic json) {
    debugPrint('FIRST FORMJSON CALLED');
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(
          CategoryData.fromJson(v),
        );
      });
    }
    _success = json['success'];
  }

  List<CategoryData>? _data;
  bool? _success;

  CategoryModel copyWith({
    List<CategoryData>? data,
    bool? success,
  }) =>
      CategoryModel(
        data: data ?? _data,
        success: success ?? _success,
      );

  List<CategoryData>? get data => _data;

  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data
          ?.map(
            (v) => v.toJson(),
          )
          .toList();
    }
    map['success'] = _success;
    return map;
  }
}

class CategoryData {
  CategoryData({
    num? id,
    String? name,
    String? image,
    num? status,
    String? createdAt,
    String? updatedAt,
    String? imagePath,
  }) {
    _id = id;
    _name = name;
    _image = image;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _imagePath = imagePath;
  }

  CategoryData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];

    _status = num.tryParse(json['status']);
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _imagePath = json['imagePath'];
  }

  num? _id;
  String? _name;
  String? _image;
  num? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _imagePath;

  CategoryData copyWith({
    num? id,
    String? name,
    String? image,
    num? status,
    String? createdAt,
    String? updatedAt,
    String? imagePath,
  }) =>
      CategoryData(
        id: id ?? _id,
        name: name ?? _name,
        image: image ?? _image,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        imagePath: imagePath ?? _imagePath,
      );

  num? get id => _id;

  String? get name => _name;

  String? get image => _image;

  num? get status => _status;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get imagePath => _imagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['imagePath'] = _imagePath;
    return map;
  }
}
