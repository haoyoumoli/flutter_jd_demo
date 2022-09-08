import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

///新品页面
class JDNewPage extends StatefulWidget {
  const JDNewPage({Key? key}) : super(key: key);

  @override
  State<JDNewPage> createState() => _JDNewPageState();
}

class _JDNewPageState extends State<JDNewPage> {
  @override
  Widget build(BuildContext context) {
    print("<新品>被构建了");
    return const Scaffold(
      body: Center(
        child: Text('新品'),
      ),
    );
  }
}
