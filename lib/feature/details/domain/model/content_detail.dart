import 'package:equatable/equatable.dart';

class ContentDetail extends Equatable {
  final String id;
  final String title;
  final String description;
  final String backgroundImageUrl;
  final String linkUrl;
  final bool locked;
  final BigInt createdAt;
  final BigInt editedAt;

  const ContentDetail(
      this.id,
      this.title,
      this.description,
      this.backgroundImageUrl,
      this.linkUrl,
      this.locked,
      this.createdAt,
      this.editedAt);

  @override
  List<Object?> get props => [id];
}
