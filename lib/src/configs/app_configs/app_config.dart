class AppConfig {
  const AppConfig({
    required this.flavor,
    required this.baseUrl,
  });
  final String flavor;
  final String baseUrl;

  static const String flavorKey = 'FLAVOR';
  static const String baseURLKey = 'BASE_URL';

  factory AppConfig.init() {
    const flavor = String.fromEnvironment(flavorKey);
    const baseUrl = String.fromEnvironment(baseURLKey);
    return const AppConfig(
      flavor: flavor,
      baseUrl: baseUrl,
    );
  }
}
