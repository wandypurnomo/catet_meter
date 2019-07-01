import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future persistToken({@required String token}) async {
  await SharedPreferences.getInstance().then((SharedPreferences p) async {
    await p.setString("token", token);
  });
}

Future<String> getToken() async {
  return await SharedPreferences.getInstance().then((SharedPreferences p) {
    return p.getString("token");
  });
}

Future removeToken() async {
  await SharedPreferences.getInstance().then((SharedPreferences p) async {
    await p.remove("token");
  });
}

Future<bool> tokenExists() async {
  return SharedPreferences.getInstance().then((SharedPreferences p) {
    String token = p.getString("token");
    return token != null;
  });
}
