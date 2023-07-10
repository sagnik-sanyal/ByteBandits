//Extension on BuildContext to navigate to a new screen
import 'package:flutter/material.dart';

extension NavigationExt on BuildContext {
  ///Pop the screen safely from the navigation stack
  void pop<T extends Object?>([T? result]) {
    if (Navigator.canPop(this)) {
      Navigator.of(this).pop<T>(result);
    }
  }

  ///Push to a new screen using navigator 1.0 api
  Future<T?> push<T extends Object?>(Widget route) =>
      Navigator.of(this).push<T>(MaterialPageRoute<T>(
        builder: (_) => route,
      ));

  ///Push Replacement to a new screen using navigator 1.0 api
  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
          Widget route) =>
      Navigator.of(this).pushReplacement<T, TO>(MaterialPageRoute<T>(
        builder: (_) => route,
      ));

  /// Pushes a new route onto the navigator 2.0 pushNamed
  /// [routeName] is the name of the route to push
  /// [arguments] is the arguments to pass to the route
  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(this).pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  /// Pushes a new route onto the navigator 2.0 pushReplacementNamed
  /// [routeName] is the name of the route to push
  /// [arguments] is the arguments to pass to the route
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
      String routeName,
      {Object? arguments,
      TO? result}) {
    return Navigator.of(this).pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  /// Pushes a new route onto the navigator 2.0 pushNamedAndRemoveUntil
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String routeName,
    RoutePredicate predicate, {
    Object? arguments,
  }) =>
      Navigator.of(this).pushNamedAndRemoveUntil<T>(
        routeName,
        predicate,
        arguments: arguments,
      );

  /// Calls [Navigator.popUntil] with the given [predicate].
  void popUntil(bool Function(Route<dynamic>) predicate) {
    Navigator.of(this).popUntil(predicate);
  }
}
