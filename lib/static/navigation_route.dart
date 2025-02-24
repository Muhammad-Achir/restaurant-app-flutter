enum NavigationRoute {
  mainRoute("/"),
  detailRoute("/detail"),
  searchRoute("/search");

  final String name;

  const NavigationRoute(this.name);
}
