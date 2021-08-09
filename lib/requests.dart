import 'package:http/http.dart' as http;
import 'dart:convert';

const String url = "http://mass-rickroll.host.qrl.nz:3000";

void launchRickroll() {
  http.get(Uri.parse("$url/rick"));
}

Future<int> getOnline() async {
  var response = await http.get(Uri.parse("$url/active"));
  return jsonDecode(response.body)["active"];
}
