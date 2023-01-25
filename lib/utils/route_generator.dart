import 'package:flutter/material.dart';
import 'package:qkard_task/features/account_details/view/account_details_screen.dart';
import 'package:qkard_task/features/login/view/login_screen.dart';
import 'package:qkard_task/features/payment/view/payment_screen.dart';
import 'package:qkard_task/features/recurring_payments/view/manage_payments_screen.dart';
import 'package:qkard_task/features/recurring_payments/view/recurring_payments_screen.dart';
import 'package:qkard_task/features/signup/view/signup_screen.dart';
import 'package:qkard_task/features/transaction_history/view/transaction_history_screen.dart';
import 'package:qkard_task/utils/logger.dart';

class RouteGenerator {
  static const initialRoute = LoginScreen.id;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as dynamic;
    log<RouteGenerator>(msg: "Pushed ${settings.name}(${args ?? ''})");
    switch (settings.name) {
      case LoginScreen.id:
        return _route(LoginScreen());
      case SignUpScreen.id:
        return _route(SignUpScreen());
      case PaymentScreen.id:
        return _route(PaymentScreen());
      case TransactionHistoryScreen.id:
        return _route(TransactionHistoryScreen());
      case RecurringPaymentsScreen.id:
        return _route(const RecurringPaymentsScreen());
      case ManagePaymentsScreen.id:
        return _route(ManagePaymentsScreen(
          userTransactionsList: args['userTransactionsList'],
        ));
      case AccountDetailsScreen.id:
        return _route(const AccountDetailsScreen());
      default:
        return _errorRoute(settings.name);
    }
  }

  static MaterialPageRoute _route(Widget widget) => MaterialPageRoute(
        builder: (_) => widget,
      );

  static Route<dynamic> _errorRoute(String? name) {
    return _route(
      Scaffold(
        body: Center(
          child: Text('ROUTE\n\n$name\n\nNOT FOUND'),
        ),
      ),
    );
  }
}
