import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_constant.dart';


class ApiService {
  Uri _u(String p) => Uri.parse('${ApiConstants.baseUrl}$p');
  Map<String,String> _h({String? t}) => {
    'Content-Type':'application/json',
    if (t!=null) 'Authorization':'Bearer $t'
  };

  Future<dynamic> get(String p,{String? token}) async =>
    jsonDecode((await http.get(_u(p),headers:_h(t:token))).body);

  Future<dynamic> post(String p, Map b,{String? token}) async =>
    jsonDecode((await http.post(_u(p),headers:_h(t:token),body:jsonEncode(b))).body);

  Future<dynamic> put(String p, Map b,{required String token}) async =>
    jsonDecode((await http.put(_u(p),headers:_h(t:token),body:jsonEncode(b))).body);

  Future<void> delete(String p,{required String token}) async {
    await http.delete(_u(p),headers:_h(t:token));
  }
}
