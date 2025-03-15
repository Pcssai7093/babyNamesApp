import 'package:flutter/material.dart';

class navbar extends StatelessWidget {
  const navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).viewPadding.top,
      ),
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border(
          // top: BorderSide(color: Colors.blue, width: 10),
          // left: BorderSide(color: Colors.green, width: 10),
          // right: BorderSide(color: Colors.orange, width: 10),
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        )
      ),// Takes full available width
    );
  }
}
