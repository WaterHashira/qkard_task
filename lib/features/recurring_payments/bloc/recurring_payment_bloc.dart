import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qkard_task/features/payment/user_transaction.dart';
import 'package:qkard_task/features/recurring_payments/recurring_payment_repository.dart';

part 'recurring_payment_event.dart';
part 'recurring_payment_state.dart';

class RecurringPaymentBloc
    extends Bloc<RecurringPaymentEvent, RecurringPaymentState> {
  final RecurringPaymentRepository _repo;

  RecurringPaymentBloc(this._repo) : super(const RecurringPaymentInitial()) {
    on<RecurringPaymentPay>(_onRecurringPaymentPay);
    on<RecurringPaymentSchedule>(_onRecurringPaymentSchedule);
    on<RecurringPaymentsRequest>(_onRecurringPaymentsRequest);
  }

//payment
  void _onRecurringPaymentPay(
    RecurringPaymentPay event,
    Emitter<RecurringPaymentState> emit,
  ) async {
    emit(const RecurringPaymentLoading());
    try {
      await _repo.saveTransaction(transaction: event.transaction);
      emit(const RecurringPaymentSuccess());
    } catch (e) {
      emit(RecurringPaymentFailure(e.toString()));
      addError(e);
    }
  }

  //schedule
  void _onRecurringPaymentSchedule(
    RecurringPaymentSchedule event,
    Emitter<RecurringPaymentState> emit,
  ) async {
    emit(const RecurringPaymentLoading());
    try {
      await _repo.scheduleTransaction(
          scheduledTransaction: event.recurringPaymentTransaction);
      emit(const RecurringPaymentScheduleSuccess());
    } catch (e) {
      emit(RecurringPaymentScheduleFailure(e.toString()));
      addError(e);
    }
  }

  //get all
  void _onRecurringPaymentsRequest(
    RecurringPaymentsRequest event,
    Emitter<RecurringPaymentState> emit,
  ) async {
    emit(const RecurringPaymentLoading());
    try {
      List<Map<String, dynamic>> userTransactions =
          await _repo.getScheduledTransactions();
      emit(GetRecurringPaymentSuccess(userTransactions: userTransactions));
    } catch (e) {
      emit(GetRecurringPaymentFailure(e.toString()));
      addError(e);
    }
  }
}
