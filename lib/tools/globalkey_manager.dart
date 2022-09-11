import 'package:flutter/material.dart';

///管理一系列Globalkey,提供增删改查方法
class GlobalKeyManager {
  Map<dynamic, GlobalKey> _store = <dynamic, GlobalKey>{};

  ///请求一个GlobalKey,如果不存在回创建一个
  ///GlobalKey保存在store中,使用key进行查找
  GlobalKey requestAndCache(key) {
    GlobalKey? result = _store[key];
    if (result == null) {
      _store[key] = GlobalKey();
    }
    return _store[key]!;
  }

  ///使用key查找GlobalKey
  GlobalKey? get(key) {
    return _store[key];
  }

  ///更新key对应的GlobalKey
  void set({required GlobalKey value, required dynamic key}) {
    _store[key] = value;
  }

  ///删除key对应的GlobalKey
  void remove(key) {
    _store.remove(key);
  }

  ///清楚所有GlobalKey
  void clear() {
    _store.clear();
  }
}
