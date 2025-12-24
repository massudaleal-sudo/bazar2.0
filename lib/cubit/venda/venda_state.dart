abstract class VendaState {}

class VendaInitial extends VendaState {}

class VendaLoading extends VendaState {}

class VendaSuccess extends VendaState {}

class VendaError extends VendaState {
  final String message;
  VendaError(this.message);
}
