import 'package:flutter/material.dart';

extension Ext on GlobalKey {
  ///获取特定类型的RenderObject,如果类型不匹配返回null
  T? getRenderObjectOfType<T>() {
    var context = currentContext;
    var renderObject = context?.findRenderObject();
    if (renderObject is T) {
      return renderObject as T;
    }
    return null;
  }
}

R? typeAs<T, R>(T obj) {
  if (obj is R) {
    return obj;
  }
  return null;
}
