
# Github API

Application that handle with Github repositories fetched from the Github API.

The app contain four pages:
- **Splash Screen**
- **Home screen** that shows a list of Github repositories fetched from the Github API endpoint  `https://api.github.com/repositories?since=${number}`
- **Search screen** that allows the user to search for Github repositories using the Github API endpoint `https://api.github.com/search/repositories?q=${text}&sort=stars`, which displays data sorted by highest stars.
- **Repository details screen** that displays information about the selected repository using indpoint `https://api.github.com/repos/${repoName}`
## Features
-   **`Hooks`** to increase performance and code reuse.
-   **`Pagination`** in the home and search screens to improve performance and reduce the amount of data fetched from the API.
-   **`Responsive layout`**.
- **`Cached images`**.

## Dependencies

-   `Dio` package for making HTTP requests to the Github API.
-   `flutter_hooks` Flutter hooks are a powerful tool for increasing performance and code reuse.
-   `cached_network_image` package for caching images fetched from the  API.
-   `flutter_screenutil` package for creating responsive layouts.
- `url_launcher` to launch repository links in a web browser.
- `provider` package for state management.