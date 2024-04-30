import 'package:freo_assignment/features/wiki/data/data_source/remote/wiki_api_service.dart';
import 'package:freo_assignment/features/wiki/domain/repository/wiki_repository.dart';
import 'package:freo_assignment/features/wiki/domain/usecases/get_wiki.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([WikiRepository, WikiRemoteDataSource, GetWikiUseCase],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {}
