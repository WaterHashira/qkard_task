import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    this.loaderColor,
    required this.isLoading,
    required this.child,
    Key? key,
  }) : super(key: key);

  final bool isLoading;
  final Color? loaderColor;
  final Widget child;

  static Color getOverlayColor(BuildContext context) =>
      Theme.of(context).colorScheme.primary.withOpacity(0.075);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !isLoading,
      child: Stack(
        children: [
          child,
          if (isLoading) ...[
            ModalBarrier(
              dismissible: false,
              color: getOverlayColor(context),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(
                color: loaderColor,
                minHeight: 1,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
            )
          ],
        ],
      ),
    );
  }
}
