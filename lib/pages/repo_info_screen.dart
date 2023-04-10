import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_api/provider/repo_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class RepoInfoScreen extends StatefulWidget {
  const RepoInfoScreen({super.key});

  @override
  State<RepoInfoScreen> createState() => _RepoInfoScreenState();
}

class _RepoInfoScreenState extends State<RepoInfoScreen> {
  late String repoName;

  @override
  void didChangeDependencies() {
    repoName = ModalRoute.of(context)!.settings.arguments as String;
    context.read<RepositoryProvider>().getRepo(context, repoName);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(repoName),
      ),
      body: Consumer<RepositoryProvider>(builder: (context, provider, _) {
        var repo = provider.repository;
        if (repo == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 22.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CachedNetworkImage(
                      imageUrl: repo.owner!.avatarUrl!, height: 150.h),
                  SizedBox(height: 22.h),
                  Text(
                    repo.name!,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'by ${repo.owner!.login}',
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    repo.description ?? '',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Forks',
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            repo.forksCount.toString(),
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Issues',
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            repo.openIssues.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      if (repo.language != null)
                        Column(
                          children: [
                            Text(
                              'Language',
                              style: TextStyle(
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              repo.language!,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  SizedBox(height: 22.h),
                  ElevatedButton(
                    onPressed: () async {
                      final Uri url = Uri.parse(repo.htmlUrl!);
                      if (!await launchUrl(url)) {
                        throw 'Could not launch $url';
                      }
                    },
                    child: const Text('View on GitHub'),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
