import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/home/domain/model/content.dart';

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
          height: 120,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: uiModel.items.length,
              itemBuilder: (context, index) {
                RailItem thisItem = uiModel.items[index];
                if (thisItem is ContentCard) {
                  return _buildRailItem(context, thisItem);
                } else {
                  throw UnimplementedError();
                }
              }),
        )
      ],
    );
  }

  Widget _buildRailItem(BuildContext context, ContentCard item) {
    return SizedBox(
      width: 220,
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
}
