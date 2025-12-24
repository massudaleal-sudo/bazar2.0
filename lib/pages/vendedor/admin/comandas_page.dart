import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'pacotes_comanda_page.dart';

class ComandasPage extends StatelessWidget {
  const ComandasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comandas'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('comandas')
            .orderBy('dataCriacao', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar comandas'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Nenhuma comanda encontrada'),
            );
          }

          final comandas = snapshot.data!.docs;

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: comandas.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final doc = comandas[index];
              final data = doc.data() as Map<String, dynamic>;

              final codigo = data['codigo'] ?? 'Sem código';
              final status = data['status'] ?? 'aberta';

              final bool ativa = status == 'aberta';

              return Card(
                elevation: 3,
                child: ListTile(
                  leading: Icon(
                    ativa ? Icons.lock_open : Icons.lock,
                    color: ativa ? Colors.green : Colors.red,
                  ),
                  title: Text(
                    'Comanda $codigo',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    ativa ? 'Ativa' : 'Fechada',
                    style: TextStyle(
                      color: ativa ? Colors.green : Colors.red,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PacotesComandaPage(
                          comandaId: doc.id,
                          codigoComanda: codigo,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
