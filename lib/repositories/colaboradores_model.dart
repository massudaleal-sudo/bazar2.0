import 'package:cloud_firestore/cloud_firestore.dart';

class ColaboradorModel {
  final String id;
  final String nome;
  final String status;
  final Timestamp dataCadastro;

  ColaboradorModel({
    required this.id,
    required this.nome,
    required this.status,
    required this.dataCadastro,
  });

  factory ColaboradorModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return ColaboradorModel(
      id: doc.id,
      nome: data['nome'],
      status: data['status'],
      dataCadastro: data['dataCadastro'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'status': status,
      'dataCadastro': dataCadastro,
    };
  }
}
