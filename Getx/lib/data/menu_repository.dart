class MenuRepository {
  MenuRepository._internal();
  static MenuRepository _instance = MenuRepository._internal();
  factory MenuRepository() => _instance;

  int getDatatest(int num1, int num2) => num1 + num2;

  test() {
    print('object');
  }
}
