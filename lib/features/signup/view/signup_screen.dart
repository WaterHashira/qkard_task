import 'package:qkard_task/features/login/view/login_screen.dart';
import 'package:qkard_task/features/payment/view/payment_screen.dart';
import 'package:qkard_task/features/signup/bloc/signup_bloc.dart';
import 'package:qkard_task/features/signup/signup_repository.dart';
import 'package:qkard_task/utils/generics.dart';
import 'package:qkard_task/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qkard_task/widgets/input_field.dart';
import 'package:qkard_task/widgets/loading_overlay.dart';

class SignUpScreen extends StatelessWidget {
  static const id = 'SignUpScreen';

  SignUpScreen({
    Key? key,
  }) : super(key: key);

  String emailAddress = '';
  String password = '';
  String userAccountNumber = '';
  String userName = '';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (_) => SignUpBloc(SignUpRepository()),
        child: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              showSuccessSnackBar('Account created in successfully!');
              Navigator.pushNamed(context, PaymentScreen.id);
            } else {
              showErrorSnackBar('SignUp Falied! Please try again');
            }
          },
          builder: (context, state) {
            return LoadingOverlay(
              isLoading: state is SignUpLoading,
              child: Scaffold(
                appBar: AppBar(),
                body: Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(15),
                    children: [
                      Text(
                        'Signup',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const SizedBox(height: 30),
                      InputField(
                        title: 'Email address',
                        keyboardType: TextInputType.emailAddress,
                        validator: validateEmail,
                        onChanged: (v) => emailAddress = v!.trim(),
                      ),
                      const SizedBox(height: 15),
                      InputField(
                        title: 'Password',
                        isSensitive: true,
                        validator: (v) {
                          if (isNullOrBlank(v)) {
                            return 'Please enter a valid password!';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (v) => password = v!,
                      ),
                      const SizedBox(height: 25),
                      InputField(
                        title: 'Username',
                        validator: (v) {
                          if (isNullOrBlank(v)) {
                            return 'Please enter a valid Username!';
                          }
                          return null;
                        },
                        onChanged: (v) => userName = v!.trim(),
                      ),
                      const SizedBox(height: 25),
                      InputField(
                        title: 'Account Number',
                        validator: (v) {
                          if (isNullOrBlank(v)) {
                            return 'Please enter a valid Account Number!';
                          }
                          return null;
                        },
                        onChanged: (v) => userAccountNumber = v!.trim(),
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<SignUpBloc>(
                              context,
                              listen: false,
                            ).add(
                              SignUpRequested(
                                  emailAddress: emailAddress,
                                  password: password,
                                  userAccountNumber: userAccountNumber,
                                  userName: userName),
                            );
                          }
                        },
                        child: const Text('SignUp'),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(
                              indent: 10,
                              endIndent: 10,
                              thickness: 1,
                            ),
                          ),
                          Text(
                            'or',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const Expanded(
                            child: Divider(
                              indent: 10,
                              endIndent: 10,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                            ),
                            onPressed: () => Navigator.pushReplacementNamed(
                              context,
                              LoginScreen.id,
                            ),
                            child: const Text('LogIn'),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
