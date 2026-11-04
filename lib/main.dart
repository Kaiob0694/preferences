import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


// NOVO: Importa as funções de salvar e ler arquivos
import 'arquivo_dados.dart';


void main() {
  runApp(
    const MaterialApp(
      home: TelaPreferencias(),
      debugShowCheckedModeBanner: false,
    ),
  );
}


class TelaPreferencias extends StatefulWidget {
  const TelaPreferencias({super.key});


  @override
  State<TelaPreferencias> createState() => _TelaPreferenciasState();
}


class _TelaPreferenciasState extends State<TelaPreferencias> {
  final TextEditingController nomeController = TextEditingController();


  String nomeSalvo = '';


  // NOVO: Controller para digitar o conteúdo do relatório
  final TextEditingController relatorioController = TextEditingController();


  // NOVO: Variável para armazenar o conteúdo lido do arquivo
  String conteudoArquivo = '';


  // SHARED PREFERENCES


  Future<void> salvarNome() async {
    final preferencias = await SharedPreferences.getInstance();


    await preferencias.setString('nomeUsuario', nomeController.text);


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


  // NOVO: Função que envia o texto para ser salvo no arquivo
  Future<void> salvarRelatorio() async {
    await salvarArquivo(relatorioController.text);
  }


  // NOVO: Função que recupera o conteúdo do arquivo
  Future<void> carregarRelatorio() async {
    final conteudo = await lerArquivo();


    setState(() {
      conteudoArquivo = conteudo;
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


    // NOVO: Libera o controller do relatório
    relatorioController.dispose();


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
              decoration: const InputDecoration(labelText: 'Digite seu nome'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: salvarNome,
              child: const Text('Salvar nome'),
            ),
            Text('Nome salvo: $nomeSalvo'),


            // NOVO: Campo para digitar o relatório
            const Divider(height: 40),
            const Text(
              'Armazenamento em arquivos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),


            TextField(
              controller: relatorioController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Digite o relatório',
                border: OutlineInputBorder(),
              ),
            ),


            const SizedBox(height: 15),


            // NOVO: Botão para salvar o relatório no arquivo TXT
            ElevatedButton(
              onPressed: salvarRelatorio,
              child: const Text('Salvar relatório'),
            ),

            


            // NOVO: Botão para ler o arquivo TXT
            ElevatedButton(
              onPressed: carregarRelatorio,
              child: const Text('Ler relatório'),
            ),

            const SizedBox(height: 15),


            // NOVO: Exibe na tela o conteúdo recuperado
            Text('Conteúdo do arquivo: $conteudoArquivo'),
          ],
        ),
      ),
    );
  }
}