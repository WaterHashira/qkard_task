part of 'payment_bloc.dart';

abstract class PaymentState {
  const PaymentState();
}

class PaymentInitial extends PaymentState {
  const PaymentInitial();
}

class PaymentLoading extends PaymentState {
  const PaymentLoading();
}

class PaymentSuccess extends PaymentState {
  const PaymentSuccess();
}

class PaymentFailure extends PaymentState {
  final String err;
  const PaymentFailure(this.err);
}
