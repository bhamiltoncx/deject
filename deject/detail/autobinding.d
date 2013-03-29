module deject.detail.autobinding;

import std.stdio;
import std.traits;
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
      auto t = fullyQualifiedName!(__traits(getMember, dmodule, klass.stringof));
      bindings ~= "private " ~ t ~ " getImpl(T:" ~ t ~ ")(T t) {\n"
        // XXX: This is a stub. We need to get the dependencies here and pass them to
        // the constructor.
        ~ "  return new " ~ t ~ "();\n"
        ~ "}\n";
    }
  }

  return bindings;
}

mixin template AutoBindingsForModules(DModule...) {
  // NOTE: The following does not work and returns a surprising error:
  // mixin generateBindingsForModules!(DModule)
  // Error: no property 'get' for type 'deject.test.testautobinding.TestAutobinding'
  //
  // mixin has two roles: one is to force compilation of a string, the other is
  // to insert a declaration in a different scope
  //
  // If it sees an open paren, it's sure it's an expression
  // Without parens, it just sees a string, ignores it. Should be an error or should
  // figure out it's an expression
  mixin(generateBindingsForModules!(DModule));
}
