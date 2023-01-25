part of 'recurring_payment_bloc.dart';

abstract class RecurringPaymentState {
  const RecurringPaymentState();
}

class RecurringPaymentInitial extends RecurringPaymentState {
  const RecurringPaymentInitial();
}

//paying
class RecurringPaymentLoading extends RecurringPaymentState {
  const RecurringPaymentLoading();
}

class RecurringPaymentSuccess extends RecurringPaymentState {
  const RecurringPaymentSuccess();
}

class RecurringPaymentFailure extends RecurringPaymentState {
  final String err;
  const RecurringPaymentFailure(this.err);
}

//schedule
class RecurringPaymentScheduleSuccess extends RecurringPaymentState {
  const RecurringPaymentScheduleSuccess();
}

class RecurringPaymentScheduleFailure extends RecurringPaymentState {
  final String err;
  const RecurringPaymentScheduleFailure(this.err);
}

//get all scheduled payments
class GetRecurringPaymentSuccess extends RecurringPaymentState {
  final List<Map<String, dynamic>> userTransactions;
  const GetRecurringPaymentSuccess({required this.userTransactions});
}

class GetRecurringPaymentFailure extends RecurringPaymentState {
  final String err;
  const GetRecurringPaymentFailure(this.err);
}
