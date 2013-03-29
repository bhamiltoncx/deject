module deject.detail.autobinding;

import std.stdio;
import std.typetuple;

import deject.detail.binding;
import deject.detail.linker;
import deject.detail.moduleanalysis;

string generateBindingsForModules(DModule...)() {
  string bindings;

  foreach (dmodule ; DModule) {
    // TODO: Just calling InjectedClassesInModule!(dmodule) hits a
    // compiler error: Error: template instance
    // InjectedClassesInModule!(dmodule) template
    // 'InjectedClassesInModule' is not defined
    foreach (klass ; deject.detail.moduleanalysis.InjectedClassesInModule!(dmodule)) {
      auto bindingType = klass.stringof;
      bindings ~= bindingType ~ " get(" ~ bindingType ~ ")() {\n"
        ~ "  return new " ~ bindingType ~ "();\n"
        ~ "}\n";
    }
  }

  return bindings;
}

mixin template AutoBindingsForModules(DModule...) {
  mixin generateBindingsForModules!(DModule);
}

