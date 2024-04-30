import 'dart:convert';

import 'package:freo_assignment/core/error/faliure.dart';
import 'package:freo_assignment/features/wiki/data/model/page_model.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/resources/data_state.dart';

import 'package:http/http.dart' as http;

abstract class WikiRemoteDataSource {
  Future<DataState<List<PageModel>>> searchWiki(String query);
}

class WikiRemoteDataSourceImpl implements WikiRemoteDataSource {
  final http.Client client;
  WikiRemoteDataSourceImpl(this.client);

  @override
  Future<DataState<List<PageModel>>> searchWiki(String query) async {
    try {
      final response =
          await client.get(Uri.parse(Urls.searchWikiByQuery(query)));

      if (response.statusCode == 200) {
        List<PageModel> pageModel = [];
        for (var element in (jsonDecode(response.body)['query']['pages'])) {
          pageModel.add(PageModel.fromJson(element));
        }
        return DataSuccess(pageModel);
      } else {
        return DataFailed(ServerFaliure(response.body));
      }
    } on http.ClientException catch (ex) {
      return DataFailed(ServerFaliure(ex.message));
    }
  }
}
