import 'package:shared_preferences/shared_preferences.dart';

import 'AESCrypt.dart';

class MyPreferences {
  static const String PreferenceName = "primate";
  static const String EncraptionKey = "primate@2442";

  static const String System_user_login_id = "user_id";
  static const String System_user_login_name = "username";
  static const String welcomeScreen = "welcomeScreen";
  static const String emp_id = "emp_id";
  static const String emp_code = "emp_code";
  static const String login_user_type = "type";
  static const String branch_id = "branch_id";
  static const String selfattendance_qr_vallue = "selfattendance_qr_vallue";
  static const String attendance_flag = "attendance_flag";
  static const String myqrcode = "myqrcode";
  static const String working_hour = "working_hour";
  static const String device_token = "device_token";


  // app_attendance_out rights
  static const String app_attendance_out_view_flag = "view_flag", app_attendance_out_insert_flag = "insert_flag", app_attendance_out_update_flag = "update_flag",
                      app_attendance_out_delete_flag = "delete_flag", app_attendance_out_export_flag = "export_flag", app_attendance_out_print_flag = "print_flag",
                      app_attendance_out_page_id = "page_id", app_attendance_out_page_slug = "page_slug", app_attendance_out_page_name = "page_name";

  // app_attendance_in rights
  static const String app_attendance_in_view_flag = "view_flag",app_attendance_in_insert_flag = "insert_flag", app_attendance_in_update_flag = "update_flag",
                      app_attendance_in_delete_flag = "delete_flag",app_attendance_in_export_flag = "export_flag",app_attendance_in_print_flag = "print_flag",
                      app_attendance_in_page_id = "page_id", app_attendance_in_page_slug = "page_slug",app_attendance_in_page_name = "page_name";

  // app_report rights
  static const String report_view_flag = "view_flag", report_insert_flag = "insert_flag", report_update_flag = "update_flag",
                      report_delete_flag = "delete_flag", report_export_flag = "export_flag", report_print_flag = "print_flag",
                      report_page_id = "page_id", report_page_slug = "page_slug", report_page_name = "page_name";

  //app_canteen_in Rights
  static const String app_canteen_in_view_flag = "view_flag", app_canteen_in_insert_flag = "insert_flag", app_canteen_in_update_flag = "update_flag",
                      app_canteen_in_delete_flag = "delete_flag", app_canteen_in_export_flag = "export_flag", app_canteen_in_print_flag = "print_flag",
                      app_canteen_in_page_id = "page_id", app_canteen_in_page_slug = "page_slug", app_canteen_in_page_name = "page_name";

  //app_employee rights
  static const String app_employee_view_flag = "view_flag", app_employee_insert_flag = "insert_flag", app_employee_update_flag = "update_flag",
      app_employee_delete_flag = "delete_flag", app_employee_export_flag = "export_flag", app_employee_print_flag = "print_flag",
      app_employee_page_id = "page_id", app_employee_page_slug = "page_slug", app_employee_page_name = "page_name";

  // app_self_attendance rights
  static const String app_self_attendance_view_flag = "view_flag", app_self_attendance_insert_flag = "insert_flag", app_self_attendance_update_flag = "update_flag",
                      app_self_attendance_delete_flag = "delete_flag", app_self_attendance_export_flag = "export_flag", app_self_attendance_print_flag = "print_flag",
                      app_self_attendance_page_id = "page_id",app_self_attendance_page_slug = "page_slug", app_self_attendance_page_name = "page_name";



  //app_out_side_attendance rights
  static const String app_out_side_view_flag = "view_flag", app_out_side_insert_flag = "insert_flag", app_out_side_update_flag = "update_flag",
      app_out_side_delete_flag = "delete_flag", app_out_side_export_flag = "export_flag", app_out_side_print_flag = "print_flag",
      app_out_side_page_id = "page_id", app_out_side_page_slug = "page_slug", app_out_side_page_name = "page_name";






  Future<String> getPreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encryptedValue = prefs.getString(key) ?? '';
    try {
      return AESCrypt.decrypt(EncraptionKey, encryptedValue);
    } catch (e) {
      print('Error decrypting preferences: $e');
      return '';
    }
  }

  Future<void> setPreferences(String key, String value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, AESCrypt.encrypt(EncraptionKey, value));
    } catch (e) {
      print('Error encrypting preferences: $e');
    }
  }

  Future<bool> clearPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return await prefs.clear();
    } catch (e) {
      print('Error clearing preferences: $e');
      return false;
    }
  }
}
