import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qkard_task/features/signup/signup_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpRepository _repo;

  SignUpBloc(this._repo) : super(const SignUpInitial()) {
    on<SignUpRequested>(_onSignUpRequested);
  }

  void _onSignUpRequested(
    SignUpRequested event,
    Emitter<SignUpState> emit,
  ) async {
    emit(const SignUpLoading());
    try {
      await _repo.SignUpUser(
          emailAddress: event.emailAddress,
          password: event.password,
          userAccountNumber: event.userAccountNumber,
          userName: event.userName);
      emit(const SignUpSuccess());
    } catch (e) {
      emit(SignUpFailure(e.toString()));
      addError(e);
    }
  }
}
