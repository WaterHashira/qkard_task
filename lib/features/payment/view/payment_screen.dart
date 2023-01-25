import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:qkard_task/features/account_details/view/account_details_screen.dart';
import 'package:qkard_task/features/payment/bloc/payment_bloc.dart';
import 'package:qkard_task/features/payment/payment_repository.dart';
import 'package:qkard_task/features/payment/user_transaction.dart';
import 'package:qkard_task/utils/generics.dart';
import 'package:qkard_task/widgets/custom_bottom_navigation_bar.dart';
import 'package:qkard_task/widgets/custom_snack_bar.dart';
import 'package:qkard_task/widgets/input_field.dart';
import 'package:qkard_task/widgets/loading_overlay.dart';

class PaymentScreen extends StatelessWidget {
  static const id = 'PaymentScreen';

  PaymentScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UserTransaction transaction =
        UserTransaction(null, null, null, null, null, null, null, null, null);

    /*  final String totalAmount;
  final String subTotalAmount;
  final String userName;
  final String addressCity;
  final String addressStreet;
  final String addressZipCode;
  final String addressCountry;
  final String addressState;
  final String addressPhoneNumber; */

    return SafeArea(
      child: BlocProvider(
        create: (_) => PaymentBloc(PaymentRepository()),
        child: BlocConsumer<PaymentBloc, PaymentState>(
          listener: (context, state) {
            if (state is PaymentSuccess) {
              showSuccessSnackBar('Payment successful!');
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      payPalWidget(transaction)));
            } else {
              showErrorSnackBar('Payment Falied! Please try again');
            }
          },
          builder: (context, state) {
            return LoadingOverlay(
              isLoading: state is PaymentLoading,
              child: Scaffold(
                appBar: AppBar(),
                bottomNavigationBar: const CustomBottomNavigationBar(),
                body: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Text(
                            'Pay Money',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          const SizedBox(height: 30),
                          InputField(
                            title: 'Amount*',
                            validator: (v) {
                              if (isNullOrBlank(v)) {
                                return 'Please enter a valid Amount!';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            onChanged: (v) =>
                                transaction.totalAmount = double.parse(v!),
                          ),
                          const SizedBox(height: 30),
                          InputField(
                            title: 'Subtotal Amount*',
                            validator: (v) {
                              if (isNullOrBlank(v)) {
                                return 'Please enter a valid Amount!';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            onChanged: (v) =>
                                transaction.subTotalAmount = double.parse(v!),
                          ),
                          const SizedBox(height: 30),
                          InputField(
                            title: 'Name*',
                            validator: (v) {
                              if (isNullOrBlank(v)) {
                                return 'Please enter a valid Name!';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                            onChanged: (v) => transaction.userName = v!.trim(),
                          ),
                          const SizedBox(height: 30),
                          InputField(
                            title: 'Address Street Name*',
                            validator: (v) {
                              if (isNullOrBlank(v)) {
                                return 'Please enter a valid address!';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.streetAddress,
                            onChanged: (v) =>
                                transaction.addressStreet = v!.trim(),
                          ),
                          const SizedBox(height: 30),
                          InputField(
                            title: 'Address City Name*',
                            validator: (v) {
                              if (isNullOrBlank(v)) {
                                return 'Please enter a valid address!';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                            onChanged: (v) =>
                                transaction.addressCity = v!.trim(),
                          ),
                          const SizedBox(height: 30),
                          InputField(
                            title: 'Address State Name*',
                            validator: (v) {
                              if (isNullOrBlank(v)) {
                                return 'Please enter a valid address!';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                            onChanged: (v) =>
                                transaction.addressState = v!.trim(),
                          ),
                          const SizedBox(height: 30),
                          InputField(
                            title: 'Address Country Code*',
                            validator: (v) {
                              if (isNullOrBlank(v)) {
                                return 'Please enter a valid Country Code!';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                            onChanged: (v) =>
                                transaction.addressCountry = v!.trim(),
                          ),
                          const SizedBox(height: 30),
                          InputField(
                            title: 'Address Zip Code*',
                            validator: (v) {
                              if (isNullOrBlank(v)) {
                                return 'Please enter a valid Zip Code!';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            onChanged: (v) =>
                                transaction.addressZipCode = v!.trim(),
                          ),
                          const SizedBox(height: 30),
                          InputField(
                            title: 'Address Phone Number*',
                            validator: (v) {
                              if (isNullOrBlank(v)) {
                                return 'Please enter a valid Phone Number!';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            onChanged: (v) =>
                                transaction.addressPhoneNumber = v!.trim(),
                          ),
                          const SizedBox(height: 25),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<PaymentBloc>(
                                  context,
                                  listen: false,
                                ).add(
                                  PaymentRequested(transaction: transaction),
                                );
                              }
                            },
                            child: const Text('Pay'),
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: (() => Navigator.pushNamed(
                                context, AccountDetailsScreen.id)),
                            child: const Text('Account Details'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  //takes to paypal payment screen with given details
  Widget payPalWidget(UserTransaction transaction) {
    return UsePaypal(
        sandboxMode: true,
        clientId:
            "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
        secretKey:
            "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
        returnURL: "https://samplesite.com/return",
        cancelURL: "https://samplesite.com/cancel",
        transactions: [
          {
            "amount": {
              "total": transaction.totalAmount.toString(),
              "currency": "USD",
              "details": {
                "subtotal": transaction.subTotalAmount.toString(),
                "shipping": '0',
                "shipping_discount": 0
              }
            },
            "description": "The payment transaction description.",
            // "payment_options": {
            //   "allowed_payment_method":
            //       "INSTANT_FUNDING_SOURCE"
            // },
            "item_list": {
              "items": [
                {
                  "name": "A demo product",
                  "quantity": 1,
                  "price": transaction.totalAmount.toString(),
                  "currency": "USD"
                }
              ],

              // shipping address is not required though
              "shipping_address": {
                "recipient_name": transaction.userName,
                "line1": transaction.addressStreet,
                "line2": "",
                "city": transaction.addressCity,
                "country_code": transaction.addressCountry,
                "postal_code": transaction.addressZipCode,
                "phone": transaction.addressPhoneNumber,
                "state": transaction.addressState
              },
            }
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          //TODO: save transactions in database according to the response, success or faliure
          print('$params');
        },
        onError: (error) {
          print("onError: $error");
        },
        onCancel: (params) {
          print('cancelled: $params');
        });
  }
}
