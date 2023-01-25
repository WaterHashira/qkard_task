part of 'signup_bloc.dart';

abstract class SignUpEvent {
  const SignUpEvent();
}

class SignUpRequested extends SignUpEvent {
  const SignUpRequested({
    required this.emailAddress,
    required this.password,
    required this.userAccountNumber,
    required this.userName,
  });

  final String emailAddress;
  final String password;
  final String userAccountNumber;
  final String userName;
}
