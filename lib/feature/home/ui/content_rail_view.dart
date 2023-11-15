import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/ui/screen_size.dart';
import 'package:flutter_boilerplate/feature/home/domain/model/content.dart';

typedef OnRailItemClick = void Function(RailItem item);

class ContentRailView extends StatelessWidget {
  final ContentRailSection uiModel;
  final OnRailItemClick onRailItemClick;

  const ContentRailView(
      {Key? key, required this.uiModel, required this.onRailItemClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          title: Text(uiModel.title,
              style: Theme.of(context).textTheme.titleLarge),
          subtitle: Text(uiModel.subtitle,
              style: Theme.of(context).textTheme.caption),
        ),
        SizedBox(
          height: getCardHeight(context.getScreenSize()),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            scrollDirection: Axis.horizontal,
            itemCount: uiModel.items.length,
            itemBuilder: (context, index) =>
                _buildRailItem(uiModel.items[index], context),
          ),
        )
      ],
    );
  }

  Widget _buildRailItem(RailItem thisItem, BuildContext context) {
    switch (thisItem.runtimeType) {
      case ContentCard:
        return _buildContentCard(context, thisItem as ContentCard);
      default:
        throw UnimplementedError();
    }
  }

  Widget _buildContentCard(BuildContext context, ContentCard item) {
    return SizedBox(
      width: getCardWidth(context.getScreenSize()),
      child: InkWell(
        onTap: () {
          onRailItemClick(item);
        },
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              Image.network(
                item.backgroundImageUrl,
                fit: BoxFit.cover,
              ),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(color: Colors.black38),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    item.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  double getCardWidth(ScreenSize screenSize) {
    double cardWidth;
    switch (screenSize) {
      case ScreenSize.small:
      case ScreenSize.normal:
        cardWidth = 160;
        break;
      case ScreenSize.large:
      case ScreenSize.extraLarge:
        cardWidth = 391;
    }
    return cardWidth;
  }

  double getCardHeight(ScreenSize screenSize) {
    double cardHeight;
    switch (screenSize) {
      case ScreenSize.small:
      case ScreenSize.normal:
        cardHeight = 213;
        break;
      case ScreenSize.large:
      case ScreenSize.extraLarge:
        cardHeight = 220;
    }
    return cardHeight;
  }
}
