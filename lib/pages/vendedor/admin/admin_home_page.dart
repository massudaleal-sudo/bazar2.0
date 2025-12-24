import 'package:bazar_app/pages/vendedor/admin/cadastrar_colaborador_page.dart';
import 'package:flutter/material.dart';
import 'package:bazar_app/pages/vendedor/admin/cadastrar_produto_page.dart';
import 'package:bazar_app/pages/vendedor/admin/comandas_page.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel do Administrador'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _MenuCard(
              icon: Icons.receipt_long,
              title: 'Comandas',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ComandasPage(),
                  ),
                );
              },
            ),
            _MenuCard(
              icon: Icons.people,
              title: 'Cadastrar Colaboradores',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CadastrarColaboradorPage(),
                  ),
                );
              },
            ),
            _MenuCard(
              icon: Icons.inventory_2,
              title: 'Cadastrar Produtos',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CadastrarProdutoPage(),
      ),
    );
  },
),

            _MenuCard(
              icon: Icons.bar_chart,
              title: 'Relatórios',
              onTap: () {
                // Futuro
              },
            ),
          ],
        ),
      ),
    );
  }
}
class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
