import 'dart:math';
import 'package:flutter/material.dart';

// --- INÍCIO DA LÓGICA PRINCIPAL ---
// Controladores e Variáveis de Estado
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const JogoNumeroPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class JogoNumeroPage extends StatefulWidget {
  const JogoNumeroPage({Key? key}) : super(key: key);

  @override
  State<JogoNumeroPage> createState() => _JogoNumeroPageState();
}

class _JogoNumeroPageState extends State<JogoNumeroPage> {
  final _controller = TextEditingController();
  int _numeroSecreto = 0;
  String _mensagemFeedback =
      'Eu pensei em um número entre 1 e 100. Tente adivinhar!';
  bool _jogoFinalizado = false;
  // O método initState() é chamado quando o widget é criado.
  // Perfeito para iniciar nosso jogo pela primeira vez.
  @override
  void initState() {
    super.initState();
    _iniciarJogo();
  }

  // Reseta o jogo para seu estado inicial e gera um novo número secreto.
  void _iniciarJogo() {
    setState(() {
      _numeroSecreto = Random().nextInt(100) + 1; // Gera um número de 1 a 100
      _mensagemFeedback =
          'Eu pensei em um número entre 1 e 100. Tente adivinhar!';
      _jogoFinalizado = false;
      _controller.clear();
    });
  }

  // Esta é a função de callback principal, chamada pelo botão "Verificar".
  void _verificarPalpite() {
    // Lemos o palpite do controller e tentamos convertê-lo para um número.
    final int? palpite = int.tryParse(_controller.text);
    if (palpite == null) {
      // Se o campo estiver vazio ou o texto não for um número válido.
      setState(() {
        _mensagemFeedback = 'Por favor, insira um número válido.';
      });
      return; // Encerra a função aqui.
    }
    // Comparamos o palpite com o número secreto e atualizamos o estado.
    setState(() {
      if (palpite > _numeroSecreto) {
        _mensagemFeedback = 'Muito alto! Tente um número menor.';
      } else if (palpite < _numeroSecreto) {
        _mensagemFeedback = 'Muito baixo! Tente um número maior.';
      } else {
        _mensagemFeedback = 'Parabéns! Você acertou o número $_numeroSecreto!';
        _jogoFinalizado = true;
      }
      _controller.clear();
    });
  }

  // Não se esqueça de limpar o controller no dispose!
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // aqui você monta sua interface
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text('Adivinhe o Número'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            color: Colors.pink.shade50,
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.all(24),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Ícone de cabeça/engrenagem
                  Icon(Icons.psychology_alt,
                      size: 60, color: Colors.blue.shade700),

                  const SizedBox(height: 16),
                  const Text(
                    'Adivinhe o Número Secreto!',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _mensagemFeedback,
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // Campo de palpite
                  TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Seu palpite',
                      border: OutlineInputBorder(),
                    ),
                    enabled: !_jogoFinalizado,
                  ),
                  const SizedBox(height: 24),

                  // Botão verificar
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _jogoFinalizado ? null : _verificarPalpite,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text(
                        'VERIFICAR',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  if (_jogoFinalizado) ...[
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: _iniciarJogo,
                      child: const Text('Novo Jogo'),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// --- FIM DA LÓGICA PRINCIPAL ---