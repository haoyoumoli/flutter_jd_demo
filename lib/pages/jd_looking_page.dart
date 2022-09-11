import 'package:flutter/material.dart';

class JDLookingPage extends StatefulWidget {
  const JDLookingPage({Key? key}) : super(key: key);

  @override
  State<JDLookingPage> createState() => _JDLookingPageState();
}

class _JDLookingPageState extends State<JDLookingPage> {
  @override
  Widget build(BuildContext context) {
    print("<逛>被构建了");
    return const Scaffold(
      body: Center(
        child: Text('逛'),
      ),
    );
  }
}
