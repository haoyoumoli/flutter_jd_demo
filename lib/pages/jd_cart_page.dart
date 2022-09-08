import 'package:flutter/material.dart';

class JDCartPage extends StatefulWidget {
  const JDCartPage({Key? key}) : super(key: key);

  @override
  State<JDCartPage> createState() => _JDCartPageState();
}

class _JDCartPageState extends State<JDCartPage> {
  @override
  Widget build(BuildContext context) {
    print("<购物车>页面被构建了");
    return const Scaffold(
      body: Center(
        child: Text('购物车'),
      ),
    );
  }
}
