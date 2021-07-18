import 'package:shared_preferences/shared_preferences.dart';

class PrefsKey {
  SharedPreferences prefs ;
  int userid ;

  void getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
  }
  void savePatientCardId(int patientCardid) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt("pasien_card_id", patientCardid);
  }


}