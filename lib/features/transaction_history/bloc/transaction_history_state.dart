part of 'transaction_history_bloc.dart';

abstract class TransactionHistoryState {
  const TransactionHistoryState();
}

class TransactionHistoryInitial extends TransactionHistoryState {
  const TransactionHistoryInitial();
}

class TransactionHistoryLoading extends TransactionHistoryState {
  const TransactionHistoryLoading();
}

class TransactionHistorySuccess extends TransactionHistoryState {
  final List<UserTransaction> userTransactionList;
  const TransactionHistorySuccess({required this.userTransactionList});
}

class TransactionHistoryFailure extends TransactionHistoryState {
  final String err;
  const TransactionHistoryFailure(this.err);
}
