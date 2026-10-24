import 'package:cad_usuarios/provider.dart';
import 'package:cad_usuarios/user.view.dart';
import 'package:cad_usuarios/user_form.dart';
import 'package:cad_usuarios/user_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());

  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return UserProvider (
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'cadastro de usuarios',
        home: UserForm(),
        routes: {
          "/create": (_) => UserForm(),
          "/list": (_) => UserList(),
          "/view": (_) => UserView(),

          //lista de usuarios
        },
      ),
    );
  }
}

