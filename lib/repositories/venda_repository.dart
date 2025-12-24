import '../services/firestore_service.dart';

class VendaRepository {
  final FirestoreService _service = FirestoreService.instance;

  Future<void> criarVenda({
    required String produtoNome,
    required String comandaId,
    required String vendedorNome,
    required int quantidade,
    required double precoUnitario,
    double desconto = 0.0,
  }) {
    return _service.criarVenda(
      produtoNome: produtoNome,
      comandaId: comandaId,
      vendedorNome: vendedorNome,
      quantidade: quantidade,
      precoUnitario: precoUnitario,
      desconto: desconto,
    );
  }
}
