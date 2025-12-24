import 'package:flutter/material.dart';
import '../../../services/firestore_service.dart';

class CadastrarProdutoPage extends StatefulWidget {
  const CadastrarProdutoPage({super.key});

  @override
  State<CadastrarProdutoPage> createState() => _CadastrarProdutoPageState();
}

class _CadastrarProdutoPageState extends State<CadastrarProdutoPage> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _valorController = TextEditingController();
  final _colaboradorIdController = TextEditingController();
  final _colaboradorNomeController = TextEditingController();

  bool _loading = false;

  Future<void> _salvarProduto() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      await FirestoreService.instance.criarProduto(
        nome: _nomeController.text.trim(),
        valor: double.parse(_valorController.text),
        colaboradorId: _colaboradorIdController.text.trim(),
        colaboradorNome: _colaboradorNomeController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Produto cadastrado com sucesso')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar produto: $e')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _valorController.dispose();
    _colaboradorIdController.dispose();
    _colaboradorNomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome do produto'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Informe o nome' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _valorController,
                decoration: const InputDecoration(labelText: 'Valor'),
                keyboardType: TextInputType.number,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Informe o valor' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _colaboradorNomeController,
                decoration:
                    const InputDecoration(labelText: 'Nome do colaborador'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Informe o colaborador' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _colaboradorIdController,
                decoration:
                    const InputDecoration(labelText: 'ID do colaborador'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _loading ? null : _salvarProduto,
                child: _loading
                    ? const CircularProgressIndicator()
                    : const Text('Salvar Produto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
