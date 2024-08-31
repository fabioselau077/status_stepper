import 'package:flutter/material.dart';

class StepperConnector extends StatelessWidget {
  final bool isPassed;
  final bool shouldRedraw;
  final int delayFactor;
  final Duration animationDuration;
  final Duration animationAwaitDuration;
  final Color? activeColor;
  final Color? disabledColor;
  final Curve curve;
  final double connectorThickness;

  const StepperConnector({
    Key? key,
    required this.isPassed,
    required this.delayFactor,
    required this.shouldRedraw,
    required this.animationDuration,
    required this.curve,
    required this.connectorThickness,
    this.animationAwaitDuration = Duration.zero,
    this.activeColor,
    this.disabledColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Divider(
            thickness: connectorThickness,
            color: disabledColor ??
                Theme.of(context).colorScheme.secondaryContainer,
          ),
          FutureBuilder(
            future: Future.delayed(
              animationDuration * delayFactor + animationAwaitDuration,
            ),
            builder: (context, snapshot) => AnimatedSwitcher(
              switchInCurve: curve,
              transitionBuilder: (child, animation) => SizeTransition(
                sizeFactor: animation,
                child: child,
                axis: Axis.horizontal,
              ),
              duration: animationDuration,
              child: isPassed &&
                          snapshot.connectionState == ConnectionState.done ||
                      !shouldRedraw
                  ? Divider(
                      thickness: connectorThickness,
                      color: activeColor ?? Theme.of(context).primaryColor,
                    )
                  : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
