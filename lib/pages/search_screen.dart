import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_api/provider/repo_provider.dart';
import 'package:github_api/widgets/repo_card.dart';
import 'package:provider/provider.dart';

class SearchScreen extends HookWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Provider.of<RepositoryProvider>(context, listen: false)
                  .filteresRepositories = [];
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Container(
            height: 45.h,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
            child: CupertinoSearchTextField(
              autofocus: true,
              controller: searchController,
              keyboardType: TextInputType.text,
              onSubmitted: (value) {
                FocusScope.of(context).unfocus();
                context
                    .read<RepositoryProvider>()
                    .searchRepositories(context, searchController);
              },
              placeholder: 'What would you like to learn today?',
              // padding: EdgeInsets.all(7.r),
              borderRadius: BorderRadius.all(Radius.circular(5.r)),
              backgroundColor: Colors.white,
              autocorrect: false,
            ),
          ),
        ),
      ),
      body: Consumer<RepositoryProvider>(
        builder: (context, provider, _) {
          if (provider.filteresRepositories == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return provider.filteresRepositories!.isEmpty
                ? const SizedBox()
                : ListView.separated(
                    itemCount: provider.filteresRepositories!.length,
                    itemBuilder: (context, index) {
                      var data = provider.filteresRepositories![index];
                      return Column(
                        children: [
                          RepoCard(data),
                          if (index ==
                                  provider.filteresRepositories!.length - 1 &&
                              provider.filteresRepositories!.length >= 30)
                            TextButton(
                                onPressed: () {
                                  provider
                                      .loadMoreRepositories(searchController);
                                },
                                child: const Text('Load more'))
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    });
          }
        },
      ),
    );
  }
}
