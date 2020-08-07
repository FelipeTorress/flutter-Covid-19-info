import 'dart:convert';
import 'package:http/http.dart' as http;

class DataCovid {

  static Future<Map> getApiStatus() async{
    http.Response response;
    response = await http.get('https://covid19-brazil-api.now.sh/api/status/v1');

    return json.decode(response.body);
  }

  static Future<Map> getDataStateBrasil(String state) async{
    http.Response response;
    response = await http.get('https://covid19-brazil-api.now.sh/api/report/v1/brazil/uf/$state');

    return json.decode(response.body);
  }

  static Future<Map> getDataBrasil() async{
    http.Response response;
    response = await http.get('https://covid19-brazil-api.now.sh/api/report/v1/brazil');

    return json.decode(response.body);
  }

  static Future<Map> getDataBrasilBySeason(String date) async{
    http.Response response;
    response = await http.get('https://covid19-brazil-api.now.sh/api/report/v1/brazil/$date');

    return json.decode(response.body);
  }

  static Future<Map> getDataWorld() async{
    http.Response response;
    response = await http.get('https://covid19-brazil-api.now.sh/api/report/v1/countries');

    return json.decode(response.body);
  }

}