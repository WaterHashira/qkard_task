import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qkard_task/features/payment/user_transaction.dart';
import 'package:qkard_task/features/transaction_history/transaction_history_repository.dart';

part 'transaction_history_event.dart';
part 'transaction_history_state.dart';

class TransactionHistoryBloc
    extends Bloc<TransactionHistoryEvent, TransactionHistoryState> {
  final TransactionHistoryRepository _repo;

  TransactionHistoryBloc(this._repo)
      : super(const TransactionHistoryInitial()) {
    on<TransactionHistoryRequested>(_onTransactionHistoryRequested);
  }

  void _onTransactionHistoryRequested(
    TransactionHistoryRequested event,
    Emitter<TransactionHistoryState> emit,
  ) async {
    emit(const TransactionHistoryLoading());
    try {
      List<UserTransaction> transactionsList =
          await _repo.getTransactions(currentUserEmail: event.currentUserEmail);
      emit(TransactionHistorySuccess(userTransactionList: transactionsList));
    } catch (e) {
      emit(TransactionHistoryFailure(e.toString()));
      addError(e);
    }
  }
}
