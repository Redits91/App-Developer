import 'package:http/http.dart' as http;

String url =  "http://24.24.25.232/sloopy_hr/service/";
String key = '1226';

Future<http.Response> LoginUser(username, password, unique_no) async {
  var uri = Uri.parse(url + "service_hr_user.php?key=$key&s=21&username=$username&password=$password&unique_no=$unique_no");
  print("Debug url : " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

Future<http.Response> LogoutUser(userId, type, unique_no) async {
  var uri = Uri.parse(url + "service_hr_user.php?key=$key&s=37&user_id=$userId&user_type=$type&unique_no=$unique_no");
  print("Debug url : " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

Future<http.Response> GetBanner(userId, type, unique_no) async {
  var uri = Uri.parse(url + "service_hr_user.php?key=$key&s=28&user_id=$userId&type=$type&unique_no=$unique_no");
  print("Debug url : " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

Future<http.Response> GetBranch(userId) async {
  var uri = Uri.parse(url + "service_hr_general.php?key=$key&s=23&user_id=$userId");
  print("Debug url : " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

Future<http.Response> GetCategory() async {
  var uri = Uri.parse(url + "service_hr_general.php?key=$key&s=25");
  print("Debug url : " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

Future<http.Response> GetAttendanceINData(branch_id,type,ll,ul) async {
  var uri = Uri.parse(url + "service_hr_general.php?key=$key&s=24&branch_id=$branch_id&type=$type&ll=$ll&ul=$ul");
  print("Debug url : " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

Future<http.Response> GetAttendanceOutData(branch_id,type,ll,ul) async {
  var uri = Uri.parse(url + "service_hr_general.php?key=$key&s=24&branch_id=$branch_id&type=$type&ll=$ll&ul=$ul");
  print("Debug url : " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

Future<http.Response> ScanQRforAttendanceIN(unique_qr_no,type,branch_id) async {
  var uri = Uri.parse(url + "service_hr_user.php?key=$key&s=22&unique_qr_no=$unique_qr_no&type=$type&branch_id=$branch_id");
  print("Debug url : " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}
