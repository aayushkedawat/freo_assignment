import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:freo_assignment/features/wiki/domain/entity/page.dart';

class PageDisplayItem {
  Widget pageDisplayItem(PageEntity pageModel,
      {Widget? trailing, void Function()? onTap}) {
    const errorWidget = Icon(
      Icons.error,
      size: 50,
    );
    return ListTile(
      title: Text(pageModel.title ?? ''),
      leading: ((pageModel.thumbnail ?? '').isNotEmpty)
          ? CachedNetworkImage(
              imageUrl: pageModel.thumbnail ?? '',
              errorWidget: (context, url, error) => errorWidget,
              height: 50,
              width: 50,
              fit: BoxFit.fill,
              placeholder: (context, url) => const CircularProgressIndicator(),
            )
          : errorWidget,
      trailing: trailing,
      subtitle: Text(pageModel.description ?? ''),
      onTap: onTap,
    );
  }
}
