import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<void> salvarArquivo(String conteudo) async {
  final diretorio = await getApplicationDocumentsDirectory();

  final arquivo = File('${diretorio.path}/relatorio.txt');

  await arquivo.writeAsString(conteudo);
}

Future<String> lerArquivo() async {
  final diretorio = await getApplicationDocumentsDirectory();

  final arquivo = File('${diretorio.path}/relatorio.txt');

  if (await arquivo.exists()) {
    final conteudo = await arquivo.readAsString();
    return conteudo;
  } else {
    return 'Arquivo não encontrado.';
  }
}