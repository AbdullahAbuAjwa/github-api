import 'package:flutter/material.dart';
import 'package:github_api/pages/home_screen.dart';
import 'package:github_api/pages/repo_info_screen.dart';

import '../pages/search_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/home': (ctx) => const HomeScreen(),
  '/search': (ctx) => const SearchScreen(),
  '/repoInfo': (ctx) => const RepoInfoScreen(),
};
