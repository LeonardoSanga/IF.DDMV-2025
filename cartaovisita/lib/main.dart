// Importa o pacote principal do Material Design, que contém os widgets que vamos usar.
import 'package:flutter/material.dart';

// A função main() é o ponto de entrada de todo aplicativo Dart.
// O Flutter inicia a execução a partir daqui.
void main() {
  // runApp() é a função que infla o widget principal e o anexa à tela.
  runApp(MeuApp());
}

// Criamos nosso widget principal como um StatelessWidget, pois a estrutura
// do nosso aplicativo não mudará de estado.
class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MaterialApp é o widget raiz que configura nossa aplicação para usar o Material Design.
    return MaterialApp(
      // A propriedade 'home' define qual será a tela inicial do nosso app.
      home: Scaffold(
        // 'backgroundColor' define a cor de fundo para o corpo (body) do Scaffold.
        backgroundColor: Colors.teal,
        // 'body' é o conteúdo principal da tela. Usaremos um SafeArea para garantir
        // que nosso layout não seja cortado por entalhes (notches) ou barras do sistema.
        body: SafeArea(
          // Substituímos o Center por uma Column para organizar os widgets verticalmente.
          child: Column(
            // 'mainAxisAlignment: MainAxisAlignment.center' alinha os filhos da Column
            // no centro do eixo vertical (o centro da tela).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // CircleAvatar é um widget pronto para exibir avatares circulares.
              // É perfeito para fotos de perfil.
              CircleAvatar(
                radius: 60.0, // Define o raio (tamanho) do círculo.
                backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/109951?v=4',
                ), // Carrega uma imagem da internet.
              ),
              // Widget de Texto para o nome.
              Text(
                'Linus Torvalds',
                style: TextStyle(
                  // fontFamily: 'Pacifico', // Usaremos uma fonte customizada (a ser adicionada)
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Widget de Texto para o cargo.
              Text(
                'CRIADOR DO LINUX E DO GIT',
                style: TextStyle(
                  // fontFamily: 'Source Sans Pro', // Outra fonte customizada
                  color: Colors.teal.shade100,
                  fontSize: 20.0,
                  letterSpacing: 2.5, // Aumenta o espaçamento entre as letras.
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Um SizedBox é usado aqui como uma linha divisória invisível para criar espaço.
              // A 'width' de 150 e 'height' de 20 cria o espaço.
              SizedBox(
                height: 20.0,
                width: 150.0,
                child: Divider(
                  // O widget Divider desenha uma linha fina.
                  color: Colors.teal.shade100,
                ),
              ),

              // O primeiro cartão de contato (Telefone).
              // Usamos um widget Card para um visual mais agradável, que já vem com sombra e bordas arredondadas.
              Card(
                // 'margin' cria um espaçamento externo, afastando o cartão das bordas da tela e do item acima.
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  // ListTile é um widget otimizado para linhas com ícones e texto.
                  leading: Icon(
                    // 'leading' é o widget que fica à esquerda.
                    Icons.phone,
                    color: Colors.teal,
                  ),
                  title: Text(
                    // 'title' é o widget principal, geralmente o texto.
                    '+55 17 12345 6789',
                    style: TextStyle(
                      color: Colors.teal.shade900,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              // O segundo cartão de contato (E-mail).
              Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(Icons.email, color: Colors.teal),
                  title: Text(
                    'linus.torvalds@kernel.org',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.teal.shade900,
                      fontFamily: 'Source Sans Pro',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Esta linha remove a faixa de "DEBUG" do canto da tela.
      debugShowCheckedModeBanner: false,
    );
  }
}
