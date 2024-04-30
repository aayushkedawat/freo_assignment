import 'package:equatable/equatable.dart';

class PageEntity extends Equatable {
  final int? pageid;
  final int? ns;
  final String? title;
  final int? index;
  final String? description;
  final String? thumbnail;

  const PageEntity(
      {this.pageid,
      this.ns,
      this.title,
      this.index,
      this.description,
      this.thumbnail});

  @override
  List<Object?> get props => [
        pageid,
        ns,
        title,
        index,
        description,
        thumbnail,
      ];
}
