import 'package:flutter/material.dart';
import 'package:qkard_task/features/account_details/view/account_details_screen.dart';
import 'package:qkard_task/features/recurring_payments/view/recurring_payments_screen.dart';
import 'package:qkard_task/features/transaction_history/view/transaction_history_screen.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          label: '',
          icon: IconButton(
            icon: const Icon(
              Icons.book,
              color: Colors.white,
            ),
            onPressed: () =>
                Navigator.pushNamed(context, AccountDetailsScreen.id),
          ),
          activeIcon: const Icon(
            Icons.book,
            color: Colors.white,
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: IconButton(
            icon: const Icon(
              Icons.history,
              color: Colors.white,
            ),
            onPressed: () =>
                Navigator.pushNamed(context, TransactionHistoryScreen.id),
          ),
          activeIcon: const Icon(
            Icons.history,
            color: Colors.white,
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: IconButton(
            icon: const Icon(
              Icons.payment,
              color: Colors.white,
            ),
            onPressed: () =>
                Navigator.pushNamed(context, RecurringPaymentsScreen.id),
          ),
          activeIcon: const Icon(
            Icons.payment,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
