part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class LoginRequested extends LoginEvent {
  const LoginRequested({
    required this.emailAddress,
    required this.password,
  });

  final String emailAddress;
  final String password;
}
