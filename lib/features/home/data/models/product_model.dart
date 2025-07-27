import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductModel {
  final int id;
  final String title;
  final String slug;
  final double price;
  final String description;
  final Category category;
  final List<String> images;
  final String creationAt;
  final String updatedAt;
  final bool? active;
  final bool? hidden;

  ProductModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
    required this.creationAt,
    required this.updatedAt,
    this.active,
    this.hidden,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

@JsonSerializable()
class Category {
  final int id;
  final String name;
  final String slug;
  final String image;
  final String creationAt;
  final String updatedAt;
  final bool? active;
  final bool? hidden;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.creationAt,
    required this.updatedAt,
    this.active,
    this.hidden,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
