import 'package:flutter/material.dart';

class ContainerAll extends StatelessWidget {
  final Widget child;

  const ContainerAll({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: this.child,
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration( 
        color: Color.fromARGB(128, 235, 229, 229),
        borderRadius: BorderRadius.circular(20),
      )
    );
  }
}