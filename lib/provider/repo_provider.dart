import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../controller/app_controller.dart';
import '../model/repository.dart';

class RepositoryProvider with ChangeNotifier {
  List<Repository>? repositories = [];
  List<Repository>? filteresRepositories = [];
  Repository? repository;
  int currentPage = 1;

  Future<void> fetchRepositories(context, {int since = 0}) async {
    try {
      final repo = await AppController.appController.getAllRepos(since);
      repositories!.addAll(repo);
    } on DioError catch (error) {
      handleDioError(context, error);
    }
    notifyListeners();
  }

  Future<void> searchRepositories(context, TextEditingController search,
      {int page = 1}) async {
    if (search.text.trim().isEmpty) return;
    try {
      filteresRepositories = null;
      final repos = await AppController.appController
          .searchRepos(search.text.trim(), page);
      filteresRepositories = repos.items;
    } on DioError catch (error) {
      handleDioError(context, error);
    }
    notifyListeners();
  }

  refreshHomePage(context, scrollController) async {
    repositories = [];
    await fetchRepositories(context).then((value) {
      const snackBar = SnackBar(
        behavior: SnackBarBehavior.fixed,
        dismissDirection: DismissDirection.horizontal,
        content: Text(
          'Refresh Done!',
          style: TextStyle(fontSize: 16),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }).then((value) {
      scrollController.animateTo(0.0,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  Future<void> loadMoreRepositories(TextEditingController search) async {
    final nextPage = currentPage + 1;
    final newData =
        await AppController.appController.searchRepos(search.text, nextPage);
    filteresRepositories!.addAll(newData.items!);
    notifyListeners();
    currentPage = nextPage;
  }

  Future<void> getRepo(context, repoName) async {
    try {
      repository = null;
      repository = await AppController.appController.getRepo(repoName);
      notifyListeners();
    } on DioError catch (error) {
      handleDioError(context, error);
    }
    notifyListeners();
  }

  void handleDioError(BuildContext context, DioError error) {
    debugPrint('ee: ${error.response!.data}');
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.fixed,
      dismissDirection: DismissDirection.horizontal,
      content: Text(
        error.response!.data['message'],
        style: const TextStyle(fontSize: 16),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
