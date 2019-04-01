import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shakespeare_sonnet/models/sonnet.dart';

class SonnetAPI {
  static final SonnetAPI _sonnetAPI = new SonnetAPI._internal();
  factory SonnetAPI() {
    return _sonnetAPI;
  }
  SonnetAPI._internal();
  Future<Sonnet> getSonnet(int sonnetNumber) async {
    String _uri = 'http://poetrydb.org/author,title/Shakespeare;${Uri.encodeComponent('Sonnet $sonnetNumber')}:';
    var resp = await http.get(_uri);
    List<dynamic> jsonObj = json.decode(resp.body);
    return Sonnet.fromJson(jsonObj[0]);
  }
}