import 'package:cad_usuarios/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends InheritedWidget {
  final Widget child;
  List<User> users = [];
  User? userSelected;
  int? indexUser;

  UserProvider(
    {
      required this.child,
    }
  ) : super(child: child);

  static UserProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserProvider>();
  }

  bool updateShouldNotify(UserProvider oldWidget) {
    return true;
  }
}