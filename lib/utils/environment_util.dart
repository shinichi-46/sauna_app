enum BuildType {
  Product,
  Develop
}

class EnvironmentUtil {
  static BuildType getBuildType() {
    const type = String.fromEnvironment('BuildType');
    switch (type) {
      case 'Product':
        return BuildType.Product;
      case 'Develop':
        return BuildType.Develop;
      default:
        return BuildType.Develop;
    }
  }
}