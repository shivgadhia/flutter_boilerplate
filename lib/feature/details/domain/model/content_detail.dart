class ContentDetail {
  final String id;
  final String title;
  final String description;
  final String backgroundImageUrl;
  final String linkUrl;
  final bool locked;
  final BigInt createdAt;
  final BigInt editedAt;

  ContentDetail(this.id, this.title, this.description, this.backgroundImageUrl,
      this.linkUrl, this.locked, this.createdAt, this.editedAt);
}
