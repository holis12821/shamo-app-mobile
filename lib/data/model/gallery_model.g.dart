// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GalleryModel _$GalleryModelFromJson(Map<String, dynamic> json) => GalleryModel(
      id: (json['id'] as num).toInt(),
      productsId: (json['products_id'] as num?)?.toInt(),
      url: json['url'] as String,
      deletedAt: json['deleted_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$GalleryModelToJson(GalleryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'products_id': instance.productsId,
      'url': instance.url,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
