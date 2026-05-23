
import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/config/utils/constants.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class UserHelper {
  final SharedPreferences _prefs;
  final FlutterSecureStorage _fss;
  UserHelper(this._prefs, this._fss);
  bool isLogin() => _prefs.getString(Apikeys.userId) != null;
  Future<void> clearUserData() async {
    final lang = _prefs.getString(AppConstants.languageCode);
    await _prefs.clear();
    if (lang != null) await _prefs.setString(AppConstants.languageCode, lang);
    await _fss.deleteAll();
    await DefaultCacheManager().emptyCache();
  }
}
