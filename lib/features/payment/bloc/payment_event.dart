part of 'payment_bloc.dart';

abstract class PaymentEvent {
  const PaymentEvent();
}

class PaymentRequested extends PaymentEvent {
  final UserTransaction transaction;

  const PaymentRequested({
    required this.transaction,
  });
}
