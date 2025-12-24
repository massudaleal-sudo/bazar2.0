import 'package:cloud_firestore/cloud_firestore.dart';

class ProdutoModel {
  final String id;
  final String nome;
  final double valor;
  final String colaboradorId;
  final String colaboradorNome;
  final bool ativo;
  final Timestamp dataCadastro;

  ProdutoModel({
    required this.id,
    required this.nome,
    required this.valor,
    required this.colaboradorId,
    required this.colaboradorNome,
    required this.ativo,
    required this.dataCadastro,
  });

  factory ProdutoModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return ProdutoModel(
      id: doc.id,
      nome: data['nome'],
      valor: (data['valor'] as num).toDouble(),
      colaboradorId: data['colaboradorId'],
      colaboradorNome: data['colaboradorNome'],
      ativo: data['ativo'],
      dataCadastro: data['dataCadastro'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'valor': valor,
      'colaboradorId': colaboradorId,
      'colaboradorNome': colaboradorNome,
      'ativo': ativo,
      'dataCadastro': dataCadastro,
    };
  }
}
