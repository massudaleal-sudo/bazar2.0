import 'package:flutter/material.dart';
import '../../../services/firestore_service.dart';

class CadastrarColaboradorPage extends StatefulWidget {
  const CadastrarColaboradorPage({super.key});

  @override
  State<CadastrarColaboradorPage> createState() =>
      _CadastrarColaboradorPageState();
}

class _CadastrarColaboradorPageState extends State<CadastrarColaboradorPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();

  bool _loading = false;

  Future<void> _salvarColaborador() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      await FirestoreService.instance.criarColaborador(
        nome: _nomeController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Colaborador cadastrado com sucesso')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao cadastrar colaborador: $e')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Colaborador'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome do colaborador',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o nome do colaborador';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _salvarColaborador,
                  child: _loading
                      ? const CircularProgressIndicator()
                      : const Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
