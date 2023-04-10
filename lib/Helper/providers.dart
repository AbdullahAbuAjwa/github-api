import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../provider/repo_provider.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider.value(value: RepositoryProvider()),
];
