import 'package:flutter/material.dart';

class NavHelper {
  static push(BuildContext ctx, String routeName, {Object? args}) {
    Navigator.of(ctx).pushNamed(routeName, arguments: args);
  }

  static replace(BuildContext ctx, String routeName, {Object? args}) {
    Navigator.of(ctx).pushReplacementNamed(routeName, arguments: args);
  }

  static pop(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }
}
