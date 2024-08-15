import 'package:http/http.dart' as http;

class Repository {

void pegarDados(){
  Uri url = Uri.parse('https://api.hgbrasil.com/finance?key=86c89543');
  final resposta = http.get(url);
}
}