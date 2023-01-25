import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qkard_task/features/payment/user_transaction.dart';

class TransactionHistoryRepository {
  Future<List<UserTransaction>> getTransactions(
      {required var currentUserEmail}) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final firebaseAuthInstance = FirebaseAuth.instance;

    print(
        'SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS');

    try {
      //saving the user transaction info in the Firestore database

      List<UserTransaction> userTransactions = await firestoreInstance
          .collection('users_transaction_history')
          .doc(firebaseAuthInstance.currentUser!.email.toString())
          .collection('user_transaction_history')
          .get()
          .then((transactionsQuery) {
        return transactionsQuery.docs
            .map((transaction) =>
                UserTransaction.fromSnapshot(transaction.data()))
            .toList();
      });
      print(
          'ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd');

      return userTransactions;
    } catch (e) {
      throw Exception(e);
    }
  }
}
