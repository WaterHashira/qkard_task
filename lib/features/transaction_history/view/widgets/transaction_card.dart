import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:qkard_task/features/payment/user_transaction.dart';
import 'package:qkard_task/theme/color_constants.dart';

class TransactionCard extends StatelessWidget {
  final UserTransaction transaction;
  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: ExpansionTileCard(
          initiallyExpanded: true,
          baseColor: ColorConstants.accentGreen,
          expandedColor: ColorConstants.green,
          title: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white, width: 0.5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  transaction.userName!,
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text(
                  '\$${transaction.totalAmount!}',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 15,
                  ),
                  moreDetailsCardBuilder('Sub Total Amount',
                      transaction.subTotalAmount.toString(), context),
                  const SizedBox(
                    height: 10,
                  ),
                  moreDetailsCardBuilder('Country',
                      transaction.addressCountry ?? 'Not Available', context),
                  const SizedBox(
                    height: 10,
                  ),
                  moreDetailsCardBuilder('State',
                      transaction.addressState ?? 'Not Available', context),
                  const SizedBox(
                    height: 10,
                  ),
                  moreDetailsCardBuilder('City',
                      transaction.addressCity ?? 'Not Available', context),
                  const SizedBox(
                    height: 10,
                  ),
                  moreDetailsCardBuilder('Street',
                      transaction.addressStreet ?? 'Not Available', context),
                  const SizedBox(
                    height: 10,
                  ),
                  moreDetailsCardBuilder('Zip Code',
                      transaction.addressZipCode ?? 'Not Available', context),
                  const SizedBox(
                    height: 10,
                  ),
                  moreDetailsCardBuilder(
                      'Phone Number',
                      transaction.addressPhoneNumber ?? 'Not Available',
                      context),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
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
