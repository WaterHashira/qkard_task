part of 'recurring_payment_bloc.dart';

abstract class RecurringPaymentEvent {
  const RecurringPaymentEvent();
}

//for paying
class RecurringPaymentPay extends RecurringPaymentEvent {
  final UserTransaction transaction;

  const RecurringPaymentPay({
    required this.transaction,
  });
}

//for scheduling
class RecurringPaymentSchedule extends RecurringPaymentEvent {
  final Map<String, dynamic> recurringPaymentTransaction;

  const RecurringPaymentSchedule({
    required this.recurringPaymentTransaction,
  });
}

//for getting all of the scheduled
class RecurringPaymentsRequest extends RecurringPaymentEvent {
  const RecurringPaymentsRequest();
}
