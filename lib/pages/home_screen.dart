import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_api/provider/repo_provider.dart';
import 'package:github_api/widgets/repo_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scrollController = ScrollController();

  @override
  void initState() {
    context.read<RepositoryProvider>().fetchRepositories(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Consumer<RepositoryProvider>(
        builder: (context, provider, _) {
          if (provider.repositories == null || provider.repositories!.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: ListView.separated(
                controller: scrollController,
                itemCount: provider.repositories!.length,
                itemBuilder: (context, index) {
                  final repository = provider.repositories![index];
                  return Column(
                    children: [
                      RepoCard(repository),
                      if (index == provider.repositories!.length - 1)
                        TextButton(
                            onPressed: () {
                              provider.fetchRepositories(context,
                                  since: provider.repositories!.last.id!);
                            },
                            child: const Text('Load more'))
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              ),
            );
          }
        },
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      elevation: 0,
      title: const Text('Browse Repositories'),
      leading: IconButton(
        onPressed: () {
          context
              .read<RepositoryProvider>()
              .refreshHomePage(context, scrollController);
        },
        icon: const Icon(Icons.refresh, color: Colors.white),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            )),
      ],
    );
  }
}
