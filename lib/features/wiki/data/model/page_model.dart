import '../../domain/entity/page.dart';

import 'package:floor/floor.dart';

@Entity(tableName: 'page', primaryKeys: ['pageid'])
class PageModel extends PageEntity {
  const PageModel({
    required super.index,
    required super.ns,
    required super.pageid,
    required super.description,
    required super.title,
    required super.thumbnail,
  });
  factory PageModel.fromJson(Map<String, dynamic> json) {
    List descriptionList =
        json["terms"] != null ? json["terms"]['description'] : [];
    String description = '';
    if (descriptionList.isNotEmpty) {
      description = descriptionList.first;
    }
    Map<String, dynamic>? thumbnailMap = json["thumbnail"];
    String thumbnail = '';
    if (thumbnailMap != null) {
      thumbnail = json["thumbnail"]['source'];
    }
    return PageModel(
      pageid: json["pageid"],
      ns: json["ns"],
      title: json["title"],
      index: json["index"],
      description: description,
      thumbnail: thumbnail,
    );
  }
  factory PageModel.fromEntity(PageEntity pageEntity) {
    return PageModel(
        index: pageEntity.index,
        ns: pageEntity.ns,
        pageid: pageEntity.pageid,
        description: pageEntity.description,
        title: pageEntity.title,
        thumbnail: pageEntity.thumbnail);
  }
  PageEntity toEntity() {
    return PageEntity(
      index: index,
      ns: ns,
      pageid: pageid,
      description: description,
      title: title,
      thumbnail: thumbnail,
    );
  }
}
