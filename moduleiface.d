module deject.moduleiface;

import deject.detail.binding;
import deject.detail.bindingkey;

import std.variant;

interface Module {
  void addBindingsToMap(Variant[BindingKey] bindingMap);
}
