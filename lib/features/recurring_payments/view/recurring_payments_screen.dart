import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:qkard_task/features/payment/user_transaction.dart';
import 'package:qkard_task/features/recurring_payments/bloc/recurring_payment_bloc.dart';
import 'package:qkard_task/features/recurring_payments/recurring_payment_repository.dart';
import 'package:qkard_task/features/recurring_payments/view/manage_payments_screen.dart';
import 'package:qkard_task/utils/generics.dart';
import 'package:qkard_task/utils/notification_service.dart';
import 'package:qkard_task/utils/value_holder.dart';
import 'package:qkard_task/widgets/custom_bottom_navigation_bar.dart';
import 'package:qkard_task/widgets/custom_snack_bar.dart';
import 'package:qkard_task/widgets/input_field.dart';
import 'package:qkard_task/widgets/loading_overlay.dart';

class RecurringPaymentsScreen extends StatefulWidget {
  static const id = 'RecurringPaymentsScreen';

  const RecurringPaymentsScreen({super.key});

  @override
  State<RecurringPaymentsScreen> createState() =>
      _RecurringPaymentsScreenState();
}

class _RecurringPaymentsScreenState extends State<RecurringPaymentsScreen> {
  final _formKey = GlobalKey<FormState>();

  UserTransaction transaction =
      UserTransaction(null, null, null, null, null, null, null, null, null);

  DateTime selectedDate = DateTime.now();

  String datePickerTitle = 'Select*';

  String dropdownvalue = 'Daily';

  String paymentDescription = '';

  // List of items in our dropdown menu
  List<String> dropDownOptionList = ['Daily', 'Weekly'];

  Map<String, dynamic> scheduledTransaction = {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (_) => RecurringPaymentBloc(RecurringPaymentRepository()),
        child: BlocConsumer<RecurringPaymentBloc, RecurringPaymentState>(
          listener: (context, state) {
            if (state is RecurringPaymentSuccess) {
              showSuccessSnackBar('Payment successful!');
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      payPalWidget(transaction)));
            } else if (state is RecurringPaymentFailure) {
              showErrorSnackBar('Payment Falied! Please try again');
            } else if (state is RecurringPaymentScheduleSuccess) {
              showSuccessSnackBar('Scheduling successful!');
            } else if (state is RecurringPaymentScheduleFailure) {
              showSuccessSnackBar('Scheduling Failed! Please try again');
            } else if (state is GetRecurringPaymentSuccess) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ManagePaymentsScreen(
                          userTransactionsList: state.userTransactions)));
            } else if (state is GetRecurringPaymentFailure) {
              showSuccessSnackBar('Scheduling Failed! Please try again');
            }
          },
          builder: (context, state) {
            return LoadingOverlay(
              isLoading: state is RecurringPaymentLoading,
              child: Scaffold(
                appBar: AppBar(),
                bottomNavigationBar: const CustomBottomNavigationBar(),
                body: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Text(
                            'Schedule Recurring Payments',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              ElevatedButton(
                                child: Text(datePickerTitle),
                                onPressed: () async {
                                  await _selectDate(context);
                                  DateTime date = DateTime(selectedDate.year,
                                      selectedDate.month, selectedDate.day);
                                  setState(() {
                                    datePickerTitle = date.toString();
                                  });
                                },
                              ),
                              DropdownButton(
                                value: dropdownvalue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: dropDownOptionList.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue = newValue!;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          InputField(
                            title: 'Payment Description*',
                            validator: (v) {
                              if (isNullOrBlank(v)) {
                                return 'Please enter a valid Description!';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                            onChanged: (v) => paymentDescription = v!.trim(),
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
                          Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  InkWell(
                                    child: TextButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          BlocProvider.of<RecurringPaymentBloc>(
                                            context,
                                            listen: false,
                                          ).add(
                                            RecurringPaymentPay(
                                                transaction: transaction),
                                          );
                                        }
                                      },
                                      child: const Text('Pay'),
                                    ),
                                  ),
                                  InkWell(
                                    child: TextButton(
                                      child: const Text('Schedule'),
                                      onPressed: () async {
                                        ValueHolder.scheduledTransactionId += 1;
                                        scheduledTransaction['id'] =
                                            ValueHolder.scheduledTransactionId;
                                        scheduledTransaction['scheduleDate'] =
                                            selectedDate;
                                        scheduledTransaction['term'] =
                                            dropdownvalue;
                                        scheduledTransaction['transaction'] =
                                            transaction;

                                        if (_formKey.currentState!.validate()) {
                                          BlocProvider.of<RecurringPaymentBloc>(
                                            context,
                                            listen: false,
                                          ).add(
                                            RecurringPaymentSchedule(
                                                recurringPaymentTransaction:
                                                    scheduledTransaction),
                                          );
                                        }

                                        await NotificationService()
                                            .addNotification(
                                                id: ValueHolder
                                                    .scheduledTransactionId,
                                                title: 'Due Payment',
                                                body: paymentDescription,
                                                term: dropdownvalue,
                                                channel: 'testing');
                                      },
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                child: TextButton(
                                  child:
                                      const Text('Manage Scheduled Payments'),
                                  onPressed: () {
                                    BlocProvider.of<RecurringPaymentBloc>(
                                      context,
                                      listen: false,
                                    ).add(const RecurringPaymentsRequest());
                                  },
                                ),
                              ),
                            ],
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
        onSuccess: (Map params) async {},
        onError: (error) {},
        onCancel: (params) {});
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: currentDate,
        lastDate: DateTime(currentDate.year, currentDate.month + 2));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
