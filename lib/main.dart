import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MaterialApp(
    home: TelaPreferencias(),
    debugShowCheckedModeBanner: false,
  )); // MaterialApp
}

class TelaPreferencias extends StatefulWidget {
  const TelaPreferencias({super.key});

  @override
  State<TelaPreferencias> createState() =>
      _TelaPreferenciasState();
}

class _TelaPreferenciasState extends State<TelaPreferencias> {
  final TextEditingController nomeController =
      TextEditingController();

  String nomeSalvo = '';

  Future<void> salvarNome() async {
    final preferencias = await SharedPreferences.getInstance();

    await preferencias.setString(
      'nomeUsuario',
      nomeController.text,
    );

    setState(() {
      nomeSalvo = nomeController.text;
    });
  }

  Future<void> carregarNome() async {
    final preferencias = await SharedPreferences.getInstance();

    setState(() {
      nomeSalvo = preferencias.getString('nomeUsuario') ?? '';
      nomeController.text = nomeSalvo;
    });
  }

  @override
  void initState() {
    super.initState();
    carregarNome();
  }

  @override
  void dispose() {
    nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preferências')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Digite seu nome',
              ), // InputDecoration
            ), // TextField

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: salvarNome,
              child: const Text('Salvar nome'),
            ), // ElevatedButton

            const SizedBox(height: 15),

            Text('Nome salvo: $nomeSalvo'),
          ],
        ), // Column
      ), // Padding
    ); // Scaffold
  }
}