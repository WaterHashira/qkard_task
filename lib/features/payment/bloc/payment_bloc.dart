import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qkard_task/features/payment/payment_repository.dart';
import 'package:qkard_task/features/payment/user_transaction.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository _repo;

  PaymentBloc(this._repo) : super(const PaymentInitial()) {
    on<PaymentRequested>(_onPaymentRequested);
  }

  void _onPaymentRequested(
    PaymentRequested event,
    Emitter<PaymentState> emit,
  ) async {
    emit(const PaymentLoading());
    try {
      await _repo.saveTransaction(transaction: event.transaction);
      emit(const PaymentSuccess());
    } catch (e) {
      emit(PaymentFailure(e.toString()));
      addError(e);
    }
  }
}
