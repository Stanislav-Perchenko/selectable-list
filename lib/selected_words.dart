import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

ListView getStaticDetailsList(BuildContext context, Set<WordPair> items,
    {TextStyle textStyle}) {
  final Iterable<ListTile> tiles = items.map((WordPair pair) => ListTile(
        title: Text(
          pair.asPascalCase,
          style: textStyle,
        ),
      ));

  return ListView(
      padding: const EdgeInsets.all(16),
      children: ListTile.divideTiles(context: context, tiles: tiles).toList()
  );
}

ListView getDynamicDetailsList(BuildContext context, Iterable<WordPair> items, {TextStyle textStyle}) =>
    ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length * 2,
        itemBuilder: (BuildContext _ctx, int i) {
          if (i.isOdd) {
            return Divider();
          } else {
            final index = i ~/ 2;
            return ListTile(
              title: Text(items.elementAt(index).asPascalCase, style: textStyle)
            );
          }
        });
