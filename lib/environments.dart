enum Environments { DEVELOPER, TEST, PRODUCTION }

class EnvironmentConfig {
  static Environments? environmentBuild;

  static String urlsConfig() {
    switch (environmentBuild) {
      case Environments.DEVELOPER:
        return "https://pokeapi.co/api/v2/";
      case Environments.TEST:
        return "https://pokeapi.co/api/v2/";
      case Environments.PRODUCTION:
        return "https://pokeapi.co/api/v2/";
      default:
        return "https://pokeapi.co/api/v2/";
    }
  }
}
