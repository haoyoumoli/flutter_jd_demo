import 'package:flutter/material.dart';

// class LazyLoadOffstage extends StatelessWidget {
//   final Widget? Function() lazyLoader;
//   final bool Function() needDisplayGetter;
//   final Widget? loadedChild;
//   const LazyLoadOffstage(
//       {Key? key,
//       required this.lazyLoader,
//       required this.needDisplayGetter,
//       required this.loadedChild})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     bool display = needDisplayGetter();
//     return Offstage(
//         offstage: !display,
//         child: (loadedChild == null && display) ? lazyLoader() : loadedChild);
//   }
// }

Widget LazyLoadOffstage(
    {required Widget? Function() lazyLoader,
    required bool Function() needDisplayGetter,
    required Widget? loadedChild}) {
  bool display = needDisplayGetter();
  return Offstage(
      offstage: !display,
      child: (loadedChild == null && display) ? lazyLoader() : loadedChild);
}
