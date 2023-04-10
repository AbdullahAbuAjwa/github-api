import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/repository.dart';

class RepoCard extends StatelessWidget {
  final Repository repository;
  const RepoCard(this.repository, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, '/repoInfo',
              arguments: repository.fullName);
        },
        leading: CircleAvatar(
          radius: 35.r,
          backgroundImage:
              CachedNetworkImageProvider(repository.owner!.avatarUrl!),
        ),
        title: Text(
          repository.fullName!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(getDescroptin()!),
      ),
    );
  }

  String? getDescroptin() {
    if (repository.description == null) {
      return '';
    }
    if (repository.description!.length > 70) {
      return '${repository.description!.substring(0, 70)}... read more';
    } else {
      return repository.description!;
    }
  }
}
