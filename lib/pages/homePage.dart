import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            Icon(Icons.monetization_on, size: 200,),
            TextField(
              decoration: InputDecoration(label: Text("Real R\$")),
            ),
            TextField(
              decoration: InputDecoration(label: Text("Dolar US\$")),
            ),
            TextField(
              decoration: InputDecoration(label: Text("Euro €")),
            )
          ],
        ),
      ),
    );
  }
}
