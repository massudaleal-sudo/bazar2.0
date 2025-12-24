import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/venda_repository.dart';
import 'venda_state.dart';

class VendaCubit extends Cubit<VendaState> {
  final VendaRepository repository;

  VendaCubit(this.repository) : super(VendaInitial());

  Future<void> registrarVenda({
    required String produtoNome,
    required String comandaId,
    required String vendedorNome,
    required int quantidade,
    required double precoUnitario,
    double desconto = 0.0,
  }) async {
    emit(VendaLoading());

    try {
      await repository.criarVenda(
        produtoNome: produtoNome,
        comandaId: comandaId,
        vendedorNome: vendedorNome,
        quantidade: quantidade,
        precoUnitario: precoUnitario,
        desconto: desconto,
      );

      emit(VendaSuccess());
    } catch (e) {
      emit(VendaError(e.toString()));
    }
  }
}
