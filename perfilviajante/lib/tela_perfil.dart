import 'package:flutter/material.dart';

class TelaPerfil extends StatelessWidget {
  const TelaPerfil({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(

        children: [

          Container(
            height: 200.0,
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
            ),
          ),

          // Conteúdo principal
          Column(

            children: [
              const SizedBox(height: 200), 

              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),

                  child: Column(
                    children: [

                      Transform.translate(
                          offset: const Offset(0, -50),
                          child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: NetworkImage('https://avatars.githubusercontent.com/u/109951?v=4'),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Leonardo Sanga',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Fernandópolis, Brasil',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 24),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Column(
                            children: [
                              Text('16', 
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text('Fotos',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text('657', 
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text('Seguidores',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text('189', 
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text('Seguindo',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      Container(
                          height: 45,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Seguir',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                      Row(
                        children: [
                          Expanded(child: _FotoQuadrada(url: 'https://picsum.photos/200?1')),
                          const SizedBox(width: 4),
                          Expanded(child: _FotoQuadrada(url: 'https://picsum.photos/200?2')),
                          const SizedBox(width: 4),
                          Expanded(child: _FotoQuadrada(url: 'https://picsum.photos/200?3')),
                        ],
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FotoQuadrada extends StatelessWidget {
  final String url;

  const _FotoQuadrada({required this.url});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1, 
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}