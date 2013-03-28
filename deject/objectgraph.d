module deject.objectgraph;

import deject.bindingmodule;
import deject.moduleanalysis;
import deject.detail.binding;
import deject.detail.bindingkey;
import deject.detail.bindingmap;
import deject.detail.linker;

import std.stdio;

class ObjectGraph(DModule...) {
  static this() {
    foreach (dmodule ; DModule) {
      foreach (injectedClass ; InjectedClassesInModule!dmodule) {
        writefln("yay");
      }
    }
  }

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

unittest {
  assert(isModule!(deject.objectgraph));
  assert(!isModule!(ObjectGraph));
}
