import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qkard_task/features/payment/user_transaction.dart';
import 'package:qkard_task/utils/notification_service.dart';

class RecurringPaymentRepository {
  final firestoreInstance = FirebaseFirestore.instance;
  final firebaseAuthInstance = FirebaseAuth.instance;

  Future<void> saveTransaction({required UserTransaction transaction}) async {
    try {
      //saving the user transaction info in the Firestore database

      await firestoreInstance
          .collection('users_transaction_history')
          .doc(firebaseAuthInstance.currentUser!.email.toString())
          .collection('user_transaction_history')
          .add({
        'total_amount': transaction.totalAmount,
        'sub_total_amount': transaction.subTotalAmount,
        'user_name': transaction.userName,
        'address_city': transaction.addressCity,
        'address_street': transaction.addressStreet,
        'address_zip_code': transaction.addressZipCode,
        'address_country': transaction.addressCountry,
        'address_state': transaction.addressState,
        'address_phone_number': transaction.addressPhoneNumber
      });
    } catch (e) {
      throw Exception(e);
    }
  }

//schedule
  Future<void> scheduleTransaction(
      {required Map<String, dynamic> scheduledTransaction}) async {
    try {
      //saving the user transaction info in the Firestore database

      await firestoreInstance
          .collection('users_scheduled_transactions')
          .doc(firebaseAuthInstance.currentUser!.email.toString())
          .collection('user_scheduled_transactions')
          .add({
        'id': scheduledTransaction['id'],
        'schedule_date': scheduledTransaction['schedule_date'],
        'term': scheduledTransaction['term'],
        'total_amount': scheduledTransaction['transaction'].totalAmount,
        'sub_total_amount': scheduledTransaction['transaction'].subTotalAmount,
        'user_name': scheduledTransaction['transaction'].userName,
        'address_city': scheduledTransaction['transaction'].addressCity,
        'address_street': scheduledTransaction['transaction'].addressStreet,
        'address_zip_code': scheduledTransaction['transaction'].addressZipCode,
        'address_country': scheduledTransaction['transaction'].addressCountry,
        'address_state': scheduledTransaction['transaction'].addressState,
        'address_phone_number':
            scheduledTransaction['transaction'].addressPhoneNumber,
      });
    } catch (e) {
      throw Exception(e);
    }
  }

//get all scheduled transactions
  Future<List<Map<String, dynamic>>> getScheduledTransactions() async {
    try {
      //saving the user transaction info in the Firestore database

      List<Map<String, dynamic>> userTransactions = [];
      await firestoreInstance
          .collection('users_scheduled_transactions')
          .doc(firebaseAuthInstance.currentUser!.email.toString())
          .collection('user_scheduled_transactions')
          .get()
          .then((transactionsQuery) {
        for (var doc in transactionsQuery.docs) {
          Map<String, dynamic> userTransaction = {};
          UserTransaction transaction =
              UserTransaction.fromSnapshot(doc.data());
          userTransaction['id'] = doc.data()['id'];
          userTransaction['schedule_date'] = doc.data()['schedule_date'];
          userTransaction['term'] = doc.data()['term'];
          userTransaction['transaction'] = transaction;

          userTransactions.add(userTransaction);
        }
      });

      return userTransactions;
    } catch (e) {
      throw Exception(e);
    }
  }

  //deleting the doc with the given id
  Future<void> deleteTransaction(int id) async {
    await firestoreInstance
        .collection('users_transaction_history')
        .doc(firebaseAuthInstance.currentUser!.email.toString())
        .collection('user_transaction_history')
        .where('id', isEqualTo: id)
        .get()
        .then((snapshot) async {
      for (DocumentSnapshot ds in snapshot.docs) {
        await ds.reference.delete();
      }
    });

    await NotificationService().cancelNotifications(id);
  }
}
