import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:qkard_task/features/recurring_payments/recurring_payment_repository.dart';
import 'package:qkard_task/features/recurring_payments/view/recurring_payments_screen.dart';
import 'package:qkard_task/theme/color_constants.dart';

class RecurringPaymentCard extends StatelessWidget {
  final Map<String, dynamic> scheduledTransaction;
  const RecurringPaymentCard({
    super.key,
    required this.scheduledTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: ExpansionTileCard(
          initiallyExpanded: true,
          leading: ElevatedButton(
            onPressed: () async {
              await RecurringPaymentRepository()
                  .deleteTransaction(scheduledTransaction['id']);

              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const RecurringPaymentsScreen()));
            },
            child: const Text('Delete'),
          ),
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
                  scheduledTransaction['transaction'].userName!,
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text(
                  '\$${scheduledTransaction['transaction'].totalAmount!}',
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
                  moreDetailsCardBuilder(
                      'Scheduled Date',
                      scheduledTransaction['schedule_date'].toString(),
                      context),
                  const SizedBox(
                    height: 10,
                  ),
                  moreDetailsCardBuilder(
                      'Term', scheduledTransaction['term'], context),
                  const SizedBox(
                    height: 10,
                  ),
                  moreDetailsCardBuilder(
                      'Sub Total Amount',
                      scheduledTransaction['transaction']
                          .subTotalAmount
                          .toString(),
                      context),
                  const SizedBox(
                    height: 10,
                  ),
                  moreDetailsCardBuilder(
                      'Country',
                      scheduledTransaction['transaction'].addressCountry ??
                          'Not Available',
                      context),
                  const SizedBox(
                    height: 10,
                  ),
                  moreDetailsCardBuilder(
                      'State',
                      scheduledTransaction['transaction'].addressState ??
                          'Not Available',
                      context),
                  const SizedBox(
                    height: 10,
                  ),
                  moreDetailsCardBuilder(
                      'City',
                      scheduledTransaction['transaction'].addressCity ??
                          'Not Available',
                      context),
                  const SizedBox(
                    height: 10,
                  ),
                  moreDetailsCardBuilder(
                      'Street',
                      scheduledTransaction['transaction'].addressStreet ??
                          'Not Available',
                      context),
                  const SizedBox(
                    height: 10,
                  ),
                  moreDetailsCardBuilder(
                      'Zip Code',
                      scheduledTransaction['transaction'].addressZipCode ??
                          'Not Available',
                      context),
                  const SizedBox(
                    height: 10,
                  ),
                  moreDetailsCardBuilder(
                      'Phone Number',
                      scheduledTransaction['transaction'].addressPhoneNumber ??
                          'Not Available',
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
