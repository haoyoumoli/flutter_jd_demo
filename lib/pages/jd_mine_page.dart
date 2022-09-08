import 'package:flutter/material.dart';

class JDMinePage extends StatefulWidget {
  const JDMinePage({Key? key}) : super(key: key);

  @override
  State<JDMinePage> createState() => _JDMinePageState();
}

class _JDMinePageState extends State<JDMinePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("<我的>页面被构建了");
    return const Scaffold(
      body: Center(
        child: Text('我的'),
      ),
    );
  }
}
