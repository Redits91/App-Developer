import 'package:http/http.dart' as http;

//local
String url =  "http://24.24.25.232/sloopy_hr/service/";

//live
// String url =  "https://sloopy.in/hrms/2425/service/";
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

Future<http.Response> GetGrade(userId) async {
  var uri = Uri.parse(url + "service_hr_general.php?key=$key&s=31&user_id=$userId");
  print("Debug url : " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

Future<http.Response> GetRefrence(userId) async {
  var uri = Uri.parse(url + "service_hr_general.php?key=$key&s=30&user_id=$userId");
  print("Debug url : " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

Future<http.Response> GetState(userId) async {
  var uri = Uri.parse(url + "service_hr_general.php?key=$key&s=32&user_id=$userId");
  print("Debug url : " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

Future<http.Response> GetHeadQuarter(userId) async {
  var uri = Uri.parse(url + "service_hr_general.php?key=$key&s=33&user_id=$userId");
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

Future<http.Response> GetAttendanceData(branch_id,type,date,ll,ul) async {
  var uri = Uri.parse(url + "service_hr_general.php?key=$key&s=24&branch_id=$branch_id&type=$type&date=$date&ll=$ll&ul=$ul");
  print("Debug url : " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

Future<http.Response> GetAttendanceDataforCanteen(branch_id,canteen_type,date,ll,ul) async {
  var uri = Uri.parse(url + "service_hr_general.php?key=$key&s=27&branch_id=$branch_id&canteen_type=$canteen_type&date=$date&ll=$ll&ul=$ul");
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

Future<http.Response> AddEmployee(user_id,emp_name,branch_id,grade_id,reference_id,state_id,headquarter_id,father,gender,marital_status,
    date_of_birth,contact_number,emergency_number,email,nationality,aadhar_no,pan_no,current_address,permanent_address) async {
  var uri = Uri.parse(url + "service_hr_general.php?key=$key&s=35&"
      "user_id=$user_id"
      "&emp_name=$emp_name"
      "&branch_id=$branch_id"
      "&grade_id=$grade_id"
      "&reference_id=$reference_id"
      "&state_id=$state_id"
      "&headquarter_id=$headquarter_id"
      "&father=$father"
      "&gender=$gender"
      "&marital_status=$marital_status"
      "&date_of_birth=$date_of_birth"
      "&contact_number=$contact_number"
      "&emergency_number=$emergency_number"
      "&email=$email"
      "&nationality=$nationality"
      "&aadhar_no=$aadhar_no"
      "&pan_no=$pan_no"
      "&current_address=$current_address"
      "&permanent_address=$permanent_address"
  );
  print("Debug url : " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

Future<http.Response> GetEmployee(user_id,ll,ul) async {
  var uri = Uri.parse(url + "service_hr_general.php?key=$key&s=34&user_id=$user_id&ll=$ll&ul=$ul");
  print("Debug url : " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

Future<http.Response> GetEmployeebyid(user_id,id) async {
  var uri = Uri.parse(url + "service_hr_general.php?key=$key&s=34&user_id=$user_id&id=$id");
  print("Debug url : " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

Future<http.Response> GetEmployeeFiltter(user_id,branch_id,search) async {
  var uri = Uri.parse(url + "service_hr_general.php?key=$key&s=34&user_id=$user_id&branch_id=$branch_id&search=$search");
  print("Debug url : " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}