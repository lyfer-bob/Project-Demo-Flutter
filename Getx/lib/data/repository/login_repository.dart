import '../../models/index.dart';

abstract class LoginRepository {
  Future<dynamic> requestLogin(Login login);
  // Future<Loginmodel> requestLogins(Loginmodel login);
  // Future<Paging> fetchNewsByCategory(String keyword, int page, int pageSize);
}
