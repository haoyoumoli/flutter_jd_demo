import 'package:flutter/foundation.dart';

class NewGoodsModel extends ChangeNotifier {
  bool _isFollowing = true;

  set isFollowing(bool value) {
    _isFollowing = value;
    notifyListeners();
  }

  bool get isFollowing => _isFollowing;
}
