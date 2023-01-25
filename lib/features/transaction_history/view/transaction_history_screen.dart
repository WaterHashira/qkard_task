import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qkard_task/features/payment/user_transaction.dart';
import 'package:qkard_task/features/transaction_history/bloc/transaction_history_bloc.dart';
import 'package:qkard_task/features/transaction_history/transaction_history_repository.dart';
import 'package:qkard_task/features/transaction_history/view/widgets/transaction_card.dart';
import 'package:qkard_task/widgets/custom_bottom_navigation_bar.dart';
import 'package:qkard_task/widgets/loading_overlay.dart';

import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable
class TransactionHistoryScreen extends StatelessWidget {
  static const id = 'TransactionHistoryScreen';

  TransactionHistoryScreen({super.key});

  final firebaseAuthInstance = FirebaseAuth.instance;

  List<UserTransaction> transactionsList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider<TransactionHistoryBloc>(
        create: (_) => TransactionHistoryBloc(TransactionHistoryRepository())
          ..add(TransactionHistoryRequested(
              currentUserEmail: firebaseAuthInstance.currentUser)),
        child: BlocConsumer<TransactionHistoryBloc, TransactionHistoryState>(
          listener: (context, state) {
            if (state is TransactionHistorySuccess) {
              transactionsList = state.userTransactionList;
            }
          },
          builder: (context, state) {
            return LoadingOverlay(
              isLoading: state is TransactionHistoryLoading,
              child: Scaffold(
                bottomNavigationBar: CustomBottomNavigationBar(),
                appBar: AppBar(
                  title: const Text('Transaction History'),
                ),
                body: (state is TransactionHistoryFailure)
                    ? Container(
                        child: const Text('Something went wrong!'),
                      )
                    : Container(
                        padding: const EdgeInsets.all(10),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: transactionsList.length,
                          itemBuilder: ((context, index) {
                            return Column(
                              children: <Widget>[
                                SizedBox(
                                  //TODO: make the list dynamically adjust whenever this widget expands
                                  height: 300,
                                  child: TransactionCard(
                                      transaction: transactionsList[index]),
                                ),
                                const SizedBox(
                                  height: 15,
                                )
                              ],
                            );
                          }),
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
