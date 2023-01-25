import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qkard_task/widgets/custom_bottom_navigation_bar.dart';

class AccountDetailsScreen extends StatefulWidget {
  static const id = 'AccountDetailsScreen';

  const AccountDetailsScreen({super.key});

  @override
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  Map<String, dynamic>? userDetails = {};

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Details'),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                moreDetailsCardBuilder('User Name',
                    userDetails!['name'] ?? 'Not Available', context),
                const SizedBox(
                  height: 15,
                ),
                moreDetailsCardBuilder('User Name',
                    userDetails!['account_number'] ?? 'Not Available', context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getUserDetails() async {
    final firestoreInstance = FirebaseFirestore.instance;
    final firebaseAuthInstance = FirebaseAuth.instance;

    var userDetailsMap = await firestoreInstance
        .collection('user')
        .doc(firebaseAuthInstance.currentUser!.email)
        .get()
        .then((doc) => doc.data());

    setState(() {
      userDetails = userDetailsMap;
    });
  }

  Widget moreDetailsCardBuilder(
      String heading, String value, BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            heading,
            style: Theme.of(context).textTheme.headline3,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.headline3,
          ),
        ],
      ),
    );
  }
}
