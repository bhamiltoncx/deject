module deject.objectgraph;

import deject.bindingmodule;
import deject.detail.autobinding;
import deject.detail.binding;
import deject.detail.bindingkey;
import deject.detail.bindingmap;
import deject.detail.linker;

import std.stdio;

class ObjectGraph(DModule...) {
  static BindingMap compileTimeBindingMap;

  mixin AutoBindingsForModules!(DModule);

  this(BindingModule[] bindingModules ...) {
    BindingMap bindingMap;

    foreach (bindingModule ; bindingModules) {
      bindingModule.addBindingsToMap(bindingMap);
    }

    linker = new Linker(bindingMap);
  }

  T get(T)() {
    return linker.requestBinding!T.get();
  }

  private Linker linker;
}

unittest {
  auto testModule = new class BindingModule {
    void addBindingsToMap(ref BindingMap bindingMap) {
      bindingMap[BindingKey(typeid(int))] = new class Binding!int {
        int get() { return 42; }
        void attach(Linker linker) { }
      };
    }
  };

  auto objectGraph = new ObjectGraph!()(testModule);
  assert(objectGraph.get!int == 42);
}
