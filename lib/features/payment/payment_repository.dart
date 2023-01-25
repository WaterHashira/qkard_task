import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qkard_task/features/payment/user_transaction.dart';

class PaymentRepository {
  Future<void> saveTransaction({required UserTransaction transaction}) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final firebaseAuthInstance = FirebaseAuth.instance;

    print(
        'SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS');

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
      print(
          'ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd');
    } catch (e) {
      throw Exception(e);
    }
  }
}
