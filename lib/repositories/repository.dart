import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Repository {
  static Future<Map<String,dynamic>> pegarDados() async {
    await dotenv.load(fileName: "keys.env");
    Uri url = Uri.parse('https://api.hgbrasil.com/finance?key=${dotenv.env['API_KEY']}');
    final resposta = await http.get(url);
    return jsonDecode(resposta.body);
  }
}
