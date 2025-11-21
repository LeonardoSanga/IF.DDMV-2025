import 'dart:async';
import 'dart:convert';
import 'dart:collection';
import 'dart:math';

// Passo 1
Future<String> buscarUsuarios() async {
  return await Future.delayed(Duration(seconds: 2), () {
    return '''
    [
      {"nome": "Leonardo", "idade": 22, "cidade": "Fernandópolis"},
      {"nome": "Otair", "idade": 66, "cidade": "São Francisco"},
      {"nome": "Silveria", "idade": 65, "cidade": "São Francisco"},
      {"nome": "Gabriel", "idade": 25, "cidade": "Votuporanga"},
      {"nome": "Ariane", "idade": 21, "cidade": "Araraquara"}
    ]
    ''';
  });
}

Future<void> main() async {
  print("Aguardando dados...");

  // Passo 2
  String jsonString = await buscarUsuarios();
  List<dynamic> usuarios = jsonDecode(jsonString);

  // Passo 3
  int totalUsuarios = usuarios.length;

  HashSet<String> cidades = HashSet();
  int somaIdades = 0;

  for (var usuario in usuarios) {
    cidades.add(usuario["cidade"]);
    somaIdades += (usuario["idade"] as num).toInt();
  }

  double mediaIdades = somaIdades / totalUsuarios;

  // Passo 4
  Random random = Random();
  int indice = random.nextInt(totalUsuarios);
  Map<String, dynamic> usuarioDestaque = usuarios[indice];

  // Passo 5
  print("\nRelatório de Usuários:");
  print("-------------------------");
  print("Total de usuários: $totalUsuarios");
  print("Número de cidades únicas: ${cidades.length}");
  print("Idade média: ${mediaIdades.toStringAsFixed(1)} anos");
  print("-------------------------");
  print("Usuário em Destaque:");
  print("Nome: ${usuarioDestaque['nome']}");
  print("Idade: ${usuarioDestaque['idade']}");
  print("Cidade: ${usuarioDestaque['cidade']}");
}