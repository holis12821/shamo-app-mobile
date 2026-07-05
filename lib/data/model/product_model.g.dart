// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      price: (json['price'] as num).toInt(),
      description: json['description'] as String?,
      tags: json['tags'] as String?,
      categoriesId: (json['categories_id'] as num?)?.toInt(),
      deletedAt: json['deleted_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      formatted: json['formatted'] == null
          ? null
          : FormattedModel.fromJson(json['formatted'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      galleries: (json['galleries'] as List<dynamic>?)
          ?.map((e) => GalleryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'tags': instance.tags,
      'categories_id': instance.categoriesId,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'formatted': instance.formatted?.toJson(),
      'category': instance.category?.toJson(),
      'galleries': instance.galleries?.map((e) => e.toJson()).toList(),
    };

FormattedModel _$FormattedModelFromJson(Map<String, dynamic> json) =>
    FormattedModel(
      price: json['price'] as String?,
    );

Map<String, dynamic> _$FormattedModelToJson(FormattedModel instance) =>
    <String, dynamic>{
      'price': instance.price,
    };
