import 'dart:async';
import 'package:flutter/material.dart';
// --- MODELOS DE DADOS ---
class CartaMemoria {
 final int id;
 final String imagem;
 bool estaVirada;
 bool foiCombinada;
 CartaMemoria({required this.id, required this.imagem, this.estaVirada = false, this.foiCombinada =
false});
}
class Tema {
 final String nome;
 final IconData icone;
 final List<String> imagens;
 Tema({required this.nome, required this.icone, required this.imagens});
}
// ------------------- MAIN APP -------------------
void main() {
 runApp(const MyApp());
}
class MyApp extends StatelessWidget {
 const MyApp({super.key});
 @override
 Widget build(BuildContext context) {
 return MaterialApp(
 title: 'Jogo da Memória',
 debugShowCheckedModeBanner: false,
 theme: ThemeData(primarySwatch: Colors.purple),

 initialRoute: '/',
 routes: {
  '/': (context) => const TelaMenu(),
  '/jogo': (context) => const TelaJogo(),
 },
 );
 }
}
// ------------------- TELA DE MENU -------------------
class TelaMenu extends StatefulWidget {
 const TelaMenu({super.key});
 @override
 State<TelaMenu> createState() => _TelaMenuState();
}
class _TelaMenuState extends State<TelaMenu> {
 // Dados dos temas e dificuldades
 final List<Tema> _temas = [
 Tema(nome: 'Animais', icone: Icons.pets, imagens: List.generate(8, (i) => 'assets/images/animais/${i
+ 1}.jpg')),
 Tema(nome: 'Frutas', icone: Icons.apple, imagens: List.generate(8, (i) => 'assets/images/frutas/${i +
1}.jpg')),
 ];
 final Map<String, int> _dificuldades = {'Fácil': 8, 'Médio': 12, 'Difícil': 16};
 String? _temaSelecionado;
 int? _dificuldadeSelecionada;
 void _iniciarJogo() {
 if (_temaSelecionado != null && _dificuldadeSelecionada != null) {
  Navigator.pushNamed(context, '/jogo', arguments: {
    'tema': _temas.firstWhere((t) => t.nome == _temaSelecionado),
    'totalCartas': _dificuldadeSelecionada,
  });
 }
 }
 @override
 Widget build(BuildContext context) {
 // UI da tela de menu (já pronta)
 return Scaffold(
 appBar: AppBar(title: const Text('Jogo da Memória')),
 body: Padding(
 padding: const EdgeInsets.all(20.0),
 child: Column(
 children: [
 const Text('1. Escolha a Dificuldade', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
 Row(
 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
 children: _dificuldades.keys.map((dificuldade) {
 return ChoiceChip(
 label: Text(dificuldade),
 selected: _dificuldadeSelecionada == _dificuldades[dificuldade],
 onSelected: (selected) {
 setState(() { _dificuldadeSelecionada = _dificuldades[dificuldade]; });
 },
 );
 }).toList(),
 ),
 const SizedBox(height: 20),
 const Text('2. Escolha o Tema', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

 Expanded(
    child: GridView.count(
       crossAxisCount: 2,
       crossAxisSpacing: 10,
       mainAxisSpacing: 10,
       children: _temas.map((tema) {
          return GestureDetector(
             onTap: () {
                setState(() {
                   _temaSelecionado = tema.nome;
                });
             },
             child: Card(
               color: _temaSelecionado == tema.nome ? Colors.purple.shade100 : Colors.white,
               child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Icon(tema.icone, size: 40, color: Colors.purple),
                     const SizedBox(height: 10),
                     Text(tema.nome, style: const TextStyle(fontSize: 16)),
                  ],
               ),
             ),
           );
       }).toList(),
     ),
  ),

 const SizedBox(height: 20),
 ElevatedButton(onPressed: _iniciarJogo, child: const Text('INICIAR JOGO')),
 ],
 ),
 ),
 );
 }
}
// ------------------- TELA DO JOGO -------------------
class TelaJogo extends StatefulWidget {
 const TelaJogo({super.key});
 @override
 State<TelaJogo> createState() => _TelaJogoState();
}
class _TelaJogoState extends State<TelaJogo> {
 // Variáveis de estado do jogo
 List<CartaMemoria> _cartas = [];
 List<int> _indicesVirados = [];
 bool _travado = false; // Trava o tabuleiro enquanto 2 cartas são avaliadas
 // Lógica de inicialização do jogo
 @override
 void didChangeDependencies() {
 super.didChangeDependencies();
 _iniciarJogo();
 }
 void _iniciarJogo() {
 final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String,
dynamic>;
 final Tema tema = args['tema'];
 final int totalCartas = args['totalCartas'];

 List<CartaMemoria> pares = [];
 for (int i = 0; i < totalCartas / 2; i++) {
 pares.add(CartaMemoria(id: i, imagem: tema.imagens[i]));
 pares.add(CartaMemoria(id: i, imagem: tema.imagens[i]));
 }
 pares.shuffle();
 setState(() {
 _cartas = pares;
 });
 }
 // Lógica principal de verificação do jogo (já pronta e comentada)
 void _virarCarta(int index) {
 // Se o tabuleiro estiver travado, ou a carta já foi combinada, ou já está virada, não faz nada.
 if (_travado || _cartas[index].foiCombinada || _cartas[index].estaVirada) return;
 setState(() {
 // Vira a carta selecionada e a adiciona na lista de cartas viradas na jogada atual.
 _cartas[index].estaVirada = true;
 _indicesVirados.add(index);
 });
 // Se duas cartas foram viradas, verifica se são um par.
 if (_indicesVirados.length == 2) {
 // Trava o tabuleiro para o jogador não poder virar uma terceira carta.
 setState(() { _travado = true; });

 final int index1 = _indicesVirados[0];
 final int index2 = _indicesVirados[1];
 // Usa um timer para dar tempo do jogador ver a segunda carta.
 Timer(const Duration(seconds: 1), () {
 setState(() {
 if (_cartas[index1].id == _cartas[index2].id) {
 // Se as cartas são iguais, marca como combinadas.
 _cartas[index1].foiCombinada = true;
 _cartas[index2].foiCombinada = true;
 } else {
 // Se são diferentes, vira de volta.
 _cartas[index1].estaVirada = false;
 _cartas[index2].estaVirada = false;
 }
 // Limpa a lista de jogada e destrava o tabuleiro.
 _indicesVirados = [];
 _travado = false;
 });
 });
 }
 }
 @override
 Widget build(BuildContext context) {
 return Scaffold(
 appBar: AppBar(title: const Text('Jogo da Memória')),
 body: Padding(
 padding: const EdgeInsets.all(10.0),

 child: GridView.builder(
    itemCount: _cartas.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
       crossAxisCount: 4,
       crossAxisSpacing: 8,
       mainAxisSpacing: 8,
    ),
    itemBuilder: (context, index) {
       final carta = _cartas[index];
       return GestureDetector(
          onTap: () {
             _virarCarta(index);
          },
          child: Card(
             child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return RotationTransition(
                          turns: animation,
                          child: child,
                  );
                },
                child: (carta.estaVirada || carta.foiCombinada) ? Image.asset(carta.imagem, key: ValueKey('frente$index')) : Container(
                   key: ValueKey('verso$index'),
                   color: Colors.purple,
                   child: const Icon(Icons.question_mark, color: Colors.white, size: 50),
                ),
              ),
           ),
        );
     },
   ),

  ),
 );
 }
}