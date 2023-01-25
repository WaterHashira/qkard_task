part of 'transaction_history_bloc.dart';

abstract class TransactionHistoryEvent {
  const TransactionHistoryEvent();
}

class TransactionHistoryRequested extends TransactionHistoryEvent {
  var currentUserEmail;

  TransactionHistoryRequested({
    required this.currentUserEmail,
  });
}
