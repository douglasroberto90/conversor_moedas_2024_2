import 'package:flutter/material.dart';
import 'package:conversor_moedas_2024_2/repositories/repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controllerReal = TextEditingController();
  TextEditingController controllerDolar = TextEditingController();
  TextEditingController controllerEuro = TextEditingController();

  late double cotacaoDolar;
  late double cotacaoEuro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conversor de moedas"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Icon(
              Icons.monetization_on,
              size: 200,
            ),
            FutureBuilder(
                future: Repository.pegarDados(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                          child: Text(
                        "Aguardando dados",
                        style: TextStyle(fontSize: 20),
                      ));
                    default:
                      if (snapshot.hasError) {
                        return Center(
                            child: Text(
                          "Ocorreu um erro",
                          style: TextStyle(fontSize: 20),
                        ));
                      } else {
                        cotacaoDolar = snapshot.data?["results"]["currencies"]
                            ["USD"]["buy"];
                        cotacaoEuro = snapshot.data?["results"]["currencies"]
                            ["EUR"]["buy"];
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                              child: TextField(
                                controller: controllerReal,
                                decoration: InputDecoration(
                                    label: Text(
                                      "Real",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    prefix: Text("R\$ ")),
                                keyboardType: TextInputType.number,
                                onChanged: _realAlterado,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                              child: TextField(
                                controller: controllerDolar,
                                decoration: InputDecoration(
                                    label: Text("Dolar",
                                        style: TextStyle(fontSize: 20)),
                                    prefix: Text("US\$ ")),
                                keyboardType: TextInputType.number,
                                onChanged: _dolarAlterado,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                              child: TextField(
                                controller: controllerEuro,
                                decoration: InputDecoration(
                                    label: Text("Euro",
                                        style: TextStyle(fontSize: 20)),
                                    prefix: Text("€ ")),
                                keyboardType: TextInputType.number,
                                onChanged: _euroAlterado,
                              ),
                            ),
                          ],
                        );
                      }
                  }
                })
          ],
        ),
      ),
    );
  }

  void _realAlterado(String texto) {
    if (texto.isEmpty){
      _limparCampos();
    }
    double valorCampoReal = double.parse(controllerReal.text);
    controllerDolar.text = (valorCampoReal / cotacaoDolar).toStringAsFixed(2);
    controllerEuro.text = (valorCampoReal / cotacaoEuro).toStringAsFixed(2);
  }

  void _dolarAlterado(String texto) {
    if (texto.isEmpty){
      _limparCampos();
    }
    double valorCampoDolar = double.parse(texto);
    controllerReal.text = (valorCampoDolar * cotacaoDolar).toStringAsFixed(2);
    controllerEuro.text =
        ((valorCampoDolar * cotacaoDolar) / cotacaoEuro).toStringAsFixed(2);
  }

  void _euroAlterado(String texto) {
    if (texto.isEmpty){
      _limparCampos();
    }
    double valorCampoEuro = double.parse(texto);
    controllerReal.text = (valorCampoEuro * cotacaoEuro).toStringAsFixed(2);
    controllerDolar.text =
        ((valorCampoEuro * cotacaoEuro) / cotacaoDolar).toStringAsFixed(2);
  }

  void _limparCampos(){
    controllerReal.clear();
    controllerDolar.clear();
    controllerEuro.clear();
  }
}
