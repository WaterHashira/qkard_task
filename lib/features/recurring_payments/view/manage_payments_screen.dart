import 'package:flutter/material.dart';
import 'package:qkard_task/features/recurring_payments/view/widgets/recurring_payment_card.dart';
import 'package:qkard_task/widgets/custom_bottom_navigation_bar.dart';

class ManagePaymentsScreen extends StatelessWidget {
  static const id = 'ManagePaymentsScreen';

  final List<Map<String, dynamic>> userTransactionsList;
  const ManagePaymentsScreen({super.key, required this.userTransactionsList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Scheduled Payments'),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: userTransactionsList.length,
          itemBuilder: (context, index) {
            return (userTransactionsList.isEmpty)
                ? const SizedBox(
                    child: Center(child: Text('No data Found')),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      RecurringPaymentCard(
                          scheduledTransaction: userTransactionsList[index]),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }
}
