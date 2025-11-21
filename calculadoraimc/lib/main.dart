import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const CalculadoraIMC(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculadoraIMC extends StatefulWidget {
  const CalculadoraIMC({super.key});
  @override
  State<CalculadoraIMC> createState() => _CalculadoraIMCState();
}

class _CalculadoraIMCState extends State<CalculadoraIMC> {
  // Controladores para ler os valores dos campos de texto.
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();
  // TODO: ETAPA 1 - Declarar as variáveis de estado
  double  _resultadoIMC = 0.0;
  String  _classificacao = '';

  // Comece com valores padrão, como 0.0 e uma string vazia ''.
  void _calcularIMC() {
    // Primeiro, lemos os textos dos controllers.
    final String textoPeso = _pesoController.text;
    final String textoAltura = _alturaController.text;
    // Convertemos os textos para números (double).
    // Usamos double.tryParse para evitar erros se o campo estiver vazio ou inválido.
    final double? peso = double.tryParse(textoPeso);
    final double? altura = double.tryParse(textoAltura);
    // Verificamos se os valores são válidos antes de calcular.
    if (peso != null && altura != null && altura > 0) {
      final double imc = peso / (altura * altura);
      String classificacao = '';
      // Lógica para definir a classificação baseada no valor do imc.
      if (imc < 18.5) {
        classificacao = 'Abaixo do peso';
      } else if (imc < 25) {
        classificacao = 'Peso Normal';
      } else if (imc < 30) {
        classificacao = 'Sobrepeso';
      } else {
        classificacao = 'Obesidade';
      }
      // TODO: ETAPA 2 - Atualizar o estado da aplicação
      setState(() {
        _resultadoIMC = imc;
        _classificacao = classificacao;
        _pesoController.clear();
        _alturaController.clear();
      });
    }
  }

  @override
  void dispose() {
    _pesoController.dispose();
    _alturaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Calculadora de IMC'),
          backgroundColor: Colors.deepPurple,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Campo de texto para o Peso
              TextField(
                controller: _pesoController,
                decoration: const InputDecoration(
                  labelText: 'Peso (kg)',
                  hintText: 'Ex: 70.5',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 20),
              // Campo de texto para a Altura
              TextField(
                controller: _alturaController,
                decoration: const InputDecoration(
                  labelText: 'Altura (m)',
                  hintText: 'Ex: 1.75',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 30),
              // Botão para disparar o cálculo
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                // TODO: ETAPA 3 - Conectar o evento de clique
                onPressed: _calcularIMC, 
                child: const Text(
                  'CALCULAR IMC',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              const SizedBox(height: 30),
              // Área para exibir os resultados
              Center(
                child: Column(
                  children: [
                    Text(
                      // Exibe o resultado formatado com 2 casas decimais.
                      // toStringAsFixed(2) faz a formatação.
                      // TODO: ETAPA 4 - Exibir o resultado
                      'Seu IMC: ${_resultadoIMC.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      // TODO: ETAPA 5 - Exibir a classificação
                      _classificacao,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.deepPurple.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
