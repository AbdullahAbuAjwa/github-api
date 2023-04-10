import 'package:dio/dio.dart';
import '../Helper/constants.dart';
import '../model/repo_info.dart';
import '../model/repository.dart';

class AppController {
  AppController._();

  static AppController appController = AppController._();
  Dio dio = Dio();

  Future<List<Repository>> getAllRepos(int since) async {
    final response = await dio.get(
      '${AppShared.baseUrl}repositories?since=$since',
      options: Options(headers: AppShared.header),
    );
    final List<dynamic> reposJson = response.data;
    final repositories =
        reposJson.map((data) => Repository.fromJson(data)).toList();
    // log('success');
    return repositories;
  }

  Future<RepoInfo> searchRepos(String text, int page) async {
    final response = await dio.get(
      '${AppShared.baseUrl}search/repositories?q=$text&page=$page&sort=stars',
      options: Options(headers: AppShared.header),
    );
    RepoInfo repo = RepoInfo.fromJson(response.data);
    // log(response.data.toString());
    return repo;
  }

  Future<Repository> getRepo(String repoName) async {
    final response = await dio.get(
      '${AppShared.baseUrl}repos/$repoName',
      options: Options(headers: AppShared.header),
    );
    Repository repository = Repository.fromJson(response.data);
    // log(response.data.toString());
    return repository;
  }
}
