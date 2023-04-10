class AppShared {
  static String baseUrl = 'https://api.github.com/';

  static Map<String, dynamic>? header = {
    'Accept': 'application/vnd.github+json',
    'X-GitHub-Api-Version': '2022-11-28'
  };
}
