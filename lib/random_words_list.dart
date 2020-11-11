import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

import 'selected_words.dart';

class RandomWordsList extends StatefulWidget {
  @override
  _RandomWordsListState createState() => _RandomWordsListState();
}

class _RandomWordsListState extends State<RandomWordsList> {
  final List<WordPair> _suggestions = [];
  final Set<WordPair> _savedItems = {};
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Startup name generator'),
          actions: [
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: () => _pushSaved(false),
            ),
            IconButton(
              icon: const Icon(Icons.art_track),
              onPressed: () => _pushSaved(true),
            )
          ],
        ),
        body: _buildSuggestions(),
      );

  Widget _buildSuggestions() => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext _ctx, int i) {
          if (i.isOdd) return Divider();
          final index = i ~/ 2;
          if (index >= _suggestions.length)
            _suggestions.addAll(generateWordPairs().take(10));
          return _buildRow(_suggestions[index]);
        }
      );

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _savedItems.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () => setState(() {
        if (alreadySaved)
          _savedItems.remove(pair);
        else
          _savedItems.add(pair);
      }),
    );
  }


  void _pushSaved(bool isUseDynamicList) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Text(isUseDynamicList ? 'Saved Suggestions (dynamic)' : 'Saved Suggestions (static)'),
          ),
          body: isUseDynamicList
              ? getDynamicDetailsList(context, _savedItems)
              : getStaticDetailsList(context, _savedItems),
        ),
      ),
    );
  }
}
