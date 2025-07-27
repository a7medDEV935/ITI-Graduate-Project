// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      slug: json['slug'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      creationAt: json['creationAt'] as String,
      updatedAt: json['updatedAt'] as String,
      active: json['active'] as bool?,
      hidden: json['hidden'] as bool?,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'slug': instance.slug,
      'price': instance.price,
      'description': instance.description,
      'category': instance.category.toJson(),
      'images': instance.images,
      'creationAt': instance.creationAt,
      'updatedAt': instance.updatedAt,
      'active': instance.active,
      'hidden': instance.hidden,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      slug: json['slug'] as String,
      image: json['image'] as String,
      creationAt: json['creationAt'] as String,
      updatedAt: json['updatedAt'] as String,
      active: json['active'] as bool?,
      hidden: json['hidden'] as bool?,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'image': instance.image,
      'creationAt': instance.creationAt,
      'updatedAt': instance.updatedAt,
      'active': instance.active,
      'hidden': instance.hidden,
    };
