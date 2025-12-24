import 'package:cloud_firestore/cloud_firestore.dart';

class ComandaModel {
  final String id;
  final String codigo;
  final String status; // aberta | fechada
  final double total;
  final Timestamp dataCriacao;
  final Timestamp? dataFechamento;

  ComandaModel({
    required this.id,
    required this.codigo,
    required this.status,
    required this.total,
    required this.dataCriacao,
    this.dataFechamento,
  });

  factory ComandaModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return ComandaModel(
      id: doc.id,
      codigo: data['codigo'],
      status: data['status'],
      total: (data['total'] as num).toDouble(),
      dataCriacao: data['dataCriacao'],
      dataFechamento: data['dataFechamento'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'status': status,
      'total': total,
      'dataCriacao': dataCriacao,
      'dataFechamento': dataFechamento,
    };
  }
}
