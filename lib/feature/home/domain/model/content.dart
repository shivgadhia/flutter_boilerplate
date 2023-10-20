class Content {
  Content._();

  factory Content.horizontalRail(
          String id, String title, String subtitle, List<RailItem> items) =
      ContentRailSection;
}

class ContentRailSection extends Content {
  final String id;
  final String title;
  final String subtitle;
  final List<RailItem> items;

  ContentRailSection(this.id, this.title, this.subtitle, this.items)
      : super._();
}

class RailItem {
  
  RailItem._();

  factory RailItem.contentCard(String id, String title, String description,
      String backgroundImageUrl, String linkUrl) = ContentCard;
}

class ContentCard extends RailItem {
  final String id;
  final String title;
  final String description;
  final String backgroundImageUrl;
  final String linkUrl;

  ContentCard(this.id, this.title, this.description, this.backgroundImageUrl,
      this.linkUrl)
      : super._();
}
