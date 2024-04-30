import 'package:equatable/equatable.dart';

class TermsEntity extends Equatable {
  final List<String>? description;

  const TermsEntity({
    this.description,
  });

  @override
  List<Object?> get props => [description];
}
