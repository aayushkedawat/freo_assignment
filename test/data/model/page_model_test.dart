import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:freo_assignment/features/wiki/data/model/page_model.dart';
import 'package:freo_assignment/features/wiki/domain/entity/page.dart';

import '../../helpers/json_reader.dart';

void main() {
  const testWikiPage = PageModel(
      description: 'Indian cricketer',
      index: 2,
      ns: 0,
      pageid: 57570,
      thumbnail:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/Sachin-Tendulkar_%28cropped%29.jpg/50px-Sachin-Tendulkar_%28cropped%29.jpg',
      title: 'Sachin Tendulkar');
  test('should be a subclass of Page Entity', () {
    expect(testWikiPage, isA<PageEntity>());
  });

  test('should return a valid model from json', () async {
    final Map<String, dynamic> jsonMap =
        jsonDecode(readJson('helpers/dummy_data/dummy_wiki_response.json'))[
                'query']['pages']
            .first;
    final result = PageModel.fromJson(jsonMap);

    expect(result, testWikiPage);
  });
}
