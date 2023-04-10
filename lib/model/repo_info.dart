import 'package:github_api/model/repository.dart';

class RepoInfo {
  RepoInfo({
    this.totalCount,
    this.incompleteResults,
    this.items,
  });

  final int? totalCount;
  final bool? incompleteResults;
  final List<Repository>? items;

  // factory RepoInfo.fromJson(String str) => RepoInfo.fromMap(json.decode(str));

  factory RepoInfo.fromJson(Map<String, dynamic> json) => RepoInfo(
        totalCount: json["total_count"],
        incompleteResults: json["incomplete_results"],
        items: json["items"] == null
            ? []
            : List<Repository>.from(
                json["items"]!.map((x) => Repository.fromJson(x))),
      );
}
