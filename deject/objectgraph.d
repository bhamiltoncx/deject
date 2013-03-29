module deject.objectgraph;

import deject.bindingmodule;
import deject.detail.binding;
import deject.detail.bindingkey;
import deject.detail.bindingmap;
import deject.detail.linker;
import deject.detail.objectgraphgetimpl;

import std.stdio;

class ObjectGraph(DModule...) {
  static BindingMap compileTimeBindingMap;

  this(BindingModule[] bindingModules ...) {
    BindingMap bindingMap;

    foreach (bindingModule ; bindingModules) {
      bindingModule.addBindingsToMap(bindingMap);
    }

    linker = new Linker(bindingMap);
  }

  T get(T)() {
    // To allow for template specialization, we pass in a dummy value
    // of type T.
    return getImpl!(T)(cast(T)null);
  }

  mixin ObjectGraphGetImplForModules!(DModule);

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
