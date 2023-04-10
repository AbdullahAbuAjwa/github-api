import 'owner.dart';

class Repository {
  Repository({
    this.id,
    this.nodeId,
    this.name,
    this.fullName,
    this.private,
    this.owner,
    this.htmlUrl,
    this.description,
    this.url,
    this.forksCount,
    this.language,
    this.openIssues,
  });

  final int? id;
  final String? nodeId;
  final String? name;
  final String? fullName;
  final bool? private;
  final Owner? owner;
  final String? htmlUrl;
  final String? description;
  final String? url;
  final int? forksCount;
  final String? language;
  final int? openIssues;

  // factory Repository.fromJson(String str) =>
  //     Repository.fromMap(json.decode(str));

  factory Repository.fromJson(Map<String, dynamic> json) => Repository(
        id: json["id"],
        nodeId: json["node_id"],
        name: json["name"],
        fullName: json["full_name"],
        private: json["private"],
        owner: json["owner"] == null ? null : Owner.fromMap(json["owner"]),
        htmlUrl: json["html_url"],
        description: json["description"],
        url: json["url"],
        forksCount: json["forks_count"],
        language: json["language"] ?? '',
        openIssues: json["open_issues"],
      );
}
