import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService._();
  static final FirestoreService instance = FirestoreService._();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /* =========================================================
   * COLABORADORES
   * ========================================================= */

  Future<void> criarColaborador({
    required String nome,
  }) async {
    await _db.collection('colaboradores').add({
      'nome': nome,
      'status': 'ativo', // ativo | inativo
      'dataCadastro': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> streamColaboradoresAtivos() {
    return _db
        .collection('colaboradores')
        .where('status', isEqualTo: 'ativo')
        .snapshots();
  }

  /* =========================================================
   * PRODUTOS
   * ========================================================= */

  Future<void> criarProduto({
    required String nome,
    required double valor,
    required String colaboradorId,
    required String colaboradorNome,
  }) async {
    await _db.collection('produtos').add({
      'nome': nome,
      'valor': valor,
      'colaboradorId': colaboradorId,
      'colaboradorNome': colaboradorNome,
      'ativo': true,
      'dataCadastro': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> streamProdutosAtivos() {
    return _db
        .collection('produtos')
        .where('ativo', isEqualTo: true)
        .snapshots();
  }

  /* =========================================================
   * COMANDAS
   * ========================================================= */

  Future<String> criarComanda() async {
    final docRef = _db.collection('comandas').doc();

    await docRef.set({
      'codigo': docRef.id,
      'status': 'aberta', // aberta | fechada
      'total': 0.0,
      'dataCriacao': Timestamp.now(),
      'dataFechamento': null,
    });

    return docRef.id;
  }

  Future<void> fecharComanda(String comandaId) async {
    await _db.collection('comandas').doc(comandaId).update({
      'status': 'fechada',
      'dataFechamento': Timestamp.now(),
    });
  }

  

  Stream<QuerySnapshot> streamComandasAbertas() {
    return _db
        .collection('comandas')
        .where('status', isEqualTo: 'aberta')
        .snapshots();
  }
  

  /* =========================================================
   * VENDAS (MODELO FINAL)
   * ========================================================= */

  Future<void> criarVenda({
    required String produtoNome,
    required String vendedorNome,
    required String comandaId,
    required int quantidade,
    required double precoUnitario,
    double desconto = 0.0,
    double percentualRepasse = 0.10,
  }) async {
    if (quantidade <= 0) {
      throw Exception('Quantidade inválida');
    }

    final double valorBruto = precoUnitario * quantidade;
    final double valorTotal = valorBruto - desconto;
    final double repasse = valorTotal * percentualRepasse;

    // Cria venda
    await _db.collection('vendas').add({
      'produtoNome': produtoNome,
      'vendedorNome': vendedorNome,
      'comandaId': comandaId,
      'quantidade': quantidade,
      'precoUnitario': precoUnitario,
      'desconto': desconto,
      'valorTotal': valorTotal,
      'percentualRepasse': percentualRepasse,
      'repasse': repasse,
      'dataVenda': Timestamp.now(),
    });

    // Atualiza total da comanda
    await _db.collection('comandas').doc(comandaId).update({
      'total': FieldValue.increment(valorTotal),
    });
  }

  Stream<QuerySnapshot> streamVendasPorComanda(String comandaId) {
    return _db
        .collection('vendas')
        .where('comandaId', isEqualTo: comandaId)
        .orderBy('dataVenda')
        .snapshots();
  }

Future<void> recalcularTotalComanda(String comandaId) async {
  final vendasSnap = await _db
      .collection('vendas')
      .where('Comanda_ID', isEqualTo: comandaId)
      .get();

  double total = 0.0;

  for (var doc in vendasSnap.docs) {
    final data = doc.data();
    total += (data['Valor_Total_Venda'] ?? 0.0) as double;
  }

  await _db.collection('comandas').doc(comandaId).update({
    'total': total,
  });
}

  }

