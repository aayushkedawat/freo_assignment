import 'package:equatable/equatable.dart';

class ThumbnailEntity extends Equatable {
  final String? source;
  final int? width;
  final int? height;

  const ThumbnailEntity({
    this.source,
    this.width,
    this.height,
  });

  @override
  List<Object?> get props => [source, width, height];
}
