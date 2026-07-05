import 'package:json_annotation/json_annotation.dart';
import 'package:shamoapps/domain/entity/gallery.dart';

part 'gallery_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GalleryModel {
  final int id;
  final int? productsId;
  final String url;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;

  GalleryModel({
    required this.id,
    this.productsId,
    required this.url,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory GalleryModel.fromJson(Map<String, dynamic> json) =>
      _$GalleryModelFromJson(json);

  Map<String, dynamic> toJson() => _$GalleryModelToJson(this);

  Gallery map() {
    return Gallery(id: id, url: url);
  }
}