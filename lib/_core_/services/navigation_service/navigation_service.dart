import 'package:flutter/material.dart';

export 'routes.dart';

class NavigationService {
  static final _navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  static BuildContext? get currentContext => _navigatorKey.currentContext;

  void goBack() {
    navigatorKey.currentState!.pop();
  }

  void navigateTo({
    required Widget destinationScreen,
    int animationDuration = 400,
    SlideDirection direction = SlideDirection.right,
  }) {
    Route pageTransition = animatedTransition(
      animationDuration: animationDuration,
      destinationScreen: destinationScreen,
      direction: direction,
    );

    navigatorKey.currentState!.push(pageTransition);
  }

  void navigateToAndRemoveAll({
    required Widget destinationScreen,
    int animationDuration = 500,
    SlideDirection direction = SlideDirection.right,
  }) {
    Route pageTransition = animatedTransition(
      animationDuration: animationDuration,
      destinationScreen: destinationScreen,
      direction: direction,
    );

    navigatorKey.currentState!.pushAndRemoveUntil(
      pageTransition,
      (Route<dynamic> route) => false,
    );
  }
}

Route animatedTransition({
  required Widget destinationScreen,
  int animationDuration = 400,
  required SlideDirection direction,
}) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: animationDuration),
    pageBuilder: (context, animation, secondaryAnimation) => destinationScreen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      Offset begin = getOffset(direction);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}

enum SlideDirection { left, top, right, bottom }

Offset getOffset(SlideDirection direction) {
  switch (direction) {
    case SlideDirection.left:
      return const Offset(-1.0, 0.0);
    case SlideDirection.top:
      return const Offset(0.0, -1.0);
    case SlideDirection.right:
      return const Offset(1.0, 0.0);
    case SlideDirection.bottom:
      return const Offset(0.0, 1.0);
  }
}

final navigationService = NavigationService();
