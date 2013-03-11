module deject.detail.linker;

import deject.detail.binding;
import deject.detail.bindingkey;
import deject.detail.bindingmap;

import std.conv;
import std.stdio;

class Linker {
  this(BindingMap newBindingMap) {
    bindingMap = newBindingMap;
  }

  Binding!T requestBinding(T)() {
    BindingKey key = { typeid(T) };
    auto variant = bindingMap[key];
    auto binding = variant.get!(Binding!T);
    if (key !in linkedBindings) {
      binding.attach(this);
      linkedBindings[key] = true;
    }
    return binding;
  }

  private BindingMap bindingMap;
  private bool[BindingKey] linkedBindings;
}
