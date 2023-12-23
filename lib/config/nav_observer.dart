import 'package:flutter/material.dart';

typedef NavObserverCallback = void Function(
  Route<dynamic>? route,
  Route<dynamic>? previousRoute,
);

class MyNavObserver extends NavigatorObserver {
  final List<NavObserverCallback> _didPushCallbacks = [];
  final List<NavObserverCallback> _didPopCallbacks = [];
  final List<NavObserverCallback> _didRemoveCallbacks = [];
  final List<NavObserverCallback> _didReplaceCallbacks = [];

  void addDidPushCallback(NavObserverCallback callback) {
    _didPushCallbacks.add(callback);
  }

  void addDidPopCallback(NavObserverCallback callback) {
    _didPopCallbacks.add(callback);
  }

  void addDidRemoveCallback(NavObserverCallback callback) {
    _didRemoveCallbacks.add(callback);
  }

  void addDidReplaceCallback(NavObserverCallback callback) {
    _didReplaceCallbacks.add(callback);
  }

  void removeDidPushCallback(NavObserverCallback callback) {
    _didPushCallbacks.remove(callback);
  }

  void removeDidPopCallback(NavObserverCallback callback) {
    _didPopCallbacks.remove(callback);
  }

  void removeDidRemoveCallback(NavObserverCallback callback) {
    _didRemoveCallbacks.remove(callback);
  }

  void removeDidReplaceCallback(NavObserverCallback callback) {
    _didReplaceCallbacks.remove(callback);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint(
        'MyNavObserver - didPush: ${route.str}, previousRoute= ${previousRoute?.str}');
    for (final callback in _didPushCallbacks) {
      callback(route, previousRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint(
        'MyNavObserver - didPop: ${route.str}, previousRoute= ${previousRoute?.str}');
    for (final callback in _didPopCallbacks) {
      callback(route, previousRoute);
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint(
        'MyNavObserver - didRemove: ${route.str}, previousRoute= ${previousRoute?.str}');
    for (final callback in _didRemoveCallbacks) {
      callback(route, previousRoute);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    debugPrint(
        'MyNavObserver - didReplace: new= ${newRoute?.str}, old= ${oldRoute?.str}');
    for (final callback in _didReplaceCallbacks) {
      callback(newRoute, oldRoute);
    }
  }

  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    debugPrint('MyNavObserver - didStartUserGesture: ${route.str}, '
        'previousRoute= ${previousRoute?.str}');
  }

  @override
  void didStopUserGesture() {
    debugPrint('MyNavObserver - didStopUserGesture');
  }
}

extension on Route<dynamic> {
  String get str => 'route(${settings.name}: ${settings.arguments})';
}
